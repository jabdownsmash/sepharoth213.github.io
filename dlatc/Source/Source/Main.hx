package;

import haxel.Core;
import haxel.KeyboardInput;
import haxel.Key;
import haxel.Time;
import openfl.display.Sprite;
import openfl.Assets;
import openfl.media.SoundChannel;
import haxel.MouseInput;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.media.Sound;
import haxe.Json;
import openfl.events.Event;

//17.1428571429

class Main extends Core {


    public var screenWidth:Int = 400;
    public var screenHeight:Int = 600;
    public var columnStart:Float = 50;
    public var columnWidth:Float;
    public var maxColumns = 5;

    public var spawnY:Float = 0;
    public var columnY:Float = 510;

    public var songSelectIndex:Int = 0;
    public var songs:Array<Dynamic>;

    public var songSelectText:TextField;

    public var combo:Int;
    public var multiplier:Float;

    public var lastReportedPlayheadPosition:Float;
    public var currentSongTime:Float;

    public var currentScaleX:Float;
    public var currentScaleY:Float;

    public var songObjectXOffset:Float;

    public var collectWorld:Bool = false;
    public var avoidWorld:Bool = false;
    public var mazeWorld:Bool = false;
    public var viewport:Sprite;

    // public var playerCollectable:

    public function new()
    {
        super();
        viewport = new Sprite();
        loadTitleScreen();
    }

    public function loadTitleScreen()
    {
        Time.paused = true;
        init();
        var level = new TitleScreen(this);
        drawFrame();
        Time.paused = false;
    }

    public function loadOverworld()
    {
        Time.paused = true;
        init();
        if(collectWorld && avoidWorld && mazeWorld)
        {
            var level = new EndScreen(this);
        }
        else
        {
            var level = new Overworld(this);
        }
        drawFrame();
        Time.paused = false;
    }

    public function loadCollectWorld()
    {
        Time.paused = true;
        init();
        var level = new CollectWorld(this);
        drawFrame();
        Time.paused = false;
    }

    public function loadAvoidWorld()
    {
        Time.paused = true;
        init();
        var level = new AvoidWorld(this);
        drawFrame();
        Time.paused = false;
    }

    public function loadMazeWorld()
    {
        Time.paused = true;
        init();
        var level = new MazeWorld(this);
        drawFrame();
        Time.paused = false;
    }

    public function init()
    {
        removeAll();

        // currentScaleX = stage.stageWidth/screenWidth;
        // currentScaleY = stage.stageHeight/screenHeight;
        scaleX = 1;
        scaleY = 1;

        var background = new Sprite();
        background.graphics.beginFill(0x111122);
        background.graphics.drawRect(0,0,screenWidth,screenHeight);
        background.graphics.endFill();
        addChild(background);

    }

    public function drawFrame()
    {
        x = stage.stageWidth/2 - screenWidth/2;
        y = stage.stageHeight/2 - screenHeight/2;


        var frame = new Sprite();

        frame.graphics.beginFill(0x060615);
        frame.graphics.drawRect(0,0,x,stage.stageHeight);
        frame.graphics.drawRect(x + screenWidth,0,x,stage.stageHeight);
        frame.graphics.drawRect(x,0,screenWidth,y);
        frame.graphics.drawRect(x,y+screenHeight - 1,screenWidth,y + 30);
        frame.graphics.endFill();
        frame.x = -x;
        frame.y = -y;
        addChild(frame);
    }

    public function removeAll()
    {
        while (numChildren > 0) {
            removeChildAt(0);
        }
    }
}