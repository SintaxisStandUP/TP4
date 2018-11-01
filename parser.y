%code top{
#include <stdio.h>
#include "scanner.h"
}

%code provides{
	void yyerror(const char *s);
	int yylexerrs;
	int yynerrs;
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
estructura : PROG VAR definicion COD sentencias FIN {if (yynerrs || yylexerrs) YYABORT; else YYACCEPT;}

//definicion : DEF variables {printf ("definir ");}

//variables : ID '.' definicion {printf (" %s \n", yyval);}
//		  | ID '.' {printf ("%s \n", yyval);}

definicion : definicion DEF variables
		|DEF variables
		| error  '.';

variables : ID '.' {printf ("definir %s \n", yyval);}
		
sentencias : sentencias sentencia | sentencia;

sentencia: lectura | escritura | asignacion | error '.';

lectura : LEER '(' listaIdentificadores ')' '.' {printf ("leer \n");};
escritura : ESC '(' listaExpresiones ')' '.' {printf ("escribir \n");};
asignacion : ID ASIG expresion '.' {printf ("asignacion \n");};

listaIdentificadores : listaIdentificadores ',' ID | ID | error  '.';
listaExpresiones : listaExpresiones ',' expresion | expresion | error  '.';

//expresion: termino  | expresion '+' termino {printf ("suma \n");}
//		   | expresion '-' termino {printf ("resta \n");}//| error  '\n';
//termino: inversion 
//		   | termino '*' inversion  {printf ("multiplicacion \n");}//
//		   | termino '/' inversion {printf ("division \n");}



expresion: expresion '+' termino {printf ("suma \n");}
		|expresion '-' termino{printf ("resta \n");} 
		| termino;
//		| '-' termino %prec NEG;

termino: termino '*' '-' primaria %prec NEG{printf("inversion\n");printf("multiplicacion\n");}
		|termino '*' primaria {printf("multiplicacion\n");}
		|termino '/' '-' primaria %prec NEG{printf("inversion\n");printf("division\n");}
		|termino '/' primaria {printf("division\n");}
		|primaria
		| '-' primaria %prec NEG {printf ("inversion \n");};
		

primaria: ID | CTE | '(' expresion ')' {printf ("parentesis \n");};

%%

