CC = clang 
NASM = nasm
CCFLAGS = -ggdb -m32  -no-pie -z noexecstack
NASM_FLAGS = -f elf32 

BUILD_DIR =build
OBJ_DIR   =obj


all : $(BUILD_DIR) $(OBJ_DIR) $(BUILD_DIR)/run


$(BUILD_DIR): 
	mkdir -p $(BUILD_DIR) 
$(OBJ_DIR) : 
	mkdir -p $(OBJ_DIR) 




$(OBJ_DIR)/defer.o : defer.asm
	$(NASM) $(NASM_FLAGS) $^ -o $@

$(BUILD_DIR)/run : main.c $(OBJ_DIR)/defer.o
	$(CC) $(CCFLAGS) $^ -o $@


clean:
	rm -r $(BUILD_DIR) $(OBJ_DIR) 
