%{
#include<stdio.h>
#include "symbol_table.c"



void * value;
int yylineno;

void print(void * val, int tk);
%}

comment [{].*[}]
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
if				{printf("<IF>\n");return (IF);}
then				{printf("<THEN>\n");return THEN;}
else				{printf("<ELSE>\n");return ELSE;}
while				{printf("<WHILE>\n");return WHILE;}
do				{printf("<DO>\n");return DO;}
program 			{printf("<PROGRAM>\n");return PROGRAM;}
integer				{printf("<INTEGER>\n");return INTEGER;}
real				{printf("<REAL>\n");return REAL;}
function			{printf("<FUNCTION>\n");return FUNCTION;}
procedure			{printf("<PROCEDURE>\n");return PROCEDURE;}
begin				{printf("<BEGIN>\n");return BEGIN_P;}
end				{printf("<END>\n");return END;} 
{number}			{value = (void *)yytext; print(value, NUMBER);return NUMBER;}
[+-]|(or)			{value = (void *)yytext; print(value, ADDOP);return ADDOP;} 
{relop}				{value = (void *)yytext; print(value, RELOP);return RELOP;}
[*/]|(div)|(mod)|(and)		{value = (void *)yytext; print(value, MULOP);return MULOP;} 
:=				{return ASSIGNOP;}
{id}				{value = installID(yytext, yyleng, ID);print(value, ID); return ID;} 

%%
 
int main(int argc, char * argv[]) 
{
	while(1)
	{
		 yylex(); 
	}
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
			printf("<ID, '%s' >\n", ((ST_entry *)value)->entry.name);
			break;
		default:
			printf("unrecognized\n");
			break;
	}
}
