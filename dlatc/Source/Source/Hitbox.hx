
package ;

class Hitbox
{

    public var offsetX:Float;
    public var offsetY:Float;
    public var width:Float;
    public var height:Float;

    public function new(offX:Float,offY:Float,w:Float,h:Float)
    {
        offsetX = offX;
        offsetY = offY;
        width = w;
        height = h;
    }

    public function check(xPos:Float, yPos:Float, other:Hitbox, otherX:Float, otherY:Float):Bool
    {
        if(xPos + offsetX >= otherX + other.offsetX + other.width)
        {
            return false;
        }
        if(xPos + offsetX  + width <= otherX + other.offsetX)
        {
            return false;
        }
        if(yPos + offsetY >= otherY + other.offsetY + other.height)
        {
            return false;
        }
        if(yPos + offsetY + height <= otherY + other.offsetY)
        {
            return false;
        }
        return true;
    }
}