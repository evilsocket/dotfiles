# clang-flags package

Helper library for Atom to determine the clang compiler flags needed for a file.
This is useful if you want to write a completion, lint, or other clang-using
package.

## Supported Mechanisms

### .clang-complete

The .clang-complete is used by vim's clang-complete script. It contains all the
flags needed by a project, one flag per line. It's fairly coarse, not allowing
different flags per file, but is still easy to generate, and sufficient for
most projects.

### CompDB

CompDB is a JSON format for specifying the per-file compilation flags (http://clang.llvm.org/docs/JSONCompilationDatabase.html). Clang-flags will look for such a definition recursively up the tree in files called compile-commands.json, treating the location of such a file as the root of the project for relative paths. How to generate such a file depends on the build system in use - ninja and cmake can both generate them natively, and a tool called 'bear' can generate them for other build systems. For example, with ninja a command such as `ninja -t compdb cc cxx > compile_commands.json` might get you what you need.
