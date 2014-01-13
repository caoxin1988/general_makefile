PHONY:=__build

__build:

include Makefile

# obj-y += a.o
# obj-y += b.o
# obj-y += dir/
sub_dirs := $(patsubst %/,%,$(filter %/,$(obj-y)))
#sub_dirs := $(wildcard $(__sub_dirs))
cur_obj := $(filter-out %/,$(obj-y))
deps_files := $(foreach f,$(cur_obj),.$(f).d) 
sub_buildin := $(foreach f,$(sub_dirs),$(f)/build-in.o)

sinclude $(deps_files)

$(sub_dirs) : 
	echo $@
	make -C $@ -f $(TOP_DIR)/build.mk

build-in.o : $(cur_obj) $(sub_buildin)
	echo $@
	ld -r -o $@ $^

__build: $(sub_dirs) build-in.o

%.o : %.c
	gcc -Wp,-MMD,.$@.d -c -o $@ $<

PHONY += $(sub_dirs)

.PHONY:$(PHONY)

