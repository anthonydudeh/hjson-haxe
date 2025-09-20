package hjson;

import sys.io.File;
import hjson.HJSONParser;
import hjson.HJSONWriter;

class HJSON {

    /**
     * Parse HJSON string into Dynamic object (Map, Array, etc.)
     * @param text The HJSON string to parse
     * @param allowCommas Optional: allow commas between elements (HJSON style)
     */
    public static function parse(text:String, ?allowCommas:Bool = false):Dynamic {
        return HJSONParser.parse(text, allowCommas);
    }

    /**
     * Parse a HJSON file into a Dynamic object
     * @param path Path to the HJSON file
     * @param allowCommas Optional: allow commas
     */
    public static function parseFile(path:String, ?allowCommas:Bool = false):Dynamic {
        var content = File.getContent(path);
        return parse(content, allowCommas);
    }

    /**
     * Convert Dynamic object into HJSON string
     * @param value Object to convert
     * @param pretty Optional: add indentation and newlines
     * @param useCommas Optional: include commas between elements
     */
    public static function stringify(value:Dynamic, ?pretty:Bool = true, ?useCommas:Bool = false):String {
        return HJSONWriter.stringify(value, pretty, useCommas);
    }

    /**
     * Save Dynamic object as HJSON file
     * @param value Object to save
     * @param path Path where file will be created/overwritten
     * @param pretty Optional: add indentation/newlines
     * @param useCommas Optional: include commas
     */
    public static function saveToFile(value:Dynamic, path:String, ?pretty:Bool = true, ?useCommas:Bool = false):Void {
        var content = stringify(value, pretty, useCommas);
        File.saveContent(path, content);
    }
}
