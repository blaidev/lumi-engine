package;

import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.addons.effects.FlxTrail;
import flixel.FlxSprite;
import flixel.FlxG;

class NoteUtil {
    
    var notes:FlxTypedGroup<Note>;
    var staticNotes:FlxTypedGroup<StaticArrow>;
    
    public static function getNotes(notes:FlxTypedGroup<Note>) {
        return PlayState.notes;
    }
    
    public static function getStaticNotes(notes:FlxTypedGroup<StaticArrow>) {
        return PlayState.strumLineNotes;
    }

    function getPlayerStaticNotes(notes:FlxTypedGroup<StaticArrow>) {
        return PlayState.playerStrums;
    }
}