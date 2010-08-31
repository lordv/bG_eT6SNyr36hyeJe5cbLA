/*
 * =====================================================================================
 *
 *       Filename:  symbol_table.c
 *
 *    Description:  
 *
 *        Version:  1.0
 *        Created:  Saturday 21 August 2010 03:55:32  IST
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Nihar V Settipalli (CS & E, IIT Madras), niharsettipalli@gmail.com
 *        Company:  
 *
 * =====================================================================================
 */

#include<stdio.h>
#include"symbol_table.h"
#include<stdlib.h>


ST_entry * table[PRIME];

int hashpjw(char * s)
{
	char * p;
	unsigned h = 0, g;
	for(p = s; *p != EOS; p = p+1)
	{
		h = (h << 4) + (*p);
		if(g = h&0xf0000000)
		{
			h = h ^ (g >>24);
			h = h ^ g;
		}
	}
	return h % PRIME;
}


ST_entry * installID(char * s, int len, int tkn)
{
	int hash;
	ST_entry * look = lookup(s);
	if(look != NULL)
	{
		return look;
	}
	else
	{
		char * ptr = malloc((len + 1)*sizeof(char));
		strncpy(ptr, s, len);
		ptr[len] = '\0';
		ST_entry * t = (ST_entry *)malloc(sizeof(ST_entry));
		t->entry.token = tkn;
		t->entry.name = ptr;
		hash = hashpjw(s);
		ST_entry * tem = table[hash];
		t->next = tem;
		table[hash] = t;
		return table[hash];
	}
}


ST_entry * lookup(char * s)
{
	int hash = hashpjw(s);
	
	ST_entry * tem = table[hash];
	while(tem != NULL)
	{
		if(strcmp(tem->entry.name, s) == 0)
			return tem;
		tem = tem->next;
	}
	return NULL;
}
