#include "runas.h"

#include <errno.h>
#include <fcntl.h>
#include <Security/Authorization.h>
#include <sys/wait.h>

#include "fork.h"

namespace runas {

namespace {

AuthorizationRef g_auth = NULL;

OSStatus ExecuteWithPrivileges(AuthorizationRef authorization,
                               const std::string& command,
                               AuthorizationFlags options,
                               char* const* arguments,
                               FILE** pipe) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
  return AuthorizationExecuteWithPrivileges(authorization,
                                            command.c_str(),
                                            options,
                                            arguments,
                                            pipe);
#pragma clang diagnostic pop
}

}  // namespace

bool Runas(const std::string& command,
           const std::vector<std::string>& args,
           const std::string& std_input,
           std::string* std_output,
           std::string* std_error,
           int options,
           int* exit_code) {
  // Use fork when "admin" is false.
  if (!(options & OPTION_ADMIN))
    return Fork(command, args, std_input, std_output, std_error, options, exit_code);

  if (!g_auth && AuthorizationCreate(NULL,
                                     kAuthorizationEmptyEnvironment,
                                     kAuthorizationFlagDefaults,
                                     &g_auth) != errAuthorizationSuccess)
    return false;


  FILE* pipe;
  std::vector<char*> argv(StringVectorToCharStarVector(args));
  if (ExecuteWithPrivileges(g_auth,
                            command,
                            kAuthorizationFlagDefaults,
                            &argv[0],
                            &pipe) != errAuthorizationSuccess)
    return false;

  int pid = fcntl(fileno(pipe), F_GETOWN, 0);

  // Write to stdin.
  size_t want = std_input.size();
  if (want > 0) {
    const char*p = &std_input[0];
    while (true) {
      size_t r = fwrite(p, sizeof(*p), want, pipe);
      if (r == 0)
        break;
      want -= r;
      p += r;
    }
  }

  // Read from stdout.
  if (std_output) {
    char buffer[512];
    while (true) {
      size_t r = fread(buffer, sizeof(char), 512, pipe);
      if (r == 0)
        break;
      std_output->append(buffer, r);
    }
  }

  fclose(pipe);

  int r, status;
  do {
    r = waitpid(pid, &status, 0);
  } while (r == -1 && errno == EINTR);

  if (r == -1 || !WIFEXITED(status))
    return false;

  *exit_code = WEXITSTATUS(status);
  return true;
}

}  // namespace runas
