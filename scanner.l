%top{
#include <stdio.h>
#include "tokens.h"
}
%option header-file="scanner.h"
%option outfile="scanner.c"
%option noinput
%option nounput

L [[:alpha:]]
D [0-9]
LD [[:alnum:]]
S [[:space:]]

O [[:punct:]]{-}[,.()+*/-]
%%
"//".*|" "|\t|\n    	; 
programa		return PROG;
variables		return VAR;
codigo			return COD;
fin			return FIN;
leer			return LEER;
escribir		return ESC;
definir			return DEF;
"+"			return '+';
"-"			return '-';
"*"			return '*';
"/"			return '/';
"<-"			return ASIG;
"("			return '(';
")"			return ')';
","			return ',';
"."			return '.';
{L}{LD}*		return ID;
{D}+			return CTE;
{D}+{LD}*		printf("Error léxico: Constante invalida: %s\n", yytext);
{L}+{O}+({LD}*{O}*)*	printf("Error léxico: Identificador invalido: %s\n", yytext);
{O}+			printf("Error léxico: cadena desconocida: %s\n", yytext); 
%%
