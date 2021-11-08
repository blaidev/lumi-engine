package modding;

import sys.FileSystem;
import lime.utils.Assets;
import flixel.FlxBasic;
import Xml;

class Modchart {

    public var xml:Xml;
    public var file:String;
    
    public function new(file:String) {
        this.file = file;

        if (file != null || file.length > 0) {
            xml = Xml.parse(Assets.getText(Paths.xml(file)));
        } else {
            xml = createTemplate();
        }
    }

    function createTemplate() {
        var s = Xml.createElement("Song");
        var e = Xml.createElement("Event");
        e.set("type", "none");
        e.set("beat", "0");
        s.addChild(e);
        return s;
    }

    public function addEvent(event:String, bpm:Int) {
        var e = Xml.createElement("Event");
        e.set("type", event);
        e.set("beat", Std.string(bpm));
    }

}