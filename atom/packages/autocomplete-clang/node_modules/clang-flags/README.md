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
