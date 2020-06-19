# Some of the commands in here might be dependent on which command shell is used to
# execute it. For example, commands that delete and create files and folders are
# slightly different under the bash shell, PowerShell, and Windows command prompt.
# Also path separators are different in bash than in PowerShell and the Windows
# command prompt.

CC = g++
CC_FLAGS = -g -Wall -std=c++11 -ggdb
COMPILE_OBJ = $(CC) $(CC_FLAGS) -c
COMPILE_EXE = $(CC) $(CC_FLAGS)
OUT = obj
CREATE_DIR = mkdir -p
DELETE_FILE = rm -f
DELETE_DIRECTORY = rmdir 

# I grabbed these off the internet and they seem to work. I don't know whether or
# if other compiler flags will work instead.
GTEST_LIB = ../googletest/build/lib
GTEST_INCLUDE = ../googletest/googletest/include/
COMPILE_GTEST_OBJ = $(CC) -std=c++17 -Wall -I h -I $(GTEST_INCLUDE) -c -ggdb -g
COMPILE_GTEST_EXE = $(CC) -std=c++17 -I h -pthread -ggdb -g

$(shell $(CREATE_DIR) $(OUT))

all: helloworld.exe tests_doctest.exe

helloworld.exe: $(OUT)/date.o $(OUT)/math.o
	$(COMPILE_EXE) helloworld.cpp $(OUT)/date.o $(OUT)/math.o -o helloworld.exe

tests_doctest.exe: tests_doctest.cpp $(OUT)/date.o $(OUT)/math.o
	$(COMPILE_EXE) tests_doctest.cpp $(OUT)/date.o $(OUT)/math.o -o tests_doctest.exe

tests_gtest.exe :  $(OUT)/tests_gtest.o $(OUT)/date.o $(OUT)/math.o
	$(COMPILE_GTEST_EXE) $(OUT)/tests_gtest.o $(OUT)/date.o $(OUT)/math.o $(GTEST_LIB)/libgtest_main.a $(GTEST_LIB)/libgtest.a -o tests_gtest.exe

$(OUT)/date.o: date.h date.cpp
	$(COMPILE_OBJ) date.cpp -o $(OUT)/date.o

$(OUT)/math.o: math.h math.cpp
	$(COMPILE_OBJ) math.cpp -o $(OUT)/math.o

$(OUT)/tests_gtest.o : tests_gtest.cpp
	$(COMPILE_GTEST_OBJ) tests_gtest.cpp -o $(OUT)/tests_gtest.o

.PHONY:  clean

clean:
	$(DELETE_FILE) *.o
	$(DELETE_FILE) *.d	
	$(DELETE_FILE) *.exe
	$(DELETE_FILE) $(OUT)/*.o
	$(DELETE_FILE) $(OUT)/*.d
	$(DELETE_FILE) $(OUT)/*.exe

# Sometimes this directory gets created if scripts are run in powershell
# rather than bash. Annoying.
	$(DELETE_DIRECTORY) ./-p
