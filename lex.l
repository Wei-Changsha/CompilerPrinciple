%{
#include "parser.tab.h"
#include "string.h"
#include "def.h"
int yycolumn=1;
#define YY_USER_ACTION    	yylloc.first_line=yylloc.last_line=yylineno; \
	yylloc.first_column=yycolumn;	yylloc.last_column=yycolumn+yyleng-1; yycolumn+=yyleng;
typedef union {
	int type_int;
	float type_float;
	char type_id[32];
	char type_char;
	
	struct node *ptr;
} YYLVAL;
#define YYSTYPE YYLVAL

%}
%option yylineno

id   	[A-Za-z][A-Za-z0-9]*  
int     [0-9]+
float   ([0-9]*\.[0-9]+)|([0-9]+\.)
char 	\'.\'
comments_single 	 \/\/[^\n]*
comments_multiline   \/\*([^*]|(\*[^"/"]))*\*\/

%%
{int}        		{yylval.type_int=atoi(yytext);return INT;}
{float}      		{yylval.type_float=atof(yytext);return FLOAT;}
{char}			    {yylval.type_char= yytext[1];return CHAR;}
{comments_multiline}    {}
{comments_single}       {}
  
"int"        		{strcpy(yylval.type_id,  yytext);printf("(%d,%s)\n",TYPE,yytext);return TYPE;}
"float"      		{strcpy(yylval.type_id,  yytext);printf("(%d,%s)\n",TYPE,yytext);return TYPE;}
"char"            	{strcpy(yylval.type_id,  yytext);printf("(%d,%s)\n",TYPE,yytext);return TYPE;}


"return"     		{printf("(%d,%s)\n",RETURN,yytext);return RETURN;}
"if"         		{printf("(%d,%s)\n",IF,yytext);return IF;}
"else"       		{printf("(%d,%s)\n",ELSE,yytext);return ELSE;}
"while"      		{printf("(%d,%s)\n",WHILE,yytext);return WHILE;}
"break"			    {printf("(%d,%s)\n",BREAK,yytext);return BREAK;}
"continue"			{printf("(%d,%s)\n",CONTINUE,yytext);return CONTINUE;}

{id}       		{printf("(%d,%s)\n",ID,yytext);strcpy(yylval.type_id,  yytext); return ID;/*由于关键字的形式也符合标识符的规则，所以把关键字的处理全部放在标识符的前面，优先识别*/}
";"				{printf("(%d,%s)\n",SEMI,yytext);return SEMI;}
","				{printf("(%d,%s)\n",COMMA,yytext);return COMMA;}
">"|"<"|">="|"<="|"=="|"!=" {strcpy(yylval.type_id, yytext);printf("(%d,%s)\n",RELOP,yytext);;return RELOP;}
"="				{printf("(%d,%s)\n",ASSIGNOP,yytext);return ASSIGNOP;}
"+"				{printf("(%d,%s)\n",PLUS,yytext);return PLUS;}
"++" 			{printf("(%d,%s)\n",DPLUS,yytext);return DPLUS;}
"-"				{printf("(%d,%s)\n",MINUS,yytext);return MINUS;}
"--"			{printf("(%d,%s)\n",UMINUS,yytext);return DMINUS;}
"*"				{printf("(%d,%s)\n",STAR,yytext);return STAR;}
"/"				{printf("(%d,%s)\n",DIV,yytext);return DIV;}
"&&"         	{printf("(%d,%s)\n",AND,yytext);return AND;}
"||"           	{printf("(%d,%s)\n",OR,yytext);return OR;}
"!"				{printf("(%d,%s)\n",NOT,yytext);return NOT;}
"("				{printf("(%d,%s)\n",LP,yytext);return LP;}
")"				{printf("(%d,%s)\n",RP,yytext);return RP;}
"{"				{printf("(%d,%s)\n",LC,yytext);return LC;}
"}"				{printf("(%d,%s)\n",RC,yytext);return RC;}
"["				{printf("(%d,%s)\n",LM,yytext);return LM;}
"]"				{printf("(%d,%s)\n",RM,yytext);return RM;}
"+=" 			{printf("(%d,%s)\n",PLUSASSIGNOP,yytext);return PLUSASSIGNOP;}
"-=" 			{printf("(%d,%s)\n",MINUSASSIGNOP,yytext);return MINUSASSIGNOP;}
"*="			{printf("(%d,%s)\n",STARASSIGNOP,yytext);return STARASSIGNOP;}
"/="			{printf("(%d,%s)\n",DIVASSIGNOP,yytext);return DIVASSIGNOP;}
[\n]           	{yycolumn=1;}   
[ \r\t]         {}   
.				{printf("Error type A :Mysterious character \"%s\"\n\t at Line %d\n",yytext,yylineno);}
%%

int yywrap()
{
return 1;
}

