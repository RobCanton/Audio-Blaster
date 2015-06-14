package com.robertcanton
{
	
	import com.robertcanton.static.ColourScheme;
	import com.robertcanton.static.GV;
	import flash.display.Sprite;
	import com.robertcanton.utils.Position;
	
	/**
	 * ...
	 * @author Robert Canton
	 */
	public class Asteroid extends Sprite
	{
		private var radius:Number = 30;
		private var CSX:Number;
		private var CSY:Number;
		private var _width:Number = 20;
		private var _height:Number = 20;
		private var x_random:Number = 2;
		private var y_random:Number = 2;
		private var pointsVector:Vector.<Position>;
		public var speedModifer:Number;
		public var xSpeedModifer:Number;
		public var dir:String;
		public var check:Boolean = false;
		private var size:Number;
		public var rot:Number;

		
		public function Asteroid(_size:Number,_speed:Number,_dir:String)
		{
			size = _size;
			speedModifer = _speed / (size / 100);;
			xSpeedModifer = (Math.random() * 4 - 2) * GV.xFactor;
			dir = _dir;
			CSX = _width / 2;
			CSY = _height / 2;
			rot = (_width * 0.10) * (Math.random() * 2 - 1);
			draw();
		}
		
		private function draw():void
		{
			
			radius = (Math.random() * size) + 20;
			var previousX:Number = Math.sin(0) * (radius / (Math.random() * (x_random - 0.9) + 0.9));
			var previousY:Number = Math.cos(0) * (radius / (Math.random() * (y_random - 0.9) + 0.9));

			var distanceX:Number;
			var distanceY:Number;
			var startX:Number = previousX;
			var startY:Number = previousY;
			
			var inverted_point:int = 0;
			var vertices:int = (Math.random() * 3) + 5;
						
			pointsVector = new Vector.<Position>();
			pointsVector.push(new Position(previousX + CSX, previousY + CSY));
			//this.graphics.lineStyle(2 * GV.xFactor, 0x848B91);
			this.graphics.beginFill(ColourScheme.SPAWN_ASTEROID_COLOUR, 1);
			this.graphics.moveTo(previousX + CSX, previousY + CSY);
			if ((Math.random() * 100) > 50)
			{
				inverted_point = (Math.random() * vertices - 1) + 1;
			}
			
			for (var i:int = 1; i < vertices; i++)
			{
				if (i != inverted_point)
				{
					distanceX = Math.sin(i) * (radius / ((Math.random() * (x_random - 0.9)) + 0.9));
					distanceY = Math.cos(i) * (radius / ((Math.random() * (y_random - 0.9)) + 0.9));
				}
				else
				{
					distanceX = Math.sin(i) * (radius / ((Math.random() * 10) + 5));
					distanceY = Math.cos(i) * (radius / ((Math.random() * 10) + 5));
				}
				//trace(i + ": " + previousX + CSX + ", " + previousY + CSY + " | " + startX + CSX + ", " + startY + CSY);
				
				this.graphics.lineTo(distanceX + CSX, distanceY + CSY);
				previousX = distanceX;
				previousY = distanceY;

			}
			
			//this.graphics.moveTo(previousX + CSX, previousY + CSY);
			this.graphics.lineTo(startX + CSX, startY + CSY);
			this.graphics.endFill();
		
			
			
		}
	
	}

}
