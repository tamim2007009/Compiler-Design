%{
#include <stdio.h>
int key = 0, iden = 0, opera=0;

%}

variable [a-zA-Z_][_a-zA-Z0-9][;]*

multivariable [_a-zA-Z]*[_a-zA-Z0-9]*[ ]*,[ ]*[_a-zA-Z]*[_a-zA-Z0-9]*[;]*

datatype "inti"|"floati"|"doublei"|"booli"|"stringi"|"chari"|"arrayi"

variabledeclare {datatype}[ ]+{variable}[ ]+,[ ]+{datatype}[ ]+{variable}[ ]*|{datatype}[ ]+{variable}[ ]*

arithopera [ ]*(add|sub|mul|div|mod)[ ]*
logopera [ ]*(and|or|not)[ ]*
compopera [ ]*(eq|neq|lt|le|gt|ge)[ ]*
assignopera [ ]*(assign|addassign|subassign|mulassign|divassign)[ ]*
bitopera [ ]*(andbit|orbit|xorbit|notbit|shl|shr)[ ]*
incdecopera [ ]*(inc|dec)[ ]*

singlec          "//".*   
multilinec        "/*"([^*]|\*+[^*/])*\*+"/"    


%%
{variable} { iden++; }
{multivariable} { iden++; }
{datatype} { key++; }

{arithopera} { opera++; }
{logopera} { opera++; }
{compopera} { opera++; }
{assignopera} { opera++; }
{bitopera} { opera++; }
{incdecopera} { opera++; }

{singlec} { printf("Single line comment-> %s\n", yytext); }
{multilinec} { printf("Multiline line comment-> %s\n", yytext); }




"jodi" { fprintf(yyout, "if statement-> %s\n", yytext); key++; }
"najodi" { fprintf(yyout, "else statement-> %s\n", yytext);key++; }
"repeatUntil" { fprintf(yyout, "while statement-> %s\n", yytext); key++; }
"cycle" { fprintf(yyout, "for statement-> %s\n", yytext);key++; }
"func" { fprintf(yyout, "function statement-> %s\n", yytext);key++; }



. {}
%%

int yywrap() {
    return 1;
}

int main() {
    yyin = freopen("in.txt", "r", stdin);
    yyout = freopen("out.txt", "w", stdout);
    
    if (yyin == NULL || yyout == NULL) {
        perror("File opening failed");
        return 1;
    }

    yylex();
    fprintf(yyout, "hello Tamim!\n");
    fprintf(yyout, "keyword : %d\nvariable : %d\n", key, iden);
    fprintf(yyout, "Operator : %d\n ",opera);
    fclose(yyin);
    fclose(yyout);
    
    return 0;
}
