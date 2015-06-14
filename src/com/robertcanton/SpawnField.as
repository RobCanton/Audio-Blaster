package com.robertcanton
{
	import com.greensock.plugins.BezierThroughPlugin;
	import com.greensock.TweenLite;
	import com.robertcanton.static.GV;
	import com.robertcanton.utils.CollisionTest;
	import com.robertcanton.Ship;
	import com.robertcanton.SpawnGlow;
	import flash.display.Sprite;
	import flash.events.Event;
	import com.robertcanton.Asteroid;
	
	/**
	 * ...
	 * @author Robert Canton
	 */
	public class SpawnField extends Sprite
	{
		private var leftSpawnArray:Array = [];
		private var rightSpawnArray:Array = [];
		private var leftSpawnArrayLength:int;
		private var rightSpawnArrayLength:int
		public var leftSpawnCheck:Boolean = true;
		public var rightSpawnCheck:Boolean = true;
		private var spawnGap:int;
		
		private var speedY:Number;
		private var fieldX:int;
		private var fieldY:int;
		private var fieldWidth:int;
		private var fieldHeight:int;
		
		private var leftSpawnGlow:SpawnGlow;
		private var rightSpawnGlow:SpawnGlow;
		public var spawnXSpeed:Number = 0;
		private var shipRef:Ship;
		
		private var _collisionTest:CollisionTest;
		
		public function SpawnField(_fieldX:int, _fieldY:int, _fieldWidth:int, _fieldHeight:int, _speedY:int, _ship:Ship)
		{
			fieldX = _fieldX;
			fieldY = _fieldY;
			fieldWidth = _fieldWidth;
			fieldHeight = _fieldHeight;
			speedY = (fieldHeight / 800) * _speedY;
			shipRef = _ship;
			
			//calculate x seconds of travel
			spawnGap = speedY * 4;
			
			leftSpawnGlow = new SpawnGlow(fieldWidth * 0.015);
			leftSpawnGlow.x = 0;
			leftSpawnGlow.y = 0;
			leftSpawnGlow.alpha = 0;
			this.addChild(leftSpawnGlow);
			
			rightSpawnGlow = new SpawnGlow(fieldWidth * 0.015);
			rightSpawnGlow.x = 0;
			rightSpawnGlow.y = 0;
			rightSpawnGlow.alpha = 0;
			this.addChild(rightSpawnGlow);
			
			_collisionTest = new CollisionTest();
			
		}
		
		public function spawnHigh(dir:String):void
		{
			var tempAsteroid:Asteroid = new Asteroid(100 * GV.xFactor,1,dir);
			tempAsteroid.rotation = Math.random() * 360;
			var xPos:int = Math.random() * (fieldWidth);
			if (dir == "LEFT")
			{
				leftSpawnGlow.x = xPos;
				leftSpawnGlow.alpha = 1;
				leftSpawnGlow.scaleX = leftSpawnGlow.scaleY = 1;
				TweenLite.to(leftSpawnGlow,0.5,{ alpha:0,scaleX:5,scaleY:5 } );
				tempAsteroid.x = xPos;
				tempAsteroid.y = fieldY - tempAsteroid.height;
				leftSpawnArray.push(tempAsteroid);
				leftSpawnArrayLength = leftSpawnArray.length;
				this.addChild(tempAsteroid);
				leftSpawnCheck = false;
			}/*
			else if (dir == "RIGHT") {
				
				rightSpawnGlow.x = xPos  + fieldWidth / 2;;
				rightSpawnGlow.alpha = 1;
				rightSpawnGlow.scaleX = rightSpawnGlow.scaleY = 1;
				TweenLite.to(rightSpawnGlow,0.5,{ alpha:0,scaleX:5,scaleY:5 } );
				//TweenLite.to(newDot, 5, { alpha:0.5} );
				//newDot.x = xPos + fieldWidth / 2;
				//newDot.y = fieldY - newDot.height;
				//rightSpawnArray.push(newDot);
				//rightSpawnArrayLength = rightSpawnArray.length;
				//this.addChild(newDot);
				rightSpawnCheck = false;
			}
			*/
		}
		
		public function updateSpawnLeft():void
		{
			leftSpawnArrayLength = leftSpawnArray.length;
			
			var tempDot:Asteroid;
			var i:int;
			
			if (leftSpawnArrayLength > 0)
			{
				tempDot = leftSpawnArray[leftSpawnArrayLength - 1];
				if (tempDot.check == false && tempDot.y > spawnGap)
				{	
					tempDot.check = true;
					leftSpawnCheck = true;
				}
				
				for (i = 0; i < leftSpawnArrayLength; i++)
				{
					tempDot.rotation += tempDot.rot;
					tempDot = leftSpawnArray[i];
					tempDot.y += speedY * tempDot.speedModifer * GV.xFactor;
					tempDot.x += tempDot.xSpeedModifer;
					tempDot.x -= spawnXSpeed;
				
					//Star boundaries
					//check Y boudries
					if (tempDot.y >= fieldHeight + tempDot.height)
					{
						leftSpawnArray.splice(i, 1);
						leftSpawnArrayLength = leftSpawnArray.length;
						this.removeChild(tempDot);
					}
					else if (_collisionTest.complex(tempDot,shipRef))
					{
						/*
						leftSpawnArray.splice(i, 1);
						leftSpawnArrayLength = leftSpawnArray.length;
						this.removeChild(tempDot);
						*/
						shipRef.mc.gotoAndPlay(2);
					}
					
				}
						
			}
			
		}
	}

}
