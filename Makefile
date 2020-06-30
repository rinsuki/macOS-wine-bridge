CC = i686-w64-mingw32-gcc

CFLAGS = -O2 -Wall

default: all
all: winediscordipcbridge.exe

winediscordipcbridge.exe: main.c
	$(CC) -masm=intel -o $@ $(CFLAGS) $<

clean:
	rm -v winediscordipcbridge.exe
