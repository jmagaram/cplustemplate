# It is difficult to get the makefile to put .o files in a subdirectory, like
# obj, without cluttering up the makefile and making it difficult to work with.
# To hide .o and .exe files from the VS Code file explorer, search VS Code
# settings for the word "exclude" and add *.o and *.exe to the list.

# Automatic variables like $^ and $@ avoid repetition in the makefile.
# https://www.gnu.org/software/make/manual/html_node/Automatic-Variables.html#Automatic-Variables

# This makefile is intended to be used on both Windows and Linux. It should be
# possible to just change the PLATFORM variable and have everything else work.

PLATFORM = Windows

CXX = g++
CXXFLAGS = -g -Wall -std=c++11 -ggdb
COMPILE_OBJ = $(CXX) $(CXXFLAGS) -c
COMPILE_EXE = $(CXX) $(CXXFLAGS)

ifeq ($(PLATFORM),Windows)
	GTEST_LIB_PATH = ../googletest/build/lib
	GTEST_LIB_MAIN = $(GTEST_LIB_PATH)/libgtest_main.a
	GTEST_LIB_CORE = $(GTEST_LIB_PATH)/libgtest.a
	GTEST_INCLUDE = ../googletest/googletest/include/
	COMPILE_GTEST_OBJ = $(CXX) -std=c++17 -Wall -I h -I $(GTEST_INCLUDE) -c -ggdb -g
	COMPILE_GTEST_EXE = $(CXX) -std=c++17 -I h -pthread -ggdb -g
	EXE = .exe
else
	GTEST_LIB_PATH = ../googletest/build/lib
	GTEST_LIB_MAIN = $(GTEST_LIB_PATH)/libgtest_main.a
	GTEST_LIB_CORE = $(GTEST_LIB_PATH)/libgtest.a
	GTEST_INCLUDE = 
	COMPILE_GTEST_OBJ =
	COMPILE_GTEST_EXE =
	EXE = 
endif

all: hello$(EXE) tests_doctest$(EXE)

hello$(EXE): date.o math.o
	$(COMPILE_EXE) hello.cpp $^ -o $@

tests_doctest$(EXE): tests_doctest.cpp date.o math.o
	$(COMPILE_EXE) $^ -o $@

tests_gtest$(EXE) : tests_gtest.o date.o math.o
	$(COMPILE_GTEST_EXE) $^ $(GTEST_LIB_MAIN) $(GTEST_LIB_CORE) -o $@

date.o: date.cpp date.h
	$(COMPILE_OBJ) $< -o $@

math.o: math.cpp math.h 
	$(COMPILE_OBJ) $< -o $@

tests_gtest.o : tests_gtest.cpp
	$(COMPILE_GTEST_OBJ) $< -o $@

.PHONY: clean

clean:
	$(RM) *.o
	$(RM) *.d	
	$(RM) *.exe
