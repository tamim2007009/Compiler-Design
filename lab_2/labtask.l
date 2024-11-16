%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

char *ans=NULL;
int l=0;


%}

%%

['][a-zA-Z0-9]*['] {

   if(l<yyleng){
    l=yyleng;
    ans=strdup(yytext);
   }
   else if(l==yyleng){
     l=yyleng;
     if(strcmp(yytext,ans)>0){
        ans=strdup(yytext);
     }

   }

}

["] {
    if(l>0){
        printf("Longest word: %s\n", ans);
        l=0;
    }
}

. { }

%%

int yywrap() {  // Corrected function name
    return 1;
}

int main() {
    printf("Enter your expression:\n");
    yylex();
    return 0;
}

// " A quick brown 'fox' jumps 'over' the 'lazy' dog"

// flex filename.l
// gcc lex.yy.c -o tam
// ./tam.exe