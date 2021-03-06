/*
 * =====================================================================================
 *
 *       Filename:  symbol_table.h
 *
 *    Description:  symbol table header
 *
 *        Version:  1.0
 *        Created:  Saturdaya 21 August 2010 03:39:31  IST
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Nihar V Settipalli (CS & E, IIT Madras), niharsettipalli@gmail.com
 *        Company:  
 *
 * =====================================================================================
 */


#ifndef  SYMBOL_TABLE_INC
#define  SYMBOL_TABLE_INC

#include<stdlib.h>
#include<string.h>

#define OFFSET 1000
#define PRIME 211
#define EOS '\0'

typedef struct
{
	int token;
	char * name;
} ST_element;

typedef struct arbit
{
	ST_element entry;
	struct arbit * next;
} ST_entry;

enum
{
	IF = OFFSET,
	ELSE,
	THEN,
	WHILE,
	DO,
	PROGRAM,
	INTEGER,
	REAL,
	FUNCTION,
	PROCEDURE,
	BEGIN_P,
	END,
	ID,
	NUMBER,
	RELOP,
	ADDOP,
	MULOP,
	ASSIGNOP,
	COMMA,
	LSQB,
	RSQB,
	LPARENTHESIS,
	RPARENTHESIS,
	SEMICOLON,
	COLON,
	DOT,
	SINGLEQUOTE,
	DOUBLEQUOTE
};

int hashpjw(char * s);					//hash function

ST_entry * installID(char * s, int len, int tok);	//to installID in the table

ST_entry * lookup(char * s);				//To lookup in the table

void print_table();					//to print the table

#endif   /* ----- #ifndef SYMBOL_TABLE_INC  ----- */
