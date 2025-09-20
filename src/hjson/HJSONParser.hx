package hjson;

import hjson.tokenizer.*;

class HJSONParser {
    public var tokenizer:Tokenizer;
    public var current:Token;
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
        return switch (current.type) {
            case TokenType.LEFT_BRACE: parseObject();
            case TokenType.LEFT_BRACKET: parseArray();
            case TokenType.STRING:
                var v = current.value;
                advance();
                v;
            case TokenType.NUMBER:
                var n = Std.parseFloat(current.value);
                advance();
                n;
            case TokenType.BOOLEAN:
                var b = current.value == "true";
                advance();
                b;
            case TokenType.NULL:
                advance();
                null;
            case TokenType.IDENTIFIER:
                // treat unquoted identifiers as strings
                var id = current.value;
                advance();
                id;
            default: null;
        }
    }

    function parseObject():Dynamic {
        advance(); // skip {
        var obj = new Map<String, Dynamic>();

        while (current.type != TokenType.RIGHT_BRACE && current.type != TokenType.EOF) {
            var key:String;

            // optional quotes, allow STRING or IDENTIFIER as key
            if (current.type == TokenType.STRING || current.type == TokenType.IDENTIFIER) {
                key = current.value;
                advance();
            } else {
                key = "";
            }

            // optional colon, if it exists, skip
            if (current.type == TokenType.COLON) advance();

            // parse value
            var value = parseValue();
            obj.set(key, value);

            // optional comma, skip if present
            if (allowCommas && current.type == TokenType.COMMA) advance();
        }

        // skip closing brace
        if (current.type == TokenType.RIGHT_BRACE) advance();
        return obj;
    }

    function parseArray():Dynamic {
        advance(); // skip [
        var arr:Array<Dynamic> = [];

        while (current.type != TokenType.RIGHT_BRACKET && current.type != TokenType.EOF) {
            arr.push(parseValue());

            // optional comma
            if (allowCommas && current.type == TokenType.COMMA) advance();
        }

        // skip closing bracket
        if (current.type == TokenType.RIGHT_BRACKET) advance();
        return arr;
    }

    function advance():Void {
        current = tokenizer.nextToken();
    }
}
