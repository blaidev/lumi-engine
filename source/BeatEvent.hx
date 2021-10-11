package;

import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxBasic;

class BeatEvent extends FlxBasic {
    
    public var beat:Int;
    public var callback:Void->Void;
    private var curBeat:Int;
    @:optional var curStep:Int;

// im too depressed to add this to chartin

    public function new(beat, callback:Void->Void) {
        super();
        this.beat = beat;
        this.callback = callback;
        BeatEventHandler.beatEvents.add(this);
    }

    public override function update(elapsed:Float) {
        curBeat = PlayState.currentBeat;
        curStep = PlayState.currentStep;

        if (beat == curBeat) {
            callback();
        }

        super.update(elapsed);
    }
}

class BeatEventHandler {
    public static var beatEvents:FlxTypedGroup<BeatEvent> = new FlxTypedGroup<BeatEvent>();

    public static function clear() {
        beatEvents.clear();
    }
}