# VS Code C++ Starter for Windows

This is a starter configuration for building C++ using the GNU g++ compiler in VS Code. The key features are:

- A makefile and environment that can work in both Windows and Linux with just a few edits to switch platforms. This makes it easy to do most development work in VS Code on Windows, push it to Github, and then resume or check that work from within Linux.
- Unit testing with [doctest](https://github.com/onqtam/doctest/blob/master/doc/markdown/readme.md#reference) and [GTest](https://github.com/google/googletest). This template includes a few basic tests for each testing framework so you can see how to get started with it. There are instructions below for using a visual test explorer.

## Getting started 

There is very helpful information from Microsoft for [getting started with C++ in VS Code](https://code.visualstudio.com/docs/cpp/config-mingw). Follow those instructions to install the GNU g++ compiler and get the basics working within VS Code.

**Note:** When I installed the g++ compiler there were some cryptic options. I chose the **posix** and **x86_64** options. I installed it in  **C:\mingw-w64\x86_64-8.1.0-posix-seh-rt_v6-rev0**. These options worked out well. Based on experimentation I suspect the **win32** threading option is not as reliable.

## Install the make.exe utility

This template uses a Makefile to control the compilation process, so you'll need the make.exe utility. This is included with the Mingw-64 compiler but has the name **mingw32-make.exe**. Copy this file to the same directory but give it the name **make.exe**.

    cd \mingw-w64\x86_64-8.1.0-posix-seh-rt_v6-rev0\mingw64\bin
    copy mingw32-make.exe make.exe

## Start a new project using this template

Open VS Code.

Type **Ctrl+Shift+P** and type **default shell**. Change your default terminal shell to **Git Bash**. This template has been tested and works with the bash shell. I don't think it works with cmd or powershell.

I don't remember whether or how I installed **git** or if it came along for the ride with VS Code. So if it isn't on your computer you may need to [install git](https://git-scm.com/download/win).

Start a new command shell by typing **Ctrl+Shift+`**. In the shell type...

    cd source/repos (or wherever you keep your code)
    git clone https://github.com/jmagaram/cplustemplate.git mynewproject
    cd mynewproject
    git remote rm origin

Open a copy of VS Code focused on this new project folder by typing...

    code .

## Run the hello.exe sample

Start a new command shell by typing **Ctrl+Shift+`** and type...

    make all
    ./hello.exe

Alternatively you can build the program using the VS Code UI. The easiest way is to press **Ctrl+Shift+B** which will run your default build task.

Choose **Run Task..**. from the Terminal menu and choose any of the preconfigured tasks like **Make All**, **Make Clean**, and **Make .exe (for active file)**.

These tasks are configured using the **tasks.json** file in the .vscode folder. You can add new tasks depending on your project.

## Hide .o files

You'll notice that the VS Code explorer shows the intermediate build results like .o files. This can clutter up your workspace. Usually you just want to see source code there. VS Code can hide these files. Open Settings by pressing **Ctrl+,** and type **exclude**. Add **\*\*/\*.o** and **\*\*/\*.exe** to the list; these will be hidden no matter which folder you are looking at.

## Debug hello.cpp

Open the **hello.cpp** file and click to the left of one of the lines to set a breakpoint.

Open the Run section of VS Code - **Ctrl+Shift+D**. Click the green arrow. The debugger should stop at the breakpoint. Stop the debugger.

You'll notice at the top near the green arrow it says "Make and debug (active file)". That is the name of a configuration defined in the **launch.json** file. If you look at that configuration you'll see the **preLaunchTask** is "Make .exe (for active file)" which is the name of a task defined in tasks.json, and that task builds an .exe for the active file using the make utility. Hopefully this can help you understand the relationship between tasks.json and launch.json. 

You can create additional debug configurations hardwired to a particular .exe you want to build and debug, and these can be launched regardless of which particular .cpp file you have open.

## Unit testing with Doctest

[Doctest](https://github.com/onqtam/doctest/blob/master/doc/markdown/readme.md#reference) is super simple to work with. All you need to do is include a single .h file in your test files. Look at **tests_doctest.cpp** for an example. To run these tests, start a new terminal shell and type...

    make all
    ./tests_doctest.exe

VS Code has many extensions. To see what extensions are installed and to install new ones, press **Ctrl+Shift+X**.
To make testing easier, install the [C++ TestMate VS Code Extension](https://marketplace.visualstudio.com/items?itemName=matepek.vscode-catch2-test-adapter).  Also, if it is not already installed, install the [Test Explorer UI](https://marketplace.visualstudio.com/items?itemName=hbenl.vscode-test-explorer).

After the test explorer has been installed you should see a little lab beaker icon on the left side of VS Code near the other explorers. Click on it to open the Test Explorer. If you don't see any tests in the list you may need to configure the TestMate extension to know how to find your tests. In VS Code Settings search for "testmate path". I changed it to...

    **/*{test,Test,TEST}*

You should now see the tests in the Text Explorer and can click the Run button to run them all and see which ones passed.

The template includes the **doctest.h** file which was up-to-date around June 2000. You might want to periodically check the doctest web site to see if there are newer versions available with new features and bug fixes and can copy it down into your project.

One way to debug your tests is to open the file with the tests, like tests_doctest.cpp, set a breakpoint, and then run it, just like you debugged the hello.cpp program.

You can also debug tests from within the Test Explorer. You should be able to click on a test and click the ladybug icon. However I was only able to get this to work if the tests_doctest.cpp file was already open. I'm pretty sure there is a way to make this work more easily by changing the Config Template in the TestMate settings. [debug.configTemplate](https://marketplace.visualstudio.com/items?itemName=matepek.vscode-catch2-test-adapter) and [this](https://github.com/matepek/vscode-catch2-test-adapter/blob/master/documents/configuration/debug.configTemplate.md)  

## Using testing with Google Test

You need to build the Google Test framework so you can use it in your C+++ projects.

Start a new terminal by typing **Ctrl+Shift+`**. Then type this...

    powershell
    cd source\repos (or wherever you keep your code)
    git clone https://github.com/google/googletest googletest
    cd googletest
    mkdir build
    cd build
    cmake .. -G "MinGW Makefiles"
    make

Your unit tests just need two things to work with GTest: (a) the GTest include files and (b) the GTest object files you just built. Open the Makefile and make sure the **GTEST_LIB_PATH** and **GTEST_INCLUDE** paths are correct based on where your project file is and where you installed and built Google test.

Open the **tests_gtest.cpp** file to see what unit tests with this framework look like. 

You may see an error on the line **#include "gtest/gtest.h"**. VS Code doesn't know where to find the Google includes files, even though the makefile does. The fix is to add the path to the GTest include files in your **c_cpp_properties.json** file. Read more information on [configuring C/C++](https://code.visualstudio.com/docs/cpp/config-mingw#_cc-configurations)

This **c_cpp_properties.json** included with this template uses the Microsoft compiler for intellisense. I don't know whether there are advantages or disadvantages of using the Microsoft compiler here rather than g++ but it seemed to work fine for me.

Try to build and run the tests. In a terminal, type this...

    make tests_gtest.exe
    ./tests_gtest.exe

You should be able to see and run these tests from the Test Explorer, just like you did with Doctest. You may need to click the reload/refresh button at the top of the Test Explorer first.

## Switching between Windows and Linux

When switching between Windows and Linux, some configuration information might be different, such as the location of various .h files and the location of the Google Test framework. The makefile in this template has some conditional logic so you can change one variable - PLATFORM - and it should them build properly.

About **file path separators**: In the bash shell file paths are separated by the forward slash character. In powershell and the Windows cmd shell file paths are separated by the backward slash character. So paths that work in Windows may not work in Linux and paths specified in one shell may not work in another. I have found that using paths with the forward slash in #include statements and in the makefile seem to work in both platforms.

## Other things to be aware of

The VS Code build and debug tasks are configured through the tasks.json and launch.json files. Below is an example task that runs "make all". The "cwd" setting defines the current working directory as ${workspaceFolder} and this is where the "make all" command is found and executed. The workspace folder is the root folder of your VS workspace. But if the makefile you are working with is stored in a subdirectory this task will fail to find it. So it is important to make sure the paths in the tasks.json and launch.json are correct according to how your project folders are organized. Read the [VS Code Variables Reference](https://code.visualstudio.com/docs/editor/variables-reference) to learn about the special variables you can use in these files to configure paths and file names.

    "tasks": [
        {
          "type": "shell",
          "label": "Make All",
          "command": "make all",
          "args": [],
          "options": {
            "cwd": "${workspaceFolder}"
          },
          "problemMatcher": ["$gcc"],
          "group": { "kind": "build", "isDefault": true }
        },
        ...

If you have many different project folders underneath your root workspace folder, it might be simplest to put the .vscode folder at the root. Then create tasks dedicated to each specific project, like "make all project A" and "make all project B" and set the default to whatever project you are working on. You could also hardwire specifc run/launch configurations like "debug project A". Another alternative is to define generic tasks like "make all" but set the "cwd" to "${cwd}" and then configure the Terminal's current working directory to whatever folder you are focusing on; search Settings for "terminal cwd" to change it. VS Code provides lots of flexibility so you should be able to set it up for how you like to work.