
package haxel;

//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!//
//                                                                          //
//   Because of the nature of this project, please PLEASE test any change   //
//   on HTML5, Flash, AND native. Any changes made for compatibility or     //
//   optimization ABSOLUTELY NEED to be fully documented: reasons, effects  //
//   and changes made. -Aaron                                               //
//                                                                          //
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!//

class Touch
{

    public var id(default, null):Int;
    public var x:Float;
    public var y:Float;
    public var pressed(default, null):Bool;

    public function new(x:Float, y:Float, id:Int)
    {
        this.x = x;
        this.y = y;
        this.id = id;
        this.pressed = true;
    }

    public function update()
    {
        pressed = false;
    }
}
