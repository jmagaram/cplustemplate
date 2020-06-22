# VS Code C++ Starter for Windows

This is a simple starter configuration for building C++ using VS Code using the g++ compiler on Windows. The key features are:

- Sample makefile that can work in Windows or Linux with just a few edits when switching platforms.
- Unit testing with doctest works without much hassle
- Unit testing with GTest works if you build GTest first according to steps below
- Debugging of main program and tests works

There is good info from Microsoft for getting [started with C++ in VS Code](https://code.visualstudio.com/docs/cpp/config-mingw). When I installed the g++ compiler there were some cryptic options. I chose **C:\mingw-w64\x86_64-8.1.0-posix-seh-rt_v6-rev0** and this has worked out well. Based on experimentation I suspect the other options are not as reliable. I've read various web posts that the Win32 version does not have all the threading features that the posix version has. 

## Make file

The makefile was tested using the bash shell. I don't think other shells will work. So set your default shell in VS Code to `bash`.

The make.exe command utility can be downloaded and installed separately from the compiler. But it also seems to be included in the compiler bin folder with the name `mingw32-make.exe`. So I just copied that file to the same bin folder with the name make.exe so it is easier to run.

## Testing with Doctest

This test framework [doctest](https://github.com/onqtam/doctest/blob/master/doc/markdown/readme.md#reference) is super simple to work with. Just include a single .h file. You might want to periodically check to see if the .h file in the project has been updated.

Install the [C++ TestMate VS Code Extension](https://marketplace.visualstudio.com/items?itemName=matepek.vscode-catch2-test-adapter) to easily find and run tests. _Note_: If the extension doesn't find your tests make sure the search path is correct. In VS Code Settings search for "testmate path".

## Testing with Google Test

You need to build the Google Test framework. Start **powershell** (didn't seem to work in Bash) and do this...

    cd source\repos
    git clone https://github.com/google/googletest googletest
    cd googletest
    mkdir build
    cd build
    cmake .. -G "MinGW Makefiles"
    make

Your tests just need two things: (a) the GTest include files and (b) the GTest library files you just built. Make sure the paths in the Makefile properly reference the correct paths on your system to these files.

Your test files must `#include "gtest\gtest.h"`. The VS Code text editor does not know how to find these files even though the Makefile does. The fix is to add the path to the GTest include files in your **c_cpp_properties.json** file.

## Testing with Catch2

I tried [Catch2](https://github.com/catchorg/Catch2) but the tests took way too long to compile.

## Build tasks (tasks.json)

The build tasks are configured to use the makefile and I think they only work if the default shell is bash.

The default task is easily accessible from the keyboard shortcut `Ctrl+Shift+B` but other tasks can be easily selected by choosing `Run Task...` from the `Terminal` menu.

## About file paths

In the bash shell, file paths are separated by the forward slash character. In powershell and the Windows cmd shell, file paths are separated by the backward slash \\ character. So makefile scripts and paths specified in the launch.json and tasks.json files can end up being dependent on which shell you are using. VS Code uses [variables](https://code.visualstudio.com/docs/editor/variables-reference) like `\${file}` and `\${relativeFileDirname}`, and I think these end up being paths that won't work in bash. There might be workarounds so the build and launch instructions are not dependent on a specific shell but I didn't investigate it much.
