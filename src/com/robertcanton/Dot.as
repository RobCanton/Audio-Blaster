package com.robertcanton
{

	import com.robertcanton.static.ColourScheme;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Robert Canton
	 */
	public class Dot extends Sprite 
	{
		public var speedModifer:Number;
		public var dir:String;
		public var check:Boolean = false;
		private var size:Number;
		
		public function Dot(_size:Number, _speed:Number,_dir:String)
		{
			size = _size;
			speedModifer = _speed;
			dir = _dir;
			drawDot();
		}
		
		private function drawDot():void
		{
			//this.graphics.lineStyle(1, 0xFFFFFF, 1);
			this.graphics.beginFill(ColourScheme.SPAWN_SMALL_COLOUR, 1);
			this.graphics.drawCircle(0, 0, size);
			this.graphics.endFill();
			
			/*
			this.graphics.lineStyle(1, ColourScheme.SPAWN_SMALL_COLOUR, 1);
			this.graphics.drawCircle(0, 0, size * 1.25);
			*/
		}
		

		
	}
	
}
