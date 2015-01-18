#ifndef SRC_FORK_H_
#define SRC_FORK_H_

#include <string>
#include <vector>

namespace runas {

std::vector<char*> StringVectorToCharStarVector(
    const std::vector<std::string>& args);

bool Fork(const std::string& command,
          const std::vector<std::string>& args,
          const std::string& std_input,
          std::string* std_output,
          std::string* std_error,
          int options,
          int* exit_code);

}  // namespace runas

#endif  // SRC_FORK_H_
