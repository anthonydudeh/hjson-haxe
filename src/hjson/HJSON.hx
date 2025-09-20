package hjson;

import sys.io.File;

class HJSON {
    // Parsing Functions

    /**
     * Parse a HJSON string into a Dynamic object (Map, Array, primitives)
     * @param text The HJSON string
     * @param allowCommas Optional, allow commas between elements
     */
    public static function parse(text:String, ?allowCommas:Bool = false):Dynamic {
        return HJSONParser.parse(text, allowCommas);
    }
    // File I/O Functions

    /**
     * Parse a HJSON file into a Dynamic object
     * @param path Path to the HJSON file
     * @param allowCommas Optional, allow commas
     */
    public static function parseFile(path:String, ?allowCommas:Bool = false):Dynamic {
        var content = File.getContent(path);
        return parse(content, allowCommas);
    }
    /**
     * Save a Dynamic object as a HJSON file
     * @param value Object to save
     * @param path File path to save to
     * @param pretty Optional: add indentation/newlines
     * @param useCommas Optional, include commas between elements
     */
    public static function saveToFile(value:Dynamic, path:String, ?pretty:Bool = true, ?useCommas:Bool = false):Void {
        var content = stringify(value, pretty, useCommas);
        File.saveContent(path, content);
    }
    // Writing Functions

    /**
     * Convert a Dynamic object into a HJSON string
     * @param value Object to convert (Map, Array, primitives)
     * @param pretty Optional: add indentation/newlines
     * @param useCommas Optional: include commas between elements
     */
    public static function stringify(value:Dynamic, ?pretty:Bool = true, ?useCommas:Bool = false):String {
        return HJSONWriter.stringify(value, pretty, useCommas);
    }
}
