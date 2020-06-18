# VS Code C++ Starter for Windows
This is a simple starter configuration for building C++ using VS Code using the g++ compiler. The key features are:
* Make files for compilation, with build results (.exe and .o files) in a subdirectory.
* Some preconfigured build tasks like clean and make all.
* Debugging works
* Testing framework included

This is good information from Microsoft for getting [started with C++ in VS Code](https://code.visualstudio.com/docs/cpp/config-mingw).

## Make files
The makefile was tested using the bash shell. I don't think other shells will work. So set your default command shell to bash.

The make.exe command utility can be downloaded and installed separately from the compiler. But it also seems to be included in the compiler bin folder with the name mingw32-make.exe. So I just copied that file to the same bin folder with the name make.exe so it is easier to run.
## Testing with doctest
This template uses the test framework [doctest](https://github.com/onqtam/doctest/blob/master/doc/markdown/readme.md#reference) because it is super simple to work with. Just include a single .h file.

Install the [C++ TestMate VS Code Extension](https://marketplace.visualstudio.com/items?itemName=matepek.vscode-catch2-test-adapter) to easily find and run tests. *Note*: If the extension doesn't find your tests make sure the search path is correct. In VS Code Settings search for "testmate path".

I tried getting [Google Test](https://github.com/google/googletest) to work but couldn't figure it out. I also tried [Catch2](https://github.com/catchorg/Catch2) but the tests took way too long to compile.

## Build tasks (tasks.json)
Check these out. They are easily accessible from the keyboard shortcut **Ctrl+Shift+B**.

These are configured to work only if the default shell is bash.
