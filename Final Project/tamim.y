%{
    #include <stdio.h>
    #include <stdlib.h>
    void yyerror(const char *);
    int yylex(void);

    extern FILE *yyin;
    extern FILE *yyout;

    int sym[26]; // Symbol table for variables
%}

%token INTEGER VARIABLE
%left '+' '-'
%left '*' '/'
%right UMINUS

%%

program:
        program statement '\n'
        | /* NULL */
        ;

statement:
        expression                 { printf("Result: %d\n", $1); }
        | VARIABLE '=' expression  { 
            sym[$1] = $3; 
            printf("Assigned: %c = %d\n", $1 + 'a', $3); 
        }
        ;

expression:
        INTEGER                    { $$ = $1; }
        | VARIABLE                 { $$ = sym[$1]; }
        | expression '+' expression { $$ = $1 + $3; }
        | expression '-' expression { $$ = $1 - $3; }
        | expression '*' expression { $$ = $1 * $3; }
        | expression '/' expression { 
            if ($3 == 0) {
                yyerror("Division by zero");
                $$ = 0;
            } else {
                $$ = $1 / $3;
            }
        }
        | '-' expression %prec UMINUS { $$ = -$2; }
        | '(' expression ')'       { $$ = $2; }
        ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main(void) {
    // Redirect input and output
    yyin = freopen("input.txt", "r", stdin);
    if (!yyin) {
        perror("Failed to open input file");
        return 1;
    }

    yyout = freopen("output.txt", "w", stdout);
    if (!yyout) {
        perror("Failed to open output file");
        fclose(yyin); // Close input file if output file fails
        return 1;
    }

    // Start parsing
    yyparse();

    // Close files after parsing
    fclose(yyin);
    fclose(yyout);

    return 0;
}
