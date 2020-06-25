# to build with debug data:
#   make CFLAGS="-DPRINT_DETAILS -DDUMP_PACKET"
SAMPLE_HELLO_SRC=sample-helloworld.c
SAMPLE_HELLO_OBJ=$(SAMPLE_HELLO_SRC:%.c=%.o)
SAMPLE_HELLO_EXE=$(SAMPLE_HELLO_OBJ:%.o=%)
CFLAGS+=-MMD

all: $(SAMPLE_HELLO_EXE)

$(SAMPLE_HELLO_OBJ): $(SAMPLE_HELLO_SRC) Makefile
	gcc -c sample-helloworld.c -o sample-helloworld.o $(CFLAGS)

$(SAMPLE_HELLO_EXE): $(SAMPLE_HELLO_OBJ)
	gcc -o sample-helloworld sample-helloworld.o -lnfnetlink -lnetfilter_queue -lpthread -lz -lm -ldl
	#gcc -lnfnetlink -lnetfilter_queue -lmemcached -lmysqlclient -lpthread -lz -lm -ldl -o sample-helloworld sample-helloworld.o

.PHONY: echo clean all
echo:
	@echo "SAMPLE_HELLO_EXE: $(SAMPLE_HELLO_EXE)"
	@echo "SAMPLE_HELLO_OBJ: $(SAMPLE_HELLO_OBJ)"
	@echo "SAMPLE_HELLO_SRC: $(SAMPLE_HELLO_SRC)"

clean:
	rm sample-helloworld.o sample-helloworld

-include $(SAMPLE_HELLO_SRC:%.c=%.d)
