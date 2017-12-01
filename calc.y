%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
int yylex(void);
int mod(int a);
int power(int a,int b);
int modInverse(int a);
void yyerror (const char *msg);
%}

%token  NUM
%left '-' '+'
%left '*' '/'
%precedence NEG
%right '^'

%%

input: %empty
    | input line
    ;

line:
    '\n'
    | exp '\n'    {printf("\nWynik: %d\n",mod($1));}
    ;

exp:
     NUM          {$$ = $1;printf("%d ",mod($$));}
    | exp '+' exp {$$ = mod($1) + mod($3); printf("+ ");}
    | exp '-' exp {$$ = mod($1) - mod($3); printf("- ");}
    | exp '*' exp {$$ = multiplying(mod($1),mod($3)); printf("* ");}
    | exp '/' exp {
         if($3==0){
            yyerror("Dzielenie przez 0.");
        }
        else{
            $$ = mod(multiplying(mod($1),modInverse($3))); printf("/ ");
        }
    }
    | '-' exp  %prec NEG { $$ = (-$2); printf("- ");}
    | exp '^' exp {$$ = mod(power(mod($1), ($3))); printf("^ ");}
    | '(' exp ')' {$$ = mod($2);}
    ;
%%

void yyerror(const char *msg){
    fprintf(stderr, "Błąd.\n");
    exit(1);
}

int mod(int a)
{
    int b = 1234577;
    int r = a % b;
    return r < 0 ? r + b : r;
}

int modp1(int a)
{
    int b = 1234576;
    int r = a % b;
    return r < 0 ? r + b : r;
}

int power(int a,int b){
    int p = 1234577;
    if(b<0) {
        b = modp1(b);
    }
    else {
        b = mod(b);
    }
    int sum = 1;
    for(int i = 0; i < b; i++){
        sum*=a;
        sum=mod(sum);
    }
    return sum;
}

int modInverse(int a)
{
    int m = 1234577;
    int m0 = m, t, q;
    int x0 = 0, x1 = 1;
 
    if (m == 1)
      return 0;
 
    while (a > 1)
    {
        q = a / m;
        t = m;
        m = a % m, a = t; 
        t = x0;
        x0 = x1 - q * x0;
        x1 = t;
    }
    if (x1 < 0)
       x1 += m0;
 
    return x1;
}
int multiplying (int a, int b){
    int sum = 0;
    for(int i= 0; i < b; i++){
        sum+=mod(a);
        sum = mod(sum);
    }
    return sum;
}

int main(){
    yyparse();
    return 1;
}

