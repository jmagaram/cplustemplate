# VS Code C++ Starter for Windows

This is a starter configuration for building C++ using the GNU g++ compiler in VS Code. The key features are:

- A makefile and environment that can work in both Windows and Linux with just a few edits to switch platforms. This makes it easy to do most development work in Windows, push it to Github, and then resume or check that work from within Linux.
- Unit testing with [doctest](https://github.com/onqtam/doctest/blob/master/doc/markdown/readme.md#reference) and [GTest](https://github.com/google/googletest). This template includes a few basic tests for each testing framework so you can see how to get started with it. There are instructions below for using a visual test explorer.
- Build and debug your C++ code from within VS Code using the preconfigured tasks.json and launch.json files.

## Getting started

There is very helpful information from Microsoft for getting [started with C++ in VS Code](https://code.visualstudio.com/docs/cpp/config-mingw). Follow those instructions to:

1. Install VS Code

1. Install the C/C++ extension for VS Code.

1. Install the GNU g++ compiler (Mingw-w64). When I installed the compiler there were some cryptic options. I chose the **posix** and **x86_64** options which got installed as **C:\mingw-w64\x86_64-8.1.0-posix-seh-rt_v6-rev0** and this has worked out well. Based on experimentation I suspect the other options are not as reliable.

1. Add the path to your Mingw-w64 **bin** folder to the Windows PATH environment variable.

1. This template uses a Makefile to control the compilation process. You'll need the make.exe utility. This is included with the Mingw-64 compiler but has the name **mingw32-make.exe**. I simply copied this file to the same bin directory and gave it the name **make.exe** so it would automatically be in the path and can be invoked by just typing **make**.

1. Install the testing extension into VS Code; see below.

1. Change your default shell in VS Code to **bash**. The makefile has been tested and works from bash but not from other shells like powershell and cmd.

## Using this template

Simply git clone this template for each new project. In a command shell type...

    cd repos
    git clone https://github.com/jmagaram/cplustemplate.git mynewproject
    cd mynewproject
    git remote rm origin

## To build and debug

Start a new terminal (bash required) in VS Code and type **make all**.

Or you can choose from various preconfigured build tasks by choosing **Run Task..**. from the Terminal menu. You can assign make all as the debug build task so Ctrl+Shift+B will build everything. The build tasks are configured in **tasks.json**.

To debug...

1. Open a file you want to test, such as one you created with a main (like hello.cpp), or one of the test files (like tests_doctest.cpp).

2. Click the Run icon in the VS Code sidebar Ctrl+Shift+D.

3. Make sure Make and Debug (Active File) is selected at the top; those choices are configured in **launch.json**.

4. Click the Run button to start debugging.

## Makefile info

When switching between Windows and Linux, some configuration information might be different, such as the location of various .h files and the location of the Google Test framework. The makefile in this template has some conditional logic so you can change one variable - PLATFORM - and it should them build properly.

## Testing with Doctest

[Doctest](https://github.com/onqtam/doctest/blob/master/doc/markdown/readme.md#reference) is super simple to work with. Just include a single .h file. You might want to periodically check to see if the .h file in the project has been updated to get new doctest features and bug fixes.

Install the [C++ TestMate VS Code Extension](https://marketplace.visualstudio.com/items?itemName=matepek.vscode-catch2-test-adapter) to easily find and run tests.

**Important**: If the TestMate extension does not find your tests make sure the search path is correct. In VS Code Settings search for "testmate path" and set it to the name of your test executable.

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

Your test files must `#include "gtest/gtest.h"`. The VS Code text editor does not know how to find these files even though the Makefile does. The fix is to add the path to the GTest include files in your **c_cpp_properties.json** file. Read more information on [configuring C/C++](https://code.visualstudio.com/docs/cpp/config-mingw#_cc-configurations)

Install the [C++ TestMate VS Code Extension](https://marketplace.visualstudio.com/items?itemName=matepek.vscode-catch2-test-adapter) to easily find and run tests.

**Important**: If the TestMate extension does not find your tests make sure the search path is correct. In VS Code Settings search for "testmate path" and set it to the name of your test executable.

## Other things to be aware of

Consider [configuring C/C++](https://code.visualstudio.com/docs/cpp/config-mingw#_cc-configurationsthe) inside VS Code. This template includes a **c_cpp_properties.json** file that uses the Microsoft compiler for intellisense and points to a couple locations for .h files. You may need to update the .h file locations if you want to also use VS Code on Linux. I don't know whether there are advantages or disadvantages of using the Microsoft compiler here rather than g++ but it seemed to work fine for me.

About **file path separators**: In the bash shell file paths are separated by the forward slash character. In powershell and the Windows cmd shell file paths are separated by the backward slash character. So paths that work in Windows may not work in Linux, and paths specified in one shell may not work in another. I have found that using paths with the forward slash in #include statements and in the makefile seem to work in both platforms.

File paths are sometimes specified in the VS Code launch.json and tasks.json files. If you want to use VS Code in both Windows and Linux, it may be tricky to set these up correctly. VS Code uses [variables](https://code.visualstudio.com/docs/editor/variables-reference) like `\${file}` and `\${relativeFileDirname}`, and I think these end up being paths that won't work in bash. I haven't investigated all this much but there is probably a seamless way of switching between VS Code on Windows and Linux through the use of environment variables and configuring paths.
