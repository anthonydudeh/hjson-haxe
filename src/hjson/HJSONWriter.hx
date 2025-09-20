package hjson;

import Reflect;

using StringTools;

class HJSONWriter {

    public static function stringify(value:Dynamic, ?pretty:Bool = true, ?useCommas:Bool = false, ?indent:Int = 0):String {
        switch(Type.typeof(value)) {
            case TNull: return "null";
            case TInt, TFloat: return Std.string(value);
            case TBool: return if(value) "true" else "false";
            case TString: return "\"" + escapeString(value) + "\"";
            case TObject: return writeObject(value, pretty, indent, useCommas);
            case TClass, TEnum, TFunction: return Std.string(value);
            default: return Std.string(value);
        }
    }

    private static function writeObject(obj:Dynamic, pretty:Bool, indent:Int, useCommas:Bool):String {
        var result = "{";
        var keys = Reflect.fields(obj);
        var sep = pretty ? "\n" : " ";

        for(i in 0...keys.length) {
            var key = keys[i];
            var value = Reflect.field(obj, key);
            var ind = pretty ? StringTools.repeat("  ", indent + 1) : "";
            result += sep + ind + "\"" + key + "\": " + stringify(value, pretty, useCommas, indent + 1);
            
            if(useCommas && i < keys.length - 1) result += ",";
        }

        if(pretty && keys.length > 0) result += "\n" + StringTools.repeat("  ", indent);
        result += "}";
        return result;
    }

    private static function writeArray(arr:Array<Dynamic>, pretty:Bool, indent:Int, useCommas:Bool):String {
        var result = "[";
        var sep = pretty ? "\n" : " ";

        for(i in 0...arr.length) {
            var value = arr[i];
            var ind = pretty ? StringTools.repeat("  ", indent + 1) : "";
            result += sep + ind + stringify(value, pretty, useCommas, indent + 1);
            if(useCommas && i < arr.length - 1) result += ",";
        }

        if(pretty && arr.length > 0) result += "\n" + StringTools.repeat("  ", indent);
        result += "]";
        return result;
    }

    private static function escapeString(str:String):String {
        return StringTools.replace(StringTools.replace(str, "\\", "\\\\"), "\"", "\\\"");
    }
}
