%top{
#include <stdio.h>
//#include "tokens.h"
#include "parser.h"
}
%option header-file="scanner.h"
%option outfile="scanner.c"
%option yylineno
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
{L}{LD}*		{yylval = strdup(yytext); return ID;}
{D}+			{yylval = strdup(yytext); return CTE;}
{D}+{LD}*		{yylexerrs++; yyerror("Error léxico: constante  invalida ");printf("%s\n",yytext);}
{L}+{O}+({LD}*{O}*)*	{yylexerrs++; yyerror("Error léxico: identificador invalido ");printf("%s\n",yytext);}
{O}+			{yylexerrs++; yyerror("Error léxico: cadena desconocida ");printf("%s\n",yytext);}
%%

