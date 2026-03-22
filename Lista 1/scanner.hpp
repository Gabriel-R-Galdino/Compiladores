#ifndef SCANNER_HPP
#define SCANNER_HPP

#include <iostream>
#include <cctype>
#include <string>
#include <fstream>

class Scanner {
public:
    enum TokenType { NUM, ID, OP, LPAREN, RPAREN, END, FIM_ARQUIVO, ERROR };
    
    struct Token {
        TokenType type;
        std::string value;
    };

    Scanner(); 
    ~Scanner();
    Token nextToken();

private:
    int lookahead;
    std::ifstream arquivo;
    void readChar();
};

#endif