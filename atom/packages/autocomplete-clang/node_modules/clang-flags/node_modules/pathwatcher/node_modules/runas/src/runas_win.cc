#include "runas.h"

#include <windows.h>

namespace runas {

std::string QuoteCmdArg(const std::string& arg) {
  if (arg.size() == 0)
    return arg;

  // No quotation needed.
  if (arg.find_first_of(" \t\"") == std::string::npos)
    return arg;

  // No embedded double quotes or backlashes, just wrap quote marks around
  // the whole thing.
  if (arg.find_first_of("\"\\") == std::string::npos)
    return std::string("\"") + arg + '"';

  // Expected input/output:
  //   input : hello"world
  //   output: "hello\"world"
  //   input : hello""world
  //   output: "hello\"\"world"
  //   input : hello\world
  //   output: hello\world
  //   input : hello\\world
  //   output: hello\\world
  //   input : hello\"world
  //   output: "hello\\\"world"
  //   input : hello\\"world
  //   output: "hello\\\\\"world"
  //   input : hello world\
  //   output: "hello world\"
  std::string quoted;
  bool quote_hit = true;
  for (size_t i = arg.size(); i > 0; --i) {
    quoted.push_back(arg[i - 1]);

    if (quote_hit && arg[i - 1] == '\\') {
      quoted.push_back('\\');
    } else if (arg[i - 1] == '"') {
      quote_hit = true;
      quoted.push_back('\\');
    } else {
      quote_hit = false;
    }
  }

  return std::string("\"") + std::string(quoted.rbegin(), quoted.rend()) + '"';
}

bool Runas(const std::string& command,
           const std::vector<std::string>& args,
           const std::string& std_input,
           std::string* std_output,
           std::string* std_error,
           int options,
           int* exit_code) {
  CoInitializeEx(NULL, COINIT_APARTMENTTHREADED | COINIT_DISABLE_OLE1DDE);

  std::string parameters;
  for (size_t i = 0; i < args.size(); ++i)
    parameters += QuoteCmdArg(args[i]) + ' ';

  SHELLEXECUTEINFO sei = { sizeof(sei) };
  sei.fMask = SEE_MASK_NOASYNC | SEE_MASK_NOCLOSEPROCESS;
  sei.lpVerb = (options & OPTION_ADMIN) ? "runas" : "open";
  sei.lpFile = command.c_str();
  sei.lpParameters = parameters.c_str();
  sei.nShow = SW_NORMAL;

  if (options & OPTION_HIDE)
    sei.nShow = SW_HIDE;

  if (::ShellExecuteEx(&sei) == FALSE || sei.hProcess == NULL)
    return false;

  // Wait for the process to complete.
  ::WaitForSingleObject(sei.hProcess, INFINITE);

  DWORD code;
  if (::GetExitCodeProcess(sei.hProcess, &code) == 0)
    return false;

  *exit_code = code;
  return true;
}

}  // namespace runas
