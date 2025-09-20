# hjson4haxe
![logo](https://github.com/YuriwasNOThere/hjson4haxe/blob/main/logobetter.png)

A Haxe library that handles and allows hjson files parsing.

   ![Haxe](https://img.shields.io/badge/haxe-4.3.4-blue)
   ![License](https://img.shields.io/badge/license-MIT-green)

**It supports:**
- Parsing HJSON strings and files
- Writing Dynamic objects to HJSON strings or files
- Optional commas
- Pretty formatting
- Arrays, objects, strings, numbers, booleans, nulls

# Installation
You can use two methods, one:
**Use Github**
```bash
haxelib git hjson4haxe https://github.com/YuriwasNOThere/hjson4haxe
```
Second, is:
**Use Haxelib**
```bash
haxelib install hjson4haxe
```

# Usage Example:
```hx
import hjson.HJSON;

class Main {
    static function main() {
        // Example HJSON string
        var text = "{ name: \"hjson4haxe\" version: 1.0.0 features: [\"parser\" \"writer\"] }";

        // Parse string into Dynamic object
        var obj = HJSON.parse(text, true); // allow commas

        // Access a field
        trace(obj.get("name")); // hjson4haxe

        // Add a new field
        obj.set("author", "Anthony");

        // Save to file with pretty formatting and optional commas
        HJSON.saveToFile(obj, "output.hjson", true, true);

        // Load file back
        var loaded = HJSON.parseFile("output.hjson", true);
        trace(loaded.get("author")); // Anthony
    }
}
```
**Output File:**
```hjson
{
    name: "hjson4haxe",
    version: 1.0.0,
    features: [
        "parser",
        "writer"
    ],
    author: "Anthony"
}
```
# Notes:
- Optional commas are included (between properties and array elements).
- Pretty formatting adds indentation and newlines.
- You can turn off commas and pretty formatting by passing false to `saveToFile()` parameters.
- 
