cmd_shell/ash_ptr_hack.o := arm-linux-gnueabi-gcc -Wp,-MD,shell/.ash_ptr_hack.o.d   -std=gnu99 -Iinclude -Ilibbb  -include include/autoconf.h -D_GNU_SOURCE -DNDEBUG -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -D"BB_VER=KBUILD_STR(1.29.0)"  -Wall -Wshadow -Wwrite-strings -Wundef -Wstrict-prototypes -Wunused -Wunused-parameter -Wunused-function -Wunused-value -Wmissing-prototypes -Wmissing-declarations -Wno-format-security -Wdeclaration-after-statement -Wold-style-definition -fno-builtin-strlen -finline-limit=0 -fomit-frame-pointer -ffunction-sections -fdata-sections -fno-guess-branch-probability -funsigned-char -static-libgcc -falign-functions=1 -falign-jumps=1 -falign-labels=1 -falign-loops=1 -fno-unwind-tables -fno-asynchronous-unwind-tables -fno-builtin-printf -Os     -D"KBUILD_STR(s)=\#s" -D"KBUILD_BASENAME=KBUILD_STR(ash_ptr_hack)"  -D"KBUILD_MODNAME=KBUILD_STR(ash_ptr_hack)" -c -o shell/ash_ptr_hack.o shell/ash_ptr_hack.c

deps_shell/ash_ptr_hack.o := \
  shell/ash_ptr_hack.c \
  /usr/arm-linux-gnueabi/include/stdc-predef.h \

shell/ash_ptr_hack.o: $(deps_shell/ash_ptr_hack.o)

$(deps_shell/ash_ptr_hack.o):
