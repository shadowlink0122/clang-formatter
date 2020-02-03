TARGET	= formatter

# LINK (*.o)
LD	= cc
LDFLAGS	= -W

# COMPILE (*.c)
CC	= cc
CCFLAGS	= -W -O2

# GENERATOR (*.lex and *.yac)
LEX	= flex
YAC	= yacc

OBJS	= y.tab.o main.o
DEFS	= defs.h
REXP	= rexp.lex
LEXC	= lex.yy.c
SYNS	= syns.yac
YACC	= y.tab.c
SRC	= src.txt
TMP	= tmp.txt
ARC	= Formatter

all: $(TARGET)

$(TARGET): $(OBJS)
	$(LD) $(LDFLAGS) -o $@ $(OBJS)

$(OBJS): $(DEFS)

$(LEXC): $(REXP) $(DEFS)
	$(LEX) $(REXP)

$(YACC): $(SYNS) $(LEXC) $(DEFS)
	$(YAC) $(SYNS)

%.o: %.c
	$(CC) $(CCFLAGS) -c $< -o $@

clean:
	-rm -f $(TARGET)* $(OBJS) $(LEXC) $(YACC) $(TMP) *\~

src: all
	./$(TARGET) < $(SRC) > $(TMP)
	cat $(TMP)
	@echo
	
zip: clean
	mkdir $(ARC)
	cp -p -r ./*.* Makefile $(ARC)/
	zip -r $(ARC).zip $(ARC)/
	rm -rf $(ARC)

test: src
	@:

