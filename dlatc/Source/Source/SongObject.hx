
package;
import openfl.display.Sprite;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.Assets;
import haxel.Core;
import openfl.display.Tilesheet;
// import utils.Hitbox;

class SongObject extends Sprite
{

    public static var OBSTACLE:Int = 0;
    public static var COLLECTABLE:Int = 1;
    public static var MULTIPLIER:Int = 2;
    public static var END:Int = -1;

    public var column(get, never):Int;
    public function get_column():Int
    {
        return currentColumn;
    }
    public var speed:Float = 30.5;
    // public var hitbox:Hitbox;
    // public var attacks:Array<Attack>;
    
    public var currentColumn:Int;
    public var inColumn:Bool;
    public var sprite:Tilesheet;

    public var startX:Float;
    public var startY:Float;

    public var hitbox:Hitbox;
    public var yVelocity:Float;

    public var size:Float;

    public var type:Float;
    public var yRespawnDistance:Float;
    public var screenWidth:Int;

    public static var viewport:Sprite;

    public function new(newSprite:Tilesheet,radius,yStart:Float,xStart:Float,screenWidth:Int,yRespawnDistance:Float,ySpeed:Float = 0,objectType:Int = 0)
    {
        super();
        type = objectType;
        size = radius;
        this.screenWidth = screenWidth;

        this.yRespawnDistance = yRespawnDistance;
        sprite = newSprite; 

        startX = x = xStart;
        startY = y =yStart;
        yVelocity = ySpeed;
        inColumn = true;
    }

    public function check(songObject:SongObject)
    {
        var dx:Float = x-songObject.x;
        var dy:Float = y-songObject.y;
        var distance = Math.sqrt(dx * dx + dy * dy);
        return distance < size + songObject.size;
    }

    public function update(time:Float = 0,xOffset:Float = 0)
    {
        if(yVelocity > 0)
        {
            y = startY + time * yVelocity;
        }

        x = startX + xOffset;
        while(x > screenWidth)
        {
            x -= screenWidth;
        }
        while(x < 0)
        {
            x += screenWidth;
        }

        var tileData = new Array<Float>();
        tileData = [];

        for(drawX in [-screenWidth,0,screenWidth])
        {
            for(drawY in [-yRespawnDistance,0,yRespawnDistance])
            {
                tileData.push(x + drawX - size);
                tileData.push(y + drawY - size);
                tileData.push(0);
            }
        }
        if(visible)
        {
            sprite.drawTiles(viewport.graphics, tileData);
        }
    }
}
