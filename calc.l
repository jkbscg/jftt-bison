%{
#include <stdio.h>
#include <stdlib.h>
#include "calc.tab.h"
%}

%%
^\#.*\n                     { ; }
[0-9]+                      {yylval = atoi(yytext); return NUM;}
[\n\/]                      {return yytext[0]; printf("%s",yytext[0]);}
[-+()\*\^]                  {return yytext[0]; printf("%s",yytext[0]);}
[ \t]+                      { ; }
.                           {printf("Zły znak\n"); exit(1);}
%%


int yywrap(void) {
    return 1;
}