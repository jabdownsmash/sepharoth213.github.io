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
import openfl.display.BitmapData;
import openfl.display.Tilesheet;
import openfl.geom.Rectangle;

class World {

    public var player:Sprite;
    public var song:Sound;
    public var song2:Sound;
    public var songObjects:Array<SongObject>;
    public var soundChannel:SoundChannel;
    public var soundChannel2:SoundChannel;

    public var playerSpeed = 3;

    public var bpm:Float;
    public var objectBaseSpeed:Float;

    public var columnY:Float = 525;

    public var lastReportedPlayheadPosition:Float;
    public var currentSongTime:Float;

    public var songObjectXOffset:Float;

    public var instance:Main;

    public var loopBeats:Int;

    public var playerVelocity:Float = 0;
    public var playerAcceleration:Float = 1.2;
    public var playerMaxSpeed:Float = 5;
    public var friction:Float = .5;
    public var playerSize:Float = 15;

    public var playerCollectable:Sprite;
    public var collectableContainer:Sprite;

    public var playing:Bool = false;

    public function addChild(child:Dynamic)
    {
        instance.addChild(child);
    }

    public function new(main:Main)
    {
        instance = main;
        playing = false;
        songObjectXOffset = 0;
        songObjects = new Array<SongObject>();
        // spawnObjects(songData);

        objectBaseSpeed = columnY/(1/bpm*60*1000)/4;

        lastReportedPlayheadPosition = 0;
        currentSongTime = 0;

        addChild(instance.viewport);
        SongObject.viewport = instance.viewport;

        player = new Sprite();
        player.graphics.beginFill(0xDDEEDD);
        player.graphics.drawCircle(0,0,playerSize);
        player.graphics.endFill();

        player.x = instance.screenWidth/2;
        player.y = columnY;
        addChild(player);

        playerCollectable = new Sprite();

        playerCollectable.graphics.beginFill(0x11DD22);
        playerCollectable.graphics.drawCircle(0,0,12);
        playerCollectable.graphics.endFill();

        playerCollectable.x = 60;

        collectableContainer = new Sprite();
        // playerCollectable = new SongObject(playerCollectableSprite,12,0,60,0,0);
        collectableContainer.addChild(playerCollectable);
        collectableContainer.x = instance.screenWidth/2;
        collectableContainer.y = columnY;
        addChild(collectableContainer);

        // player = new SongObject(sprite,15,columnY,instance.screenWidth/2,instance.screenWidth,0);
        // addChild(player);
    }

    public function check(songObject:SongObject)
    {
        var dx:Float = player.x-songObject.x;
        var dy:Float = player.y-songObject.y;
        var distance = Math.sqrt(dx * dx + dy * dy);
        return distance < playerSize + songObject.size;
    }

    public function start()
    {
        soundChannel = song.play (0,-1);
        // soundChannel2 = song2.play (0,-1);
        Time.callbackFunction = update;
    }

    public function spawnObject(size:Float,sprite:Tilesheet,beatNumber:Float,x:Float)
    {
        var newObject = new SongObject(sprite,size,-beatNumber*(1/bpm*60*1000)*objectBaseSpeed/4 + 100,x,instance.screenWidth,loopBeats*(1/bpm*60*1000)*objectBaseSpeed/4,objectBaseSpeed);
        songObjects.push(newObject);
        addChild(newObject);
        return newObject;
    }

    public function createSprite(color:Int,radius:Float,yRespawnDistance:Float)
    {
        var sprite = new Sprite();
        sprite.graphics.beginFill(color);
        sprite.graphics.drawCircle(radius,radius,radius);
        sprite.graphics.endFill();
        var bitmapData = new BitmapData(Std.int(radius*2), Std.int(radius*2), true, 0);
        bitmapData.draw(sprite);
        var sprites:Tilesheet = new Tilesheet(bitmapData);
        sprites.addTileRect(new Rectangle(0, 0, Std.int(radius*2), Std.int(radius*2)));
        return sprites;
    }

    public function update(deltaTime:Float)
    {   
        SongObject.viewport.graphics.clear();
        currentSongTime += deltaTime;

        if(soundChannel.position != lastReportedPlayheadPosition) {
            if(soundChannel.position < lastReportedPlayheadPosition)
            {
                currentSongTime = soundChannel.position;
                lastReportedPlayheadPosition = soundChannel.position;
            }
            else
            {
                currentSongTime = (currentSongTime + soundChannel.position)/2;
                lastReportedPlayheadPosition = soundChannel.position;
            }
        }

        // player.update();
        var playerNotMoving = true;
        if(KeyboardInput.check(Key.LEFT))
        {
            playerVelocity += playerAcceleration;
            playerNotMoving = false;
        }
        if(KeyboardInput.check(Key.RIGHT))
        {
            playerNotMoving = false;
            playerVelocity -= playerAcceleration;
        }
        if(MouseInput.mouseDown)
        {
            if(MouseInput.mouseX > instance.screenWidth/2)
            {
                playerNotMoving = false;
                playerVelocity += playerAcceleration;
            }
            else
            {
                playerNotMoving = false;
                playerVelocity -= playerAcceleration;
            }
        }
        if(playerVelocity > playerMaxSpeed)
        {
            playerVelocity = playerMaxSpeed;
        }
        if(playerVelocity < -playerMaxSpeed)
        {
            playerVelocity = -playerMaxSpeed;
        }
        songObjectXOffset += playerVelocity;
        if(playerNotMoving)
        {
            playerVelocity = playerVelocity*friction;
        }

        for(songObject in songObjects)
        {
            songObject.update(currentSongTime,songObjectXOffset);
        }
    }
}