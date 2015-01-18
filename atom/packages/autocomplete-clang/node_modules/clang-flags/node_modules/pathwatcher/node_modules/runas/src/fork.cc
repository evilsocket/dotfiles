#include "fork.h"

#include <errno.h>
#include <stdlib.h>
#include <stdio.h>

#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

namespace runas {

namespace {

void child(int* stdin_fds,
           int* stdout_fds,
           int* stderr_fds,
           const std::string& command,
           const std::vector<std::string>& args) {
  // Redirect stdin to the pipe.
  close(stdin_fds[1]);
  dup2(stdin_fds[0], 0);
  close(stdin_fds[0]);

  // Redirect stdout to the pipe.
  close(stdout_fds[0]);
  dup2(stdout_fds[1], 1);
  close(stdout_fds[1]);

  // Redirect stderr to the pipe.
  close(stderr_fds[0]);
  dup2(stderr_fds[1], 2);
  close(stderr_fds[1]);

  std::vector<char*> argv(StringVectorToCharStarVector(args));
  argv.insert(argv.begin(), const_cast<char*>(command.c_str()));

  execvp(command.c_str(), &argv[0]);
  perror("execvp()");
  exit(127);
}

int parent(int pid,
           int* stdin_fds, const std::string& std_input,
           int* stdout_fds, std::string* std_output,
           int* stderr_fds, std::string* std_error) {
  // Write string to child's stdin.
  int want = std_input.size();
  if (want > 0) {
    const char* p = std_input.data();
    close(stdin_fds[0]);
    while (want > 0) {
      int r = write(stdin_fds[1], p, want);
      if (r > 0) {
        want -= r;
        p += r;
      } else if (errno != EAGAIN && errno != EINTR) {
        break;
      }
    }
    close(stdin_fds[1]);
  }

  // Read from child's stdout
  close(stdout_fds[1]);
  if (std_output) {
    char buffer[512];
    while (true) {
      int r = read(stdout_fds[0], buffer, 512);
      if (r > 0)
        std_output->append(buffer, r);
      else if (errno != EAGAIN && errno != EINTR)
        break;
    }
  }
  close(stdout_fds[0]);


  // Read from child's stderr
  close(stderr_fds[1]);
  if (stderr_fds) {
    char buffer[512];
    while (true) {
      int r = read(stderr_fds[0], buffer, 512);
      if (r > 0)
        std_error->append(buffer, r);
      else if (errno != EAGAIN && errno != EINTR)
        break;
    }
  }
  close(stderr_fds[0]);

  // Wait for child.
  int r, status;
  do {
    r = waitpid(pid, &status, 0);
  } while (r == -1 && errno == EINTR);

  if (r == -1 || !WIFEXITED(status))
    return -1;

  return WEXITSTATUS(status);
}

}  // namespace


std::vector<char*> StringVectorToCharStarVector(
    const std::vector<std::string>& args) {
  std::vector<char*> argv(1 + args.size(), NULL);
  for (size_t i = 0; i < args.size(); ++i)
    argv[i] = const_cast<char*>(args[i].c_str());
  return argv;
}

bool Fork(const std::string& command,
          const std::vector<std::string>& args,
          const std::string& std_input,
          std::string* std_output,
          std::string* std_error,
          int options,
          int* exit_code) {
  int stdin_fds[2];
  if (pipe(stdin_fds) == -1)
    return false;

  int stdout_fds[2];
  if (pipe(stdout_fds) == -1)
    return false;

  int stderr_fds[2];
  if (pipe(stderr_fds) == -1)
    return false;

  // execvp
  int pid = fork();
  switch (pid) {
    case 0:  // child
      child(stdin_fds, stdout_fds, stderr_fds, command, args);
      break;

    case -1:  // error
      return false;

    default:  // parent
      *exit_code = parent(pid,
                          stdin_fds, std_input,
                          stdout_fds, std_output,
                          stderr_fds, std_error);
      return true;
  };

  return false;
}

}  // namespace runas
