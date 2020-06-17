CC = g++
CC_FLAGS = -g -Wall -std=c++11 -ggdb
CC_OBJ_FLAGS = -c
OUTPUT_DIR = obj
CREATE_DIR = mkdir -p
DELETE_FILE = rm -f
# GTEST_LL = -I /usr/include/gtest/ -l gtest -l gtest_main -pthread

$(shell $(CREATE_DIR) $(OUTPUT_DIR))

all: helloworld

helloworld: date.o math.o
	$(CC) $(CC_FLAGS) helloworld.cpp $(OUTPUT_DIR)/date.o $(OUTPUT_DIR)/math.o -o helloworld.exe

date.o: date.h date.cpp
	$(CC) $(CC_FLAGS) $(CC_OBJ_FLAGS) date.cpp -o $(OUTPUT_DIR)/date.o

math.o: math.h math.cpp
	$(CC) $(CC_FLAGS) $(CC_OBJ_FLAGS) math.cpp -o $(OUTPUT_DIR)/math.o

.PHONY:  clean

clean:
	$(DELETE_FILE) *.o
	$(DELETE_FILE) *.exe
	$(DELETE_FILE) $(OUTPUT_DIR)/*.o
