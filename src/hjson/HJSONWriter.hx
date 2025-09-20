package hjson;

import EReg;
import Std;
import HStringTools;
import Type;
import Reflect;

class HJSONWriter {

    /**
     * Convert a Dynamic object to a HJSON string
     * @param v Object to stringify
     * @param pretty Optional: add indentation and newlines
     * @param useCommas Optional: include commas
     */
    public static function stringify(v:Dynamic, ?pretty:Bool = true, ?useCommas:Bool = false):String {
        return writeValue(v, 0, pretty, useCommas);
    }

    static function writeValue(v:Dynamic, indent:Int, pretty:Bool, useCommas:Bool):String {
        switch (v) {
            case null: return "null";
            case _: 
                if (Std.isOfType(v, String)) return escapeString(v);
                else if (Std.isOfType(v, Int) || Std.isOfType(v, Float)) return Std.string(v);
                else if (Std.isOfType(v, Bool)) return if (v) "true" else "false";
                else if (Std.isOfType(v, Array)) return writeArray(cast v, indent, pretty, useCommas);
                else return writeObject(v, indent, pretty, useCommas);
        }
    }

    static function writeObject(o:Dynamic, indent:Int, pretty:Bool, useCommas:Bool):String {
        var fields:Array<String> = Reflect.fields(o);
        var result = "{";

        if (pretty && fields.length > 0) result += "\n";

        for (i in 0...fields.length) {
            var key = fields[i];
            var value = Reflect.field(o, key);

            if (pretty) result += HStringTools.repeat("  ", indent + 1);
            result += escapeKey(key) + ": " + writeValue(value, indent + 1, pretty, useCommas);

            if (i < fields.length - 1 && useCommas) result += ",";
            if (pretty) result += "\n";
        }

        if (pretty && fields.length > 0) result += HStringTools.repeat("  ", indent);
        result += "}";
        return result;
    }

    static function writeArray(a:Array<Dynamic>, indent:Int, pretty:Bool, useCommas:Bool):String {
        var result = "[";

        if (pretty && a.length > 0) result += "\n";

        for (i in 0...a.length) {
            var value = a[i];
            if (pretty) result += HStringTools.repeat("  ", indent + 1);
            result += writeValue(value, indent + 1, pretty, useCommas);

            if (i < a.length - 1 && useCommas) result += ",";
            if (pretty) result += "\n";
        }

        if (pretty && a.length > 0) result += HStringTools.repeat("  ", indent);
        result += "]";
        return result;
    }

    static function escapeString(s:String):String {
        var r = new EReg("\"", "g");
        return "\"" + r.replace(s, "\\\"") + "\"";
    }

    static function escapeKey(s:String):String {
        // If the key contains spaces or special characters, quote it
        var needsQuote = !Std.isOfType(s, String) || HStringTools.contains(s, " ") || HStringTools.contains(s, "\"") || HStringTools.contains(s, "\n");
        if (needsQuote) return escapeString(s);
        return s;
    }
}
