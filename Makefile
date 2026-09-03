HCC     := hcc
SRC     := src/Main.hc
SRCS    := $(wildcard src/*.hc src/*.HC src/*.hh src/*.HH)
BINDIR  := bin
BIN     := $(BINDIR)/holyc-8bit-vm

.PHONY: all build run ast tokens clean

all: build

build: $(BIN)

# $(SRC) only #includes the rest of src/ - hcc doesn't emit .d files, so
# Make can't discover that automatically. Depending on every source file
# under src/ instead of just $(SRC) means an edit to any of them (not
# just Main.hc) triggers a rebuild.
$(BIN): $(SRCS) | $(BINDIR)
	$(HCC) -o $(BIN) $(SRC)

$(BINDIR):
	mkdir -p $(BINDIR)

run: build
	./$(BIN)

ast:
	$(HCC) -ast $(SRC)

tokens:
	$(HCC) -tokens $(SRC)

clean:
	rm -rf $(BINDIR)
