%code top{
#include <stdio.h>
#include "scanner.h"
}

%code provides{
	void yyerror(char const *s);
	int yylexerrs;
}

%defines "parser.h"
%output "parser.c"
%token ID CTE PROG VAR COD FIN LEER ESC DEF ASIG
%left '-' '+'
%left '*' '/'
%precedence NEG

%define api.value.type {char *}
%define parse.error verbose

%%
estructura : PROG VAR definicion COD sentencias FIN {if (yynerrs || yylexerrs) YYABORT;}

definicion : DEF variables {printf ("definir %s \n", yytext);}
variables : ID '.' definicion
		  | ID '.';
		
sentencias : lectura | escritura | asignacion;

lectura : LEER '(' listaIdentificadores ')' '.' {printf ("leer \n");}//
		| LEER '(' listaIdentificadores ')' '.' sentencias
		;
escritura : ESC '(' listaExpresiones ')' '.' {printf ("escribir \n");}//
		  | ESC '(' listaExpresiones ')' '.' sentencias
		;
asignacion : ID ASIG expresion '.' {printf ("asignacion \n");}//
			| ID ASIG expresion '.' sentencias
		;
listaIdentificadores : ID | ID ',' listaIdentificadores;
listaExpresiones : expresion | expresion ',' listaExpresiones;

expresion: termino 
		   | expresion '+' termino {printf ("suma \n");}//
		   | expresion '-' termino {printf ("resta \n");}
termino: inversion 
		   | termino '*' inversion  {printf ("multiplicacion \n");}//
		   | termino '/' inversion {printf ("division \n");}
inversion: primaria 
		   | '-' primaria %prec NEG {printf ("inversion \n");}
primaria: ID | CTE | '(' expresion ')';
%%

