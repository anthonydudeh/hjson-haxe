# hjson4haxe
![logo](https://github.com/anthonydudeh/hjson-haxe/blob/main/hlogo.png)

A Haxe library that handles and allows hjson files parsing.

![License](https://img.shields.io/badge/license-MIT-green)

## Features

- Parse and stringify HJSON files.
- Optional quotes and commas in syntax.
- File read/write support (`parseFile` and `saveToFile`).

## Installation
```bash
haxelib install hjson4haxe
```
or:
```bash
haxelib git hjson4haxe https://github.com/anthonydudeh/hjson-haxe
```

## Usage

**Parsing HJSON string:**
```haxe
import hjson.HJSON;

class Main {
    static function main() {
        var data = HJSON.parse("{user: 'Anthony', age: 20}", true);
        trace(data.user); // Anthony
    }
}
```

**Writing HJSON string:**
```haxe
var output = HJSON.stringify(data, true, true);
trace(output);
```

**Reading and saving files**
```haxe
HJSON.saveToFile(data, "data.hjson");
var readData = HJSON.parseFile("data.hjson", true);
```
