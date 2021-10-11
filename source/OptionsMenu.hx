package;

import flixel.FlxState;
import flixel.addons.ui.FlxButtonPlus;
import flixel.ui.FlxButton;
import Controls.Control;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;

class OptionsMenu extends MusicBeatState
{
	public var buttons:FlxTypedGroup<FlxButtonPlus>;
	public static var callbacks:Array<Void->Dynamic> = [];
	public static var buttonStrings:Array<String> = [];

	public function new() {

		FlxG.save.bind('funkin', "ninjamuffin99");
		//OptionFunctions.reset();
		super();
		FlxG.mouse.visible = true;
		OptionFunctions.addFunctionsToList();
	}

	public override function create() {

		if (Globals.currentSong != 'freakyMenu') {
			FlxG.sound.playMusic(Paths.music('freakyMenu'));
		} else if (Globals.currentSong == 'freakyMenu' && !FlxG.sound.music.playing) {
			FlxG.sound.playMusic(Paths.music('freakyMenu'));
			FlxG.sound.music.time = Globals.menuSongTime;
		}

		var balls = new FlxSprite(0, 0).loadGraphic(Paths.image('menuDesat', 'preload'));
		balls.color = 0xFF228B22;
		add(balls);
		buttons = new FlxTypedGroup<FlxButtonPlus>();
		add(buttons);
		createOptions(170, 0, 4);
		for (i in buttons.members) {
			i.onColor = [FlxColor.GREEN];
			i.offColor = [FlxColor.RED];
		}
		super.create();
	}

	public override function update(elapsed:Float) {
		dumbRender();
		super.update(elapsed);

		Globals.menuSongTime = FlxG.sound.music.time;

		if (controls.BACK || controls.ACCEPT) {
			FlxG.save.flush();
			FlxG.switchState(new MainMenuState());
		}
	}

	function createOptions(x:Float, ?startWhere:Int = 0, ?endWhere:Int = 5) {
		
		var theBaby:Int = 0;

		for (i in 0...buttonStrings.length) {
			var button = new FlxButtonPlus(x, 0, callbacks[i], buttonStrings[i], 125, 65);
			button.y = ((button.y + 80) * i) + 45;
			theBaby++;
			button.onClickCallback = callbacks[i]; // just make sure
			buttons.add(button);
		}
	}

	function dfjkString() {
		return FlxG.save.data.dfjk ? "DFJK Keybinds\nOn" : "DFJK Keybinds\nOff";
	}

	function ghostString() {
		return FlxG.save.data.ghost ? "Ghost Tapping\nOn" : "Ghost Tapping\nOff";
	}

	function noteString() {
		return FlxG.save.data.notesplash ? "Note Splashes\nOn" : "Note Splashes\nOff";
	}

	function cursedString() {
		return FlxG.save.data.cursed ? "1356\nOn" : "1356\nOff"; 
	}

	function downscrollString() {
		return FlxG.save.data.downscroll ? "Downscroll\nOn" : "Downscroll\nOff";
	}

	public function dumbRender() {
		var bs = buttons.members;
		bs[0].text = dfjkString();
		bs[1].text = downscrollString();
		bs[2].text = ghostString();
		bs[3].text = noteString();
		bs[4].text = cursedString();
	}
}

class OptionFunctions {
	
	public static var callbacksArray:Array<Void->Dynamic> = [];

	public static function addFunctionsToList() {
		pushStuff();
		for (i in callbacksArray) {
			OptionsMenu.callbacks.push(i);
		}
		OptionsMenu.buttonStrings = ['DFJK', 'Downscroll', 'Ghost Tapping', 'Note Splashes', '1356'];
	}
	
	public static function setDFJK():String {
		FlxG.save.data.dfjk = !FlxG.save.data.dfjk;
		FlxG.save.data.cursed = false;
		FlxG.save.flush();
		return FlxG.save.data.dfjk ? "DFJK Keybinds\nOn" : "DFJK Keybinds\nOff";
	}

	public static function setGhostTapping():String {
		FlxG.save.data.ghost = !FlxG.save.data.ghost;
		FlxG.save.flush();
		return FlxG.save.data.ghost ? "Ghost Tapping\nOn" : "Ghost Tapping\nOff";
	}

	public static function setNoteSplashes():String {
		FlxG.save.data.notesplash = !FlxG.save.data.notesplash;
		FlxG.save.flush();
		return FlxG.save.data.notesplash ? "Note Splashes\nOn" : "Note Splashes\nOff";
	}

	public static function set1356() {
		FlxG.save.data.cursed = !FlxG.save.data.cursed;
		FlxG.save.data.dfjk = false;
		FlxG.save.flush();
		return FlxG.save.data.notesplash ? "1356\nOn" : "1356\nOff";
	}

	public static function setDownscroll() {
		FlxG.save.data.downscroll = !FlxG.save.data.downscroll;
		FlxG.save.flush();
		return FlxG.save.data.downscroll ? "Downscroll On\n" : "Downscroll\nOff";
	}

	static function pushStuff() {
		callbacksArray.push(setDFJK);
		callbacksArray.push(setDownscroll);
		callbacksArray.push(setGhostTapping);
		callbacksArray.push(setNoteSplashes);
		callbacksArray.push(set1356);
	}

	public static function reset() {
		// shit be4 release lmao
		FlxG.save.data.dfjk = false;
		FlxG.save.data.ghost = true; // idk
		FlxG.save.data.notesplash = true;
		FlxG.save.data.cursed = false;
		FlxG.save.data.downscroll = false;
		FlxG.save.flush();
	}
}