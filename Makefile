CC       = g++
COMPILE_FLAGS = -g -Wall -c -std=c++11 -ggdb
CREATE_DIR = mkdir -p
OUTPUT_DIR = out
GTEST_LL = -I /usr/include/gtest/ -l gtest -l gtest_main -pthread
DELETE_FILE = rm -f
FOLDERS=apple apple/bins

$(shell $(CREATE_DIR) $(OUTPUT_DIR))

all: helloworld

helloworld: date.o math.o
	g++ -g -Wall hellowworld.cpp -o hellowworld

date: date.h date.cpp
	$(CC) $(COMPILE_FLAGS) date.cpp -o $(OUTPUT_DIR)/date.o

math: math.h math.cpp
	$(CC) $(COMPILE_FLAGS) math.cpp -o $(OUTPUT_DIR)/math.o

.PHONY:  clean

clean:
	$(DELETE_FILE) *.o
	$(DELETE_FILE) $(OUTPUT_DIR)/*.o