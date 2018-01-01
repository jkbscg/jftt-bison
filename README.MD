bison -d calc.y
flex calc.y
gcc -o calc lex.yy.c calc.tab.c -lfl -lm
