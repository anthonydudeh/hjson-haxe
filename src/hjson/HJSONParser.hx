package hjson;

import hjson.Tokenizer;

class HJSONParser {
    public var tokenizer:Tokenizer;
    public var current:Tokenizer.Token;
    public var allowCommas:Bool;

    public function new(text:String, ?allowCommas:Bool = false) {
        this.allowCommas = allowCommas;
        tokenizer = new Tokenizer(text);
        current = tokenizer.nextToken();
    }

    public static function parse(text:String, ?allowCommas:Bool = false):Dynamic {
        return (new HJSONParser(text, allowCommas)).parseValue();
    }

    function parseValue():Dynamic {
        switch(current.type) {
            case Tokenizer.TokenType.LEFT_BRACE: return parseObject();
            case Tokenizer.TokenType.LEFT_BRACKET: return parseArray();
            case Tokenizer.TokenType.STRING: var v = current.value; advance(); return v;
            case Tokenizer.TokenType.NUMBER: var n = Std.parseFloat(current.value); advance(); return n;
            case Tokenizer.TokenType.BOOLEAN: var b = current.value == "true"; advance(); return b;
            case Tokenizer.TokenType.NULL: advance(); return null;
            case Tokenizer.TokenType.IDENTIFIER: var id = current.value; advance(); return id;
            default: return null;
        }
    }

    function parseObject():Dynamic {
        advance(); // skip {
        var obj = new Map<String, Dynamic>();

        while(current.type != Tokenizer.TokenType.RIGHT_BRACE && current.type != Tokenizer.TokenType.EOF) {
            var key:String;
            if(current.type == Tokenizer.TokenType.STRING || current.type == Tokenizer.TokenType.IDENTIFIER) {
                key = current.value;
                advance();
            } else key = "";

            if(current.type == Tokenizer.TokenType.COLON) advance();

            var value = parseValue();
            obj.set(key, value);

            // Optional comma
            if(allowCommas && current.type == Tokenizer.TokenType.COMMA) advance();
        }

        if(current.type == Tokenizer.TokenType.RIGHT_BRACE) advance();
        return obj;
    }

    function parseArray():Dynamic {
        advance(); // skip [
        var arr:Array<Dynamic> = [];

        while(current.type != Tokenizer.TokenType.RIGHT_BRACKET && current.type != Tokenizer.TokenType.EOF) {
            arr.push(parseValue());

            // Optional comma
            if(allowCommas && current.type == Tokenizer.TokenType.COMMA) advance();
        }

        if(current.type == Tokenizer.TokenType.RIGHT_BRACKET) advance();
        return arr;
    }

    function advance():Void {
        current = tokenizer.nextToken();
    }
}
