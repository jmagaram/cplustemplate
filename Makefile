# I think it might be compiling everything every time since I can't get
# the message saying everything is up to date.

CC = g++
CC_FLAGS = -g -Wall -std=c++11 -ggdb
CC_OBJ_FLAGS = -c
OUT = obj
CREATE_DIR = mkdir -p
DELETE_FILE = rm -f

$(shell $(CREATE_DIR) $(OUT))

all: helloworld tests

helloworld: date.o math.o
	$(CC) $(CC_FLAGS) helloworld.cpp $(OUT)/date.o $(OUT)/math.o -o helloworld.exe

tests: tests.cpp date.o math.o
	$(CC) $(CC_FLAGS) tests.cpp $(OUT)/date.o $(OUT)/math.o -o tests.exe

$(OUT)/date.o: date.h date.cpp
	$(CC) $(CC_FLAGS) $(CC_OBJ_FLAGS) date.cpp -o $(OUT)/date.o

$(OUT)/math.o: math.h math.cpp
	$(CC) $(CC_FLAGS) $(CC_OBJ_FLAGS) math.cpp -o $(OUT)/math.o

.PHONY:  clean

clean:
	$(DELETE_FILE) *.o
	$(DELETE_FILE) *.exe
	$(DELETE_FILE) $(OUT)/*.o
