#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define TRUE	1
#define FALSE	0

extern char *yytext;
extern int linecounter;

int main(void);
int yylex(void);
void comment(void);
int yyparse(void);
void yyerror(char*);
void indent(int*);

