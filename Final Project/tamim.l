%{
    #include "tamim.tab.h"
    #include <stdlib.h>
    void yyerror(const char *);
%}

%%

[a-z]       {
                yylval = *yytext - 'a';
                return VARIABLE;
            }

[0-9]+      {
                yylval = atoi(yytext);
                return INTEGER;
            }

[-+()=*/\n] { return *yytext; }

[ \t]       ; /* Ignore whitespace */

.           yyerror("Unknown character");

%%

int yywrap(void) {
    return 1;
}
