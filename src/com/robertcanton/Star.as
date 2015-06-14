package com.robertcanton
{

	import flash.display.Sprite;
	/**
	 * ...
	 * @author Robert Canton
	 */
	public class Star extends Sprite 
	{
		public var speedModifer:Number;
		
		public function Star(starSize:Number, _speed:Number)
		{
			speedModifer = _speed;
			this.graphics.lineStyle(1, 0xFFFFFF, 0.1);
			this.graphics.beginFill(0xFFFFFF, 1);
			this.graphics.drawRect(0, 0, starSize, starSize);
			this.graphics.endFill();
			this.rotation = 45;
		}

		
	}
	
}
