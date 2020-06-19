# VS Code C++ Starter for Windows

This is a simple starter configuration for building C++ using VS Code using the g++ compiler on Windows. The key features are:

- Make files for compilation, with build results (.exe and .o files) in a subdirectory.
- Some preconfigured build tasks like clean and make all.
- Debugging works
- Unit testing with doctest included
- Unit testing with GTest will work with some additional steps documented below

This is good information from Microsoft for getting [started with C++ in VS Code](https://code.visualstudio.com/docs/cpp/config-mingw).

## Make files

The makefile was tested using the bash shell. I don't think other shells will work. So set your default shell in VS Code to **bash**.

The make.exe command utility can be downloaded and installed separately from the compiler. But it also seems to be included in the compiler bin folder with the name mingw32-make.exe. So I just copied that file to the same bin folder with the name make.exe so it is easier to run.

## Testing with Doctest

This template uses the test framework [doctest](https://github.com/onqtam/doctest/blob/master/doc/markdown/readme.md#reference) because it is super simple to work with. Just include a single .h file. You might want to periodically check to see if the .h file in the project has been updated.

Install the [C++ TestMate VS Code Extension](https://marketplace.visualstudio.com/items?itemName=matepek.vscode-catch2-test-adapter) to easily find and run tests. _Note_: If the extension doesn't find your tests make sure the search path is correct. In VS Code Settings search for "testmate path".

## Testing with Google Test

These steps worked for me on Windows 10. You need to build the Google Test framework and then reference it from your Makefile and code.

1. Use git to clone [Google Test](https://github.com/google/googletest) to somewhere on your computer. I put it in the **source\repos\googletest** folder.
1. Create a folder where you are going to build the GTest framework. I created the folder **source\repos\googletest\build**
1. In **powershell** (bash didn't seem to work for me), cd into the above folder you created. Then type this, substituting the correct path to the root of the Google Test folder you cloned. **cmake source\repos\googletest\ -G "MinGW Makefiles"**
1. Type **make**. This makes the library files your code will link with. I think this builds a version of the libraries that works on Windows but will not necessarily work on Linux.
1. Your tests just need two things: (a) the GTest include files and (b) the GTest library files you just built. Make sure the paths in the Makefile properly reference the correct paths on your system to these files.
1. Your test files must **#include "gtest\gtest.h"**. The VS Code text editor does not know how to find these files even though the Makefile does. The fix is to add the path to the GTest include files in your **c_cpp_properties.json** file.

## Testing with Catch2

I tried [Catch2](https://github.com/catchorg/Catch2) but the tests took way too long to compile.

## Build tasks (tasks.json)

Check these out. The default task is easily accessible from the keyboard shortcut **Ctrl+Shift+B** but other tasks can be easily selected by choosing Run Task... from the Terminal menu.

These are configured to work only if the default shell is bash.

## About file paths

In the **bash** shell, file paths are separated by the forward slash **/** character. In **powershell** and the Windows **cmd** shell, file paths are separated by the backward slash **\\** character. So makefile scripts and paths specified in the launch.json and tasks.json files can end up being dependent on which shell you are using. VS Code uses [variables](https://code.visualstudio.com/docs/editor/variables-reference) like **\${file}** and **\${relativeFileDirname}**, and I think these end up being paths that won't work in bash. There might be workarounds so the build and launch instructions are not dependent on a specific shell but I didn't investigate it much. Other people have [had this problem](https://stackoverflow.com/questions/47250021/want-workspacefolder-to-emit-forward-slashes-on-windows).
