package hjson.tokenizer;

class Token {
    public var type:TokenType;
    public var value:String;

    public function new(type:TokenType, value:String) {
        this.type = type;
        this.value = value;
    }

    public function toString():String {
        return 'Token(${type}, "${value}")';
    }
}
