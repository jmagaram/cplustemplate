# Some of the commands in here might be dependent on which command shell is used to
# execute it. For example, commands that delete and create files and folders are
# slightly different under the bash shell, PowerShell, and Windows command prompt.
# Also path separators are different in bash than in PowerShell and the Windows
# command prompt.

# It is difficult to get the makefile to put .o files in a subdirectory, like
# obj, without cluttering up the makefile and making it difficult to work with.
# See http://make.mad-scientist.net/papers/how-not-to-use-vpath/. So it is
# simplest to keep all the build targets in the current directory. To hide .o
# and .exe files from the VS Code file explorer, search VS Code settings for the
# word "exclude" and add *.o and *.exe to the list.

# Implicit variables defined here
# https://www.gnu.org/software/make/manual/html_node/Implicit-Variables.html#Implicit-Variables

CXX = g++
CXXFLAGS = -g -Wall -std=c++11 -ggdb
COMPILE_OBJ = $(CXX) $(CXXFLAGS) -c
COMPILE_EXE = $(CXX) $(CXXFLAGS)
CREATE_DIR = mkdir -p
DELETE_FILE = rm -f
DELETE_DIRECTORY = rm -d -f 

# I grabbed these off the internet and they seem to work. I don't know whether or
# if other compiler flags will work instead.
GTEST_LIB = ../googletest/build/lib
GTEST_INCLUDE = ../googletest/googletest/include/
COMPILE_GTEST_OBJ = $(CXX) -std=c++17 -Wall -I h -I $(GTEST_INCLUDE) -c -ggdb -g
COMPILE_GTEST_EXE = $(CXX) -std=c++17 -I h -pthread -ggdb -g

all: helloworld.exe tests_doctest.exe

helloworld.exe: date.o math.o
	$(COMPILE_EXE) helloworld.cpp date.o math.o -o helloworld.exe

tests_doctest.exe: tests_doctest.cpp date.o math.o
	$(COMPILE_EXE) tests_doctest.cpp date.o math.o -o tests_doctest.exe

tests_gtest.exe :  tests_gtest.o date.o math.o
	$(COMPILE_GTEST_EXE) tests_gtest.o date.o math.o $(GTEST_LIB)/libgtest_main.a $(GTEST_LIB)/libgtest.a -o tests_gtest.exe

date.o: date.h date.cpp
	$(COMPILE_OBJ) date.cpp -o date.o

math.o: math.h math.cpp
	$(COMPILE_OBJ) math.cpp -o math.o

tests_gtest.o : tests_gtest.cpp
	$(COMPILE_GTEST_OBJ) tests_gtest.cpp -o tests_gtest.o

.PHONY:  clean

clean:
	$(DELETE_FILE) *.o
	$(DELETE_FILE) *.d	
	$(DELETE_FILE) *.exe

# Sometimes this directory gets created if scripts are accidentally run in
# powershell rather than bash. Annoying.
	$(DELETE_DIRECTORY) ./-p
