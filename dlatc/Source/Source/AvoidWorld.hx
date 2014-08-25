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
import openfl.display.Tilesheet;

class AvoidWorld extends World {

    public var lineBackground:Sprite;

    public var columnStart:Float = 50;
    public var columnWidth:Float;
    public var maxColumns:Int;

    public var collectable:SongObject;
    public var obstacles:Array<SongObject>;

    public var hasCollectable:Bool;

    public var collectableSprite:Tilesheet;
    public var obstacleSprite:Tilesheet;

    public var overworldTeleporter:SongObject;
    public var overworldTeleporterSprite:Tilesheet;

    public function new(main:Main)
    {
        bpm = 112;
        maxColumns = 5;
        song = Assets.getSound('assets/lvl2-base.ogg');
        song2 = Assets.getSound('assets/lvl2-add.ogg');
        loopBeats = 128;

        super(main);
        // drawBackground(maxColumns,4);

        overworldTeleporterSprite = createSprite(0xDDDDDD,30,loopBeats*(1/bpm*60*1000)*objectBaseSpeed/4);
        overworldTeleporter = spawnObject(30,overworldTeleporterSprite,113,instance.screenWidth/2+100);

        collectableSprite = createSprite(0x11DD22,12,loopBeats*(1/bpm*60*1000)*objectBaseSpeed/4);
        obstacleSprite = createSprite(0xDD2211,20,loopBeats*(1/bpm*60*1000)*objectBaseSpeed/4);

        collectable = spawnObject(12,collectableSprite,6,200);

        obstacles = new Array<SongObject>();
        obstacles.push(spawnObject(20,obstacleSprite,30,240));
        obstacles.push(spawnObject(20,obstacleSprite,32,180));
        obstacles.push(spawnObject(20,obstacleSprite,33,40));
        obstacles.push(spawnObject(20,obstacleSprite,33,80));
        obstacles.push(spawnObject(20,obstacleSprite,34,340));
        obstacles.push(spawnObject(20,obstacleSprite,35,240));
        obstacles.push(spawnObject(20,obstacleSprite,36,300));
        obstacles.push(spawnObject(20,obstacleSprite,38,110));
        obstacles.push(spawnObject(20,obstacleSprite,41,90));
        obstacles.push(spawnObject(20,obstacleSprite,42,120));
        obstacles.push(spawnObject(20,obstacleSprite,44,380));
        obstacles.push(spawnObject(20,obstacleSprite,44,200));

        start();
    }

    public function drawBackground(numColumns:Int,lineWidth:Float)
    {
        columnWidth = instance.screenWidth/maxColumns;
        lineBackground = new Sprite();
        lineBackground.graphics.beginFill(0x050507);
        for(i in -numColumns...numColumns * 2)
        {
            lineBackground.graphics.drawRect(columnStart + i*columnWidth - lineWidth/2,0,lineWidth,instance.screenHeight);
        }
        lineBackground.graphics.endFill();
        // instance.addChildAt(lineBackground, instance.getChildIndex(player));
    }

    public override function update(deltaTime:Float)
    {   
        super.update(deltaTime);
        collectableContainer.rotation += 3;
        if(check(collectable))
        {
            hasCollectable = true;
        }
        for(obstacle in obstacles)
        {
            if(check(obstacle))
            {
                hasCollectable = false;
            }
        }
        if(hasCollectable)
        {
            collectable.visible = false;
            playerCollectable.visible = true;
            if(!playing)
            {
                soundChannel2 = song2.play (soundChannel.position,-1);
                playing = true;
            }
        }
        else
        {
            collectable.visible = true;
            playerCollectable.visible = false;
            if(soundChannel2 != null)
            {
                soundChannel2.stop();
            }
            playing = false;
        }
        if(check(overworldTeleporter) && hasCollectable )
        {
            soundChannel.stop();
            soundChannel2.stop();
            instance.avoidWorld = true;
            instance.loadOverworld();
        }
    }
}