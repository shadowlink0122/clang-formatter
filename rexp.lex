%{
int linecounter = 1;
%}
%option nounput
%%

"void"																	{ return(VOID); }
"int"																		{ return(INT); }
"short"																	{ return(SHORT); }
"long"																	{ return(LONG); }
"float"																	{ return(FLOAT); }
"double"																{ return(DOUBLE); }
"bool"																	{ return(BOOL); }
"char"																	{ return(CHAR); }
"signed"																{ return(SIGNED); }
"unsigned"															{ return(UNSIGNED); }

"*""*"+																	{ return(POINTER); }

"struct"																{ return(STRUCT); }
"union"																	{ return(UNION); }
"enum"																	{ return(ENUM); }
"return"																{ return(RETURN); }

"if"																		{ return(IF); }
"else"																	{ return(ELSE); }
"switch"																{ return(SWITCH); }
"case"																	{ return(CASE); }
"default"																{ return(DEFAULT); }
"for"																		{ return(FOR); }
"while"																	{ return(WHILE); }
"do"																		{ return(DO); }
"break"																	{ return(BREAK); }

"typedef"																{ return(TYPEDEF); }
"const"																	{ return(CONST); }
"static"																{ return(STATIC); }
"extern"																{ return(EXTERN); }
"auto"																	{ return(AUTO); }
"register"															{ return(REGISTER); }

"\"".*"\""															{ return(STRING); }
"//".*																	{ return(COMMENT); }

[a-zA-Z_][a-zA-Z0-9_]*                  { return(ID); }
[0-9]+							                    { return(INTEGER); }
[0-9]*"."[0-9]+              						{ return(REAL); }
";"                                     { return(SEMIC); }
":"                                     { return(COLON); }
"="                                     { return(EQUAL); }
"+"                                     { return(ADD); }
"-"                                     { return(SUBTRACT); }
"*"                                     { return(MULTIPLY); }
"/"                                     { return(DIVIDE); }
"%"                                     { return(MOD); }

"."                                     { return(DOT); }

"("                                     { return(LPAR); }
")"                                     { return(RPAR); }
"{"                                     { return(LBLK); }
"}"                                     { return(RBLK); }
"["																			{ return(LARA); }
"]"																			{ return(RARA); }
">"																			{ return(GREATER); }
"<"																			{ return(SMOLLER); }

"|"																			{ return(OR); }
"&"																			{ return(AND); }
"!"																			{ return(EXCLAMATION); }

","																			{ return(COMMA); }
"\n"                                    { linecounter++; }
"\r\n"                                  { linecounter++; }
"\r"                                    { linecounter++; }
" "|"\t"                                { }
"#".*                        			      { }
"<".*">"                     			      { }
"/*"                                    { comment(); }
.                                       { return(UNKNOWN); }
%%
int yywrap(void) {
	return(1);
}
void comment(void) {
	int boolean, first, second;

	boolean = TRUE;
	first = input();
	while (first != EOF && boolean) {
		second = input();
		if (first == '*' && second == '/') {
			boolean = FALSE;
		} else {
			first = second;
		}
	}
	if (first == EOF) {
		fprintf(stderr, "eof in comment\n");
	}
}

