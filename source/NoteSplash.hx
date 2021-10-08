package;

import flixel.FlxG;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.FlxSprite;

class NoteSplash extends FlxSprite {
    
    // taken from pysch engine kinda...lol

    var tex:FlxAtlasFrames;
    
    public function new(x:Float = 0, y:Float = 0) {
        super(x, y);
        tex = Paths.getSparrowAtlas('noteSplashes', 'preload');
        frames = tex;
		animation.addByPrefix("BLUE", "note splash blue " + 1, 24, false);
		animation.addByPrefix("GREEN", "note splash green " + 1, 24, false);
		animation.addByPrefix("PURPLE", "note splash purple " + 1, 24, false);
		animation.addByPrefix("RED", "note splash red " + 1, 24, false);
        animation.addByPrefix("BLUEalt", "note splash blue " + 2, 24, false);
		animation.addByPrefix("GREENalt", "note splash green " + 2, 24, false);
		animation.addByPrefix("PURPLEalt", "note splash purple " + 2, 24, false);
		animation.addByPrefix("REDalt", "note splash red " + 2, 24, false);
        scrollFactor.set();
        setupShit();

        if (PlayState.storyWeek != 6) {
            antialiasing = true;
        } else {
            antialiasing = false;
        }
    }

    function setupShit() {
        setPosition(x - Note.swagWidth * 0.95, y - Note.swagWidth);
        offset.set(10, 10);
    }

    public function addAnims() {

    }

    public override function update(elapsed:Float) {
        super.update(elapsed);
        if (animation.curAnim != null)
            if (animation.curAnim.finished)
                kill();
    }
}