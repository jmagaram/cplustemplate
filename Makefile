# It is difficult to get the makefile to put .o files in a subdirectory, like
# obj, without cluttering up the makefile and making it difficult to work with.
# See http://make.mad-scientist.net/papers/how-not-to-use-vpath/. It is
# simplest to keep all the build targets in the current directory. To hide .o
# and .exe files from the VS Code file explorer, search VS Code settings for the
# word "exclude" and add *.o and *.exe to the list.

# Some rules use automatic variables like $^ and $@ to avoid repetition.
# https://www.gnu.org/software/make/manual/html_node/Automatic-Variables.html#Automatic-Variables

CXX = g++
CXXFLAGS = -g -Wall -std=c++11 -ggdb
COMPILE_OBJ = $(CXX) $(CXXFLAGS) -c
COMPILE_EXE = $(CXX) $(CXXFLAGS)
DELETE_FILE = rm -f

# I grabbed these off the internet and they seem to work. I don't know whether or
# if other compiler flags will work instead.
GTEST_LIB = ../googletest/build/lib
GTEST_INCLUDE = ../googletest/googletest/include/
COMPILE_GTEST_OBJ = $(CXX) -std=c++17 -Wall -I h -I $(GTEST_INCLUDE) -c -ggdb -g
COMPILE_GTEST_EXE = $(CXX) -std=c++17 -I h -pthread -ggdb -g

all: hello tests_doctest

hello: date.o math.o
	$(COMPILE_EXE) helloworld.cpp $^ -o $@

tests_doctest: tests_doctest.cpp date.o math.o
	$(COMPILE_EXE) $^ -o $@

tests_gtest : tests_gtest.o date.o math.o
	$(COMPILE_GTEST_EXE) $^ $(GTEST_LIB)/libgtest_main.a $(GTEST_LIB)/libgtest.a -o $@

date.o: date.cpp date.h
	$(COMPILE_OBJ) $< -o $@

math.o: math.cpp math.h 
	$(COMPILE_OBJ) $< -o $@

tests_gtest.o : tests_gtest.cpp
	$(COMPILE_GTEST_OBJ) $< -o $@

.PHONY: clean

clean:
	$(DELETE_FILE) *.o
	$(DELETE_FILE) *.d	
	$(DELETE_FILE) *.exe
