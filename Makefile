# This makefile is intended to be used on both Windows and Linux. It should be
# possible to just change the PLATFORM variable and have everything else work.

PLATFORM = Windows

CXX = g++
CXXFLAGS = -g -Wall -std=c++11 -ggdb
COMPILE_OBJ = $(CXX) $(CXXFLAGS) -c
COMPILE_EXE = $(CXX) $(CXXFLAGS)

ifeq ($(PLATFORM),Windows)
	GTEST_LIB_PATH = ../googletest/build/lib
	GTEST_MAIN = $(GTEST_LIB_PATH)/libgtest_main.a
	GTEST_CORE = $(GTEST_LIB_PATH)/libgtest.a
	GTEST_INCLUDE = -I ../googletest/googletest/include/
	GTEST_FLAGS = -pthread
	EXE = .exe
else
	GTEST_MAIN = -l gtest_main
	GTEST_CORE = -l gtest
	GTEST_INCLUDE = -I /usr/include/gtest/
	GTEST_FLAGS = -pthread
	EXE = 
endif

# Although these macros seem to work I did an experiment trying to use GTest with 
# my own supplied main() and the Microsoft C++ compiler. If the GTest libraries were
# listed before my own, I received link errors. But if I put the GTest libraries
# after my own, it worked. So if you start having trouble linking with GTest consider
# moving your own libraries after GTest and see if that fixes the problem.
COMPILE_GTEST_EXE = $(COMPILE_EXE) $(GTEST_FLAGS) $(GTEST_INCLUDE) $(GTEST_MAIN) $(GTEST_CORE)
COMPILE_GTEST_OBJ = $(COMPILE_OBJ) $(GTEST_FLAGS) $(GTEST_INCLUDE)

all: hello$(EXE) tests_doctest$(EXE)
tests: tests_doctest$(EXE) tests_gtest$(EXE)

# ===========
# EXECUTABLES
# ===========
# $@ is the name of the rule.
# $^ is all the dependencies.

hello$(EXE): hello.cpp date.o math.o
	$(COMPILE_EXE) $^ -o $@

tests_doctest$(EXE): tests_doctest.cpp date.o math.o
	$(COMPILE_EXE) $^ -o $@

tests_gtest$(EXE) : tests_gtest.o date.o math.o
	$(COMPILE_GTEST_EXE) $^ -o $@

# ============
# OBJECT FILES
# ============ 
# $< is the first dependency so put the .cpp file first.
# $@ is the name of the rule. 

date.o: date.cpp date.h
	$(COMPILE_OBJ) $< -o $@

math.o: math.cpp math.h 
	$(COMPILE_OBJ) $< -o $@

tests_gtest.o : tests_gtest.cpp
	$(COMPILE_GTEST_OBJ) $< -o $@

# ============
# UTILITIES
# ============ 

.PHONY: clean

clean:
	$(RM) *.o
	$(RM) *.d	
	$(RM) *.exe
	$(RM) *.ilk
	$(RM) *.obj