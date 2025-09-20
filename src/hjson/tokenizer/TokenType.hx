package hjson.tokenizer;

enum TokenType {
    LEFT_BRACE;      // {
    RIGHT_BRACE;     // }
    LEFT_BRACKET;    // [
    RIGHT_BRACKET;   // ]
    COLON;           // :
    COMMA;           // ,
    STRING;          // "value"
    NUMBER;          // 123, 3.14, -10
    BOOLEAN;         // true / false
    NULL;            // null
    IDENTIFIER;      // unquoted identifiers
    EOF;             // end of file
}
