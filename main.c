/*	TP 04	BISON	2018

	INTEGRANTES				GRUPO	02

			Cortez, Fracisco Andres 1638130
			Kuric, Mariela			1627740
			Storozuk, Irina Belen	1634355
			Vazquez, Candela Daiana	1646916	

*/

#include <stdio.h>
#include "scanner.h"
extern int yylexerrs;
void yyerror(const char *s);
int main (){

	yylexerrs=0;

	switch( yyparse() ){
	case 0:
		puts("Compilación terminada con exito \n"); return 0;
	case 1:
		puts("Errores de compilacion: \n"); return 1;
	case 2:
		puts("Memoria insuficiente"); return 2;
	}
	return 0;
}

/* Informar cantidad de errores */

void yyerror(const char *s){
	printf("línea #%d: %s\n", yylineno, s);
	return;
	}
