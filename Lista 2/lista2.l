%{
/* Definições das constantes*/
#define LT 256
#define LE 257
#define EQ 258
#define NE 259
#define GT 260
#define GE 261
#define IF 262
#define THEN 263
#define ELSE 264
#define ID 265
#define NUMBER 266
#define RELOP 267
#define SYM 268

/* Definições adicionais para o portugol */
#define REAL 269
#define CARACTER 270
#define LER 271
#define ESCREVER 272
#define ESCOLHA 273
#define CASO 274
#define FIMSE 275
#define FIMESCOLHA 276
#define ATRIB 277
#define STRING_LITERAL 290
#define FIMLINHA 291 

#include<stdio.h>
#include<math.h>
#include<stdlib.h>

int linha = 0;
int in;
double dn;
%}

%option outfile="analisador.c"

/* Definições Regulares */
digit    [0-9]
inum     {digit}+
fnum     {inum}(\.{inum})?
letter   [a-zA-Z_]
id       {letter}({letter}|{digit})*
ws       [ \t]+
expr     \"[^\"]*\"

%%

"<-"             {return(ATRIB);}
"<="             {in = LE; return(RELOP);}
"<>"             {in = NE; return(RELOP);}
">="             {in = GE; return(RELOP);}
"=="             {in = EQ; return(RELOP);}
"<"              {in = LT; return(RELOP);}
">"              {in = GT; return(RELOP);}

{expr}           {return(STRING_LITERAL);}
"if"             {return(IF);}
"then"           {return(THEN);}
"else"           {return(ELSE);}
"real"           {return(REAL);}
"caracter"       {return(CARACTER);}
"ler"            {return(LER);}
"escrever"       {return(ESCREVER);}
"escolha"        {return(ESCOLHA);}
"caso"           {return(CASO);}
"fimse"          {return(FIMSE);}
"fimescolha"     {return(FIMESCOLHA);}

{id}             {return(ID);}
{inum}           {dn = 0; in = atoi(yytext); return(NUMBER);}
{fnum}           {dn = atof(yytext); return(NUMBER);}

{ws}             {} // Ignora espaços e tabulações
"\n"             {linha++; return FIMLINHA;}

[\+\-\*\/\=\(\)\;\,] {in = (int)yytext[0]; return(SYM);}

%%

int yywrap() {
    return 1;
}

int main(int argc, char **args) {
    FILE *input;
    int res;
    if (argc < 2) {
        printf("Uso: %s <nome_do_arquivo>\n", args[0]);
        return 1;
    }
    input = fopen(args[1],"r");
    if (input == NULL) {
        printf("Não foi possível abrir o arquivo %s\n", args[1]);
        return 1;
    }
    yyin = input;
    do {
        res = yylex();
        if (res == ID) {
            printf("<%d,%s>\n", res, yytext);
        } else if (res == NUMBER) {
            if (dn == 0) printf("<%d,%d>\n", res, in);
            else printf("<%d,%lf>\n", res, dn);
        } else if (res == RELOP) {
            printf("<%d,%d>\n", res, in);
        } else if (res == SYM) {
            printf("<%d,%d>\n", res, in);
        } else if (res == STRING_LITERAL) {
            printf("<%d,%s>\n", STRING_LITERAL, yytext);
        } else if (res != 0 && res != FIMLINHA) { 
            printf("<%d>\n", res);
        }
    } while(res != 0);
    fclose(input);
    return 0;
}