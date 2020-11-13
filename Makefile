#
# simple Makefile template :)
#
Target=aplayer

src:=$(wildcard *.c)
objs:=$(patsubst %.c,%.o,${src})


CC = gcc
CXX= gcc


CF_SDL:=`pkg-config --cflags sdl2`
LD_SDL:=`pkg-config --libs sdl2`

# yes, use my src built ffmpeg
ffmpeg_install_root=/home/shaozr/sda5/ffmpeg_install_root

CF_FFMPEG=-I $(ffmpeg_install_root)/include
LD_FFMPEG=-L $(ffmpeg_install_root)/lib -lavformat -lavcodec -lavutil -lavdevice -lswscale -lswresample


CPPFLAGS=  -DDEBUG -I. 
CFLAGS= -ggdb3 -Wall -MMD  -pthread -fPIC -std=c++11  $(CF_SDL) $(CF_FFMPEG)
CXXFLAGS= $(CFLAGS)

LDFLAGS= -pthread -lm -lbz2  -lz $(LD_SDL) $(LD_FFMPEG)
LOADLIBES=
LDLIBS= 


##########################################################################

Deps= $(objs:.o=.d) 

all:$(Target)

-include $(Deps)

aplayer: $(objs) 
	$(CC) $^ $(LDFLAGS)  $(LOADLIBES) $(LDLIBS) -o $@


clean:
	rm -fr $(objs) $(Target) $(Deps)


