# VS Code C++ Starter for Windows
This is a simple starter configuration for building C++ using VS Code using the g++ compiler. The key features of this template are:
* Uses make files for compilation
* Debugging works
* Testing framework included
## Make and make files
The makefile was tested to work using the bash shell. I don't think other shells will work. So set your default command shell to bash.
The make.exe command utility can be downloaded and installed separately from the compiler. But it also seems to be included in the compiler bin folder with the name mingw32-make.exe. So I just copied that file to the same bin folder with the name make.exe so it is easier to run.
## Testing
The template uses the test framework ***doctest*** (https://github.com/onqtam/doctest/blob/master/doc/markdown/readme.md#reference) which is super simple since you just include a single .h file to get it working.
Using this extension to easily find and run tests. (https://marketplace.visualstudio.com/items?itemName=matepek.vscode-catch2-test-adapter)
If the extension doesn't find your tests, make sure the search path is correct. In Settings, search for `testmate path`
## Build tasks (Ctrl+Shift+B)
Check these out. Several options easily accessible from the keyboard shortcut.
These are configured to work only if the default shell is bash.
Why is this not **bold**
