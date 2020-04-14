CC=gcc
AR=ar
LD=ld
RM=rm
DEBUG ?= 0

ROOT_DIRECTORY=$(HOME)/devel/rpi/edge-libevent
BIN=test_json
LIB=simple_json.a

SRCS=json_internal.c json_parser.c
OBJS=$(SRCS:.c=.o)
TEST_SRC=test_json.c
TEST_OBJ=test_json.o

CFLAGS=-Wall -I. -I$(ROOT_DIRECTORY)/include
ARFLAGS=rscv

ifeq ($(DEBUG), 1)
	CFLAGS += -DDEBUG
endif

LDFLAGS=-L$(ROOT_DIRECTORY)/lib -lssl -lcrypto

all: test_json lib

lib: $(OBJS)
	$(AR) $(ARFLAGS) $(LIB) $(OBJS)

test_json: $(TEST_OBJ) $(OBJS)
	$(CC) -o $@ $(TEST_OBJ) $(OBJ) $(LDFLAGS)
	@echo "LINK => $@"

%.o: %.c
	$(CC) -c $< $(CFLAGS)
	@echo "CC <= $<"

clean:
	$(RM) $(BIN) $(OBJS) $(TEST_OBJ) $(LIB)
