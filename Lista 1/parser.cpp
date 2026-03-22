#include "parser.hpp"

Parser::Parser() {
    currentToken = scanner.nextToken(); 
}

void Parser::match(Scanner::TokenType expectedType) {
    if (currentToken.type == expectedType) {
        currentToken = scanner.nextToken();
    } else {
        error("Erro de Sintaxe");
    }
}

void Parser::expr() {
    term();
    rexpr();
}

void Parser::term() {
    factor();
    rterm();
}

void Parser::rexpr() {
    while (currentToken.type == Scanner::OP && (currentToken.value == "+" || currentToken.value == "-")) {
        std::string op = currentToken.value;
        match(Scanner::OP);
        term();
        std::cout << op << " ";
    }
}

void Parser::rterm() {
        while (currentToken.type == Scanner::OP && (currentToken.value == "*" || currentToken.value == "/")) {
        std::string op = currentToken.value;
        match(Scanner::OP);
        factor();
        std::cout << op << " ";
    }
}

void Parser::factor() {
    if (currentToken.type == Scanner::NUM) {
        std::cout << currentToken.value << " ";
        match(Scanner::NUM);
    } else if (currentToken.type == Scanner::ID) {
        std::cout << currentToken.value << " ";
        match(Scanner::ID);
    } else if (currentToken.type == Scanner::LPAREN) {
        match(Scanner::LPAREN);
        expr();
        match(Scanner::RPAREN);
    } else {
        error("Erro de Sintaxe em factor");
    }
}


void Parser::error(const std::string& msg) {
    std::cerr << msg << std::endl;
    exit(1);
}

void Parser::start() {
    while (currentToken.type != Scanner::FIM_ARQUIVO) {
        
        if (currentToken.type == Scanner::END) {
            currentToken = scanner.nextToken();
            continue;
        }
        
        expr(); 
        std::cout << std::endl; 
        
        if (currentToken.type == Scanner::END) {
            currentToken = scanner.nextToken(); 
        } else if (currentToken.type != Scanner::FIM_ARQUIVO) {
            error("Erro de Sintaxe: final de linha inesperado!");
        }
    }
}