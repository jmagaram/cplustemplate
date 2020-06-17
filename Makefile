# Some of the commands in here might be dependent on which command shell is used to
# execute it. For example, commands that delete and create files and folders are
# slightly different under the bash shell, PowerShell, and Windows command prompt.

CC = g++
CC_FLAGS = -g -Wall -std=c++11 -ggdb
CC_OBJ_FLAGS = -c
OUT = obj
CREATE_DIR = mkdir -p
DELETE_FILE = rm -f

$(shell $(CREATE_DIR) $(OUT))

all: helloworld.exe tests.exe

helloworld.exe: $(OUT)/date.o $(OUT)/math.o
	$(CC) $(CC_FLAGS) helloworld.cpp $(OUT)/date.o $(OUT)/math.o -o helloworld.exe

tests.exe: tests.cpp $(OUT)/date.o $(OUT)/math.o
	$(CC) $(CC_FLAGS) tests.cpp $(OUT)/date.o $(OUT)/math.o -o tests.exe

$(OUT)/date.o: date.h date.cpp
	$(CC) $(CC_FLAGS) $(CC_OBJ_FLAGS) date.cpp -o $(OUT)/date.o

$(OUT)/math.o: math.h math.cpp
	$(CC) $(CC_FLAGS) $(CC_OBJ_FLAGS) math.cpp -o $(OUT)/math.o

.PHONY:  clean

clean:
	$(DELETE_FILE) *.o
	$(DELETE_FILE) *.d	
	$(DELETE_FILE) *.exe
	$(DELETE_FILE) $(OUT)/*.o
	$(DELETE_FILE) $(OUT)/*.d
	$(DELETE_FILE) $(OUT)/*.exe
