#ifndef PARSER_HPP
#define PARSER_HPP

#include <iostream>
#include <cctype>
#include <string>
#include "scanner.hpp"

class Parser {
public:
    Parser();
    void start();
    
private:
    Scanner scanner;
    Scanner::Token currentToken;

    void expr();
    void match(Scanner::TokenType expectedType);
    void term();
    void rexpr();
    void rterm();
    void factor();
    void error(const std::string& msg);
};

#endif
