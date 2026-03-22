#include "scanner.hpp"
#include <cstdlib>

Scanner::Scanner() {
    arquivo.open("entrada.txt");
    
    if (!arquivo.is_open()) {
        std::cerr << "Erro: Nao foi possivel abrir o arquivo 'entrada.txt'!" << std::endl;
        exit(1); 
    }
    
    readChar(); 
}

Scanner::~Scanner() {
    if (arquivo.is_open()) arquivo.close();
}

void Scanner::readChar() {
    lookahead = arquivo.get();
}

Scanner::Token Scanner::nextToken() {
    while (lookahead == ' ' || lookahead == '\t' || lookahead == '\r') {
        readChar();
    }

    if (lookahead == EOF) {
        return {FIM_ARQUIVO, ""};
    }

    if (lookahead == '\n') {
        readChar(); 
        return {END, ""};
    }

    if (isdigit(lookahead)) {
        std::string num;
        while (isdigit(lookahead)) {
            num += lookahead;
            readChar();
        }
        return {NUM, num};
    }

    if (isalpha(lookahead)) {
        std::string id;
        while (isalnum(lookahead)) {
            
            id += lookahead;
            readChar();
        }
        return {ID, id};
    }

    if (lookahead == '+' || lookahead == '-' || lookahead == '*' || lookahead == '/') {
        char op = lookahead;
        readChar();
        return {OP, std::string(1, op)};
    }

    if (lookahead == '(') {
        readChar();
        return {LPAREN, "("};
    }

    if (lookahead == ')') {
        readChar();
        return {RPAREN, ")"};
    }

    if (isspace(lookahead) || EOF) return {END, ""};

    return {ERROR, std::string(1, lookahead)};
}
