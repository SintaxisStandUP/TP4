/*	TP 04	BISON	2018

	INTEGRANTES				GRUPO	02

			Cortez, Fracisco Andres 1638130
			Kuric, Mariela			1627740
			Storozuk, Irina Belen	1634355
			Vazquez, Candela Daiana	1646916	

*/

#include <stdio.h>
#include "scanner.h"
#include "parser.h"
//extern int yylexerrs;
//extern int yynerrs;
void yyerror(const char *s);
int main (){

	yylexerrs=0;
	int f;

	switch( yyparse() ){
	case 0:
		puts("Compilación terminada con exito \n");f=0; break;
	case 1:
		puts("Errores de compilacion \n"); f=1; break;
	case 2:
		puts("Memoria insuficiente"); f=2; break;
	}
	
	printf ("Errores lexicos: %d - Errores sintacticos: %d \n", yylexerrs, yynerrs);
	return f;
}

/* Informar cantidad de errores */

void yyerror(const char *s){
	printf("línea #%d: %s\n", yylineno, s);
	return;
	}
