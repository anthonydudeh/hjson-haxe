package;

class HStringTools {

    /**
     Repeat the string "s" "n" times
    */
    public static function repeat(s:String, n:Int):String {
        var result = "";
        for(i in 0...n) result += s;
        return result;
    }

    /**
     Replace all occurrences of "sub" with "by" in "s"
    */
    public static function replace(s:String, sub:String, by:String):String {
        if(sub == "") return s;
        return s.split(sub).join(by);
    }

    /**
     Find the index of character "c" in string "s". Returns -1 if not found
    */
    public static function indexOf(s:String, c:String):Int {
        return s.indexOf(c);
    }

    /**
     Check if string "s" contains "value"
    */
    public static function contains(s:String, value:String):Bool {
        return s.indexOf(value) != -1;
    }

    /**
     Remove leading and trailing spaces from string "s"
    */
    public static function trim(s:String):String {
        return ltrim(rtrim(s));
    }

    /**
     Remove leading spaces from string "s"
    */
    public static function ltrim(s:String):String {
        var l = s.length;
        var r = 0;
        while(r < l && isSpace(s.charCodeAt(r))) r++;
        return s.substr(r, l - r);
    }

    /**
     Remove trailing spaces from string "s"
    */
    public static function rtrim(s:String):String {
        var l = s.length;
        var r = 0;
        while(r < l && isSpace(s.charCodeAt(l - r - 1))) r++;
        return s.substr(0, l - r);
    }

    /**
     Check if character code "c" is a space
    */
    public static function isSpace(c:Int):Bool {
        return (c > 8 && c < 14) || c == 32;
    }

}
