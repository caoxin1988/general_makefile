TARGET := test
TOP_DIR := $(shell pwd)

export TOP_DIR

obj-y += app/
obj-y += font/
obj-y += main.o

#first target, also the main target
all:
	make -C ./ -f $(TOP_DIR)/build.mk
	gcc -o $(TARGET) build-in.o

clean:
	rm -fr $(TARGET)
	rm -fr $(shell find -iname "*.o")
	rm -fr $(shell find -iname ".*.d")
