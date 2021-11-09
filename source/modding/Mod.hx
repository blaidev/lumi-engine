package modding;

import flixel.FlxBasic;
import Xml;

class Mod extends FlxBasic {

    public var xml:Xml;

    public var eventData:Array<Array<Dynamic>> = [[]];

    public function new(_xml:Xml) {
        super();
        xml = _xml;
        parse();
    }

    public function parse() {
        for (i in xml.firstElement().elements()) {
            if (i.nodeName == 'Event') {
                eventData.push([i.get("type"), i.get("params"), Std.parseInt(i.get("beat"))]);
            }
        }
    }

    public function sepArrays(typeArr:Array<String>, paramArr:Array<String>, beatArr:Array<Int>) {
        for (i in 0...eventData.length) {
            typeArr.push(eventData[i][0]);
            paramArr.push(eventData[i][1]);
            beatArr.push(eventData[i][2]);
        }
    }
}