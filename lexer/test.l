%{
#include<stdio.h>
#include "symbol_table.c"



void * value;
int yylineno;

void print(void * val, int tk);
%}

comment [{](.)*[}]
delim	[ \t\n]
ws	{delim}+
letter	[A-Za-z]
digit	[0-9]
id	{letter}({letter}|{digit})*
number	{digit}+(\.{digit}+)?(E[+-]?{digit}+)?
relop	([<]([>=])?)|([>]([=])?)|([=])


%%

{ws}				{;}
{comment}			{;}
if				{printf("<IF>\n");}
then				{printf("<THEN>\n");}
else				{printf("<ELSE>\n");}
while				{printf("<WHILE>\n");}
do				{printf("<DO>\n");}
program 			{printf("<PROGRAM>\n");}
integer				{printf("<INTEGER>\n");}
real				{printf("<REAL>\n");}
function			{printf("<FUNCTION>\n");}
procedure			{printf("<PROCEDURE>\n");}
begin				{printf("<BEGIN>\n");}
end				{printf("<END>\n");} 
{number}			{value = (void *)yytext; print(value, NUMBER);}
[+-]|(or)			{value = (void *)yytext; print(value, ADDOP);} 
{relop}				{value = (void *)yytext; print(value, RELOP);}
[*/]|(div)|(mod)|(and)		{value = (void *)yytext; print(value, MULOP);} 
:=				{printf("<ASSIGNOP>\n");}
,				{printf("<COMMA>\n");}
[[]				{printf("<LSQB>\n");}
[]]				{printf("<RSQB>\n");}
[(]				{printf("<LPARENTHESIS>\n");}
[)]				{printf("<RPARENTHESIS>\n");}
[;]				{printf("<SEMICOLON>\n");}
[:]				{printf("<COLON>\n");}
[.]				{printf("<DOT>\n");}
[']				{printf("<SINGLEQUOTE>\n");}
["]				{printf("<DOUBLEQUOTE>\n");}
{id}				{value = installID(yytext, yyleng, ID);print(value, ID);} 

%%
 
int main(int argc, char * argv[]) 
{
	yyin = fopen(argv[1], "r");
 	yylex(); 
	print_table();
}


int yywrap()
{
	return 1;
}

void print(void * value, int tok)
{
	switch(tok)
	{
		case NUMBER:
			printf("<NUMBER, '%f' >\n", atof((char *)value));
			break;
		case ADDOP:
			printf("<ADDOP, '%s' >\n", (char *)value);
			break;
		case RELOP:
			printf("<RELOP, '%s' >\n", (char *)value);
			break;
		case MULOP:
			printf("<MULOP, '%s' >\n", (char *)value);
			break;
		case ID:
			printf("<ID,'%s'>\n", ((ST_entry *)value)->entry.name);
			break;
		default:
			printf("unrecognized\n");
			break;
	}
}
