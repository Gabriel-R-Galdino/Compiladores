%{
#include <stdio.h>
#include <stdlib.h>
%}

/* --- Definições Auxiliares --- */
WS      [ \t\n\r]
LETRA   [a-zA-Z_]
DIGITO  [0-9]
ID      {LETRA}({LETRA}|{DIGITO})*
NUM     {DIGITO}+(\.{DIGITO}+)?
EXPR    \"[^\"]*\"

%%

{WS}            { /* Ignora espaços */ }

"inteiro"       { printf("Token: TYPE | Lexema: %s\n", yytext); }
"real"          { printf("Token: TYPE | Lexema: %s\n", yytext); }
"caracter"      { printf("Token: TYPE | Lexema: %s\n", yytext); }

"se"            { printf("Token: KEY | Lexema: %s\n", yytext); }
"entao"         { printf("Token: KEY | Lexema: %s\n", yytext); }
"senao"         { printf("Token: KEY | Lexema: %s\n", yytext); }
"fimse"         { printf("Token: KEY | Lexema: %s\n", yytext); }
"escolha"       { printf("Token: KEY | Lexema: %s\n", yytext); }
"caso"          { printf("Token: KEY | Lexema: %s\n", yytext); }
"fimescolha"    { printf("Token: KEY | Lexema: %s\n", yytext); }

"ler"           { printf("Token: SYSCALL | Lexema: %s\n", yytext); }
"escrever"      { printf("Token: SYSCALL | Lexema: %s\n", yytext); }

"<-"            { printf("Token: ASSIGN | Lexema: %s\n", yytext); }

"+"             { printf("Token: OP | Lexema: %s\n", yytext); }
"-"             { printf("Token: OP | Lexema: %s\n", yytext); }
"*"             { printf("Token: OP | Lexema: %s\n", yytext); }
"/"             { printf("Token: OP | Lexema: %s\n", yytext); }

"=="            { printf("Token: RELOP | Lexema: %s\n", yytext); }
"<="            { printf("Token: RELOP | Lexema: %s\n", yytext); }
">="            { printf("Token: RELOP | Lexema: %s\n", yytext); }
"<>"            { printf("Token: RELOP | Lexema: %s\n", yytext); }
"<"             { printf("Token: RELOP | Lexema: %s\n", yytext); }
">"             { printf("Token: RELOP | Lexema: %s\n", yytext); }

","             { printf("Token: PUNC | Lexema: %s\n", yytext); }
"("             { printf("Token: PUNC | Lexema: %s\n", yytext); }
")"             { printf("Token: PUNC | Lexema: %s\n", yytext); }

{NUM}           { printf("Token: NUM | Lexema: %s\n", yytext); }
{EXPR}          { printf("Token: EXPR | Lexema: %s\n", yytext); }
{ID}            { printf("Token: ID | Lexema: %s\n", yytext); }

.               { printf("ERRO LÉXICO: %s\n", yytext); }

%%

int yywrap() {
    return 1;
}

int main(int argc, char *argv[]) {
    // Se o usuário passou um argumento (o nome do arquivo)
    if (argc > 1) {
        FILE *arquivo = fopen(argv[1], "r");
        if (!arquivo) {
            printf("Erro: Não foi possível abrir o arquivo '%s'\n", argv[1]);
            return 1;
        }
        // Diz ao Flex para ler do arquivo em vez do teclado
        yyin = arquivo;
    } else {
        printf("Lendo da entrada padrão (digite o código ou use CTRL+C para finalizar):\n");
    }

    yylex();

    return 0;
}