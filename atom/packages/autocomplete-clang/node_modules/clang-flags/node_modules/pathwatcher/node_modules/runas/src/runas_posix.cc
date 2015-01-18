#include "runas.h"

#include "fork.h"

namespace runas {

bool Runas(const std::string& command,
           const std::vector<std::string>& args,
           const std::string& std_input,
           std::string* std_output,
           std::string* std_error,
           int options,
           int* exit_code) {
  return Fork(command, args, std_input, std_output, std_error, options, exit_code);
}

}  // namespace runas
