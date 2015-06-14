package com.robertcanton
{

	import flash.display.Sprite;
	import com.robertcanton.Star;
	import flash.events.Event;
	/**
	 * ...
	 * @author Robert Canton
	 */
	public class StarField extends Sprite 
	{
		private var star_large:Number;
		private var star_medium:Number;
		private var star_small:Number;
		
		private var fieldX:int;
		private var fieldY:int;
		private var fieldWidth:int;
		private var fieldHeight:int;
		
		private var numStars:int;
		private var starsArray:Array = [];
		private var starsArrayLength:int;
		private var speedX:Number;
		private var speedY:Number;
		private var acceleration:Number = 0.25;
		
		public var isStarted:Boolean = false;
		
		public function StarField(_fieldX:int, _fieldY:int,_fieldWidth:int, _fieldHeight:int, _numStars:int,_speedX:int,_speedY:int)
		{
			trace("StarField.as is running...");
			fieldX = _fieldX;
			fieldY = _fieldY;
			fieldWidth = _fieldWidth;
			fieldHeight = _fieldHeight;
			speedX = _speedX;
			speedY = (fieldHeight / 800) * _speedY;
			star_large = _fieldWidth * 0.01;
			star_medium = star_large * 0.5;
			star_small = star_medium * 0.5;
			numStars = _numStars;
			createStarField();
			enable();
			
			
		}
		
		private function createStarField():void
		{
			var num_small:int = Math.round(numStars * 1);
			var num_medium:int = Math.round(numStars * 0.60);
			var num_large:int = Math.round (numStars * 0.30);
			
			addStars(num_small, star_small, 0.30);
			addStars(num_medium, star_medium, 0.60);
			addStars(num_large, star_large, 1);
		}
		private function addStars(num:int,star_size:Number,modifier:Number):void
		{
			for (var i:int = 0; i < num; i++) {
				var tempStar:Star =  new Star(star_size, 0.30);
				tempStar.speedModifer = modifier;
				tempStar.x = (Math.random() * (fieldWidth - tempStar.width)) + fieldX;
				tempStar.y = (Math.random() * (fieldHeight - tempStar.height)) + fieldY;
				starsArray.push(tempStar);
				this.addChild(tempStar);
			}
		}
		
		public function enable():void
		{
			if (!isStarted)
			{
				//trace("Starting parallax effect...");
				isStarted = true;
			}
			else
			{
				//trace("Parallax effect already running.");
			}
			
		}
		
		public function disable():void
		{
			if (isStarted)
			{
				//trace("Stopping parallax effect...");
				isStarted = false;
			}
			else
			{
				//trace("Parallax effect is not running.");
			}
			
		}
		
		public function updateStars():void
		{
			starsArrayLength = starsArray.length;
			var tempStar:Star;
			var i:int;
			
			for (i = 0; i < starsArrayLength; i++)
			{
				tempStar = starsArray[i];
				tempStar.y += speedY * tempStar.speedModifer;
				
				//Star boundaries
				//check Y boudries
				if (tempStar.y >= fieldHeight + tempStar.height + fieldY)
				{
					//outside boundry, move to other side of container
					tempStar.x = (Math.random() * (fieldWidth - tempStar.width)) + fieldX;
					tempStar.y = fieldY - tempStar.height;
				}
			}
		}
	}
	
}
