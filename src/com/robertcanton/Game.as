package com.robertcanton
{
	import com.greensock.easing.Strong;
	import com.greensock.TweenLite;
	import com.robertcanton.ParallaxField;
	import com.robertcanton.Ship;
	import com.robertcanton.static.ColourScheme;
	import com.robertcanton.static.GV;
	import flash.display.GradientType;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.ui.Mouse;
	
	/**
	 * ...
	 * @author Robert Canton
	 */
	public class Game extends Sprite 
	{
		private var gameWidth:Number;
		private var gameHeight:Number;
		private var xPos:Number = 0;
		private var yPos:Number = 0;
		private var power:Number = 2;
		private var friction:Number = 0.75;
		private var xSpeed:Number = 0;
		private var xDistance:Number;
		private var isDown:Boolean = false;
		private var bg:Sprite;
		
		public var playerShip:Ship;
		private var move_left:Boolean = false;
		private var move_right:Boolean = false;
		private var move_up:Boolean = false;
		private var move_down:Boolean = false;
		private var yShift:Number;
		
		private var starContainer:MovieClip;
		public var parallaxField:ParallaxField;
		public var spawnField:SpawnField;
		
		public function Game(_gameWidth:Number, _gameHeight:Number)
		{
			trace("Game.as is running...");
			gameWidth = _gameWidth;
			gameHeight = _gameHeight;
			addBackground();
			
			starContainer = new MovieClip;
			this.addChild(starContainer);
			parallaxField = new ParallaxField();
			
			// createField(container, x, y, width, height, numberOfStars, speedX, speedY);
			parallaxField.createField(starContainer, -10, -10, gameWidth + 20, gameHeight + 20, 30, 0,0.5);
			parallaxField.upPressed = false;
			parallaxField.downPressed = false;
			parallaxField.leftPressed = false;
			parallaxField.rightPressed = false;
			
		}
		
		public function addPlayer():void
		{
			playerShip = new Ship();
			playerShip.x = gameWidth * 0.50;
			playerShip.y = gameHeight + playerShip.height;
			TweenLite.to(playerShip, 1, { y: gameHeight * 0.75 , ease:Strong.easeOut});
			this.addChild(playerShip);
			this.addEventListener(MouseEvent.MOUSE_DOWN, touchDown);
			
			spawnField = new SpawnField(0, 0, gameWidth, gameHeight, 14,playerShip);
			this.addChild(spawnField);
		}
		
		private function touchDown(evt:MouseEvent):void
		{
			xPos = evt.stageX;
			yPos = evt.stageY;
			this.addEventListener(MouseEvent.MOUSE_MOVE, touchTrace);
			this.addEventListener(MouseEvent.MOUSE_UP, touchUp);
			this.removeEventListener(MouseEvent.MOUSE_DOWN, touchDown);
			
		}
		
		private function touchUp(evt:MouseEvent):void
		{
			this.addEventListener(MouseEvent.MOUSE_DOWN, touchDown);
			this.removeEventListener(MouseEvent.MOUSE_UP, touchUp);
			this.removeEventListener(MouseEvent.MOUSE_MOVE, touchTrace);
			move_left = false;
			move_right = false;
			move_up = false;
			move_down = false;
			//parallaxField.leftPressed = false;
			//parallaxField.rightPressed = false;
		}
		
		private function touchTrace(evt:MouseEvent):void
		{
			xDistance = evt.stageX - xPos;
			if (xDistance < 0)
			{
				move_left = true;
				move_right = false;
				//parallaxField.leftPressed = true;
				//parallaxField.rightPressed = false;
			}
			else if (xDistance > 0)
			{
				move_left = false;
				move_right = true;
				//parallaxField.rightPressed = true;
				//parallaxField.leftPressed = false;
			}	
		
		}
		
		public function update():void
		{
			spawnField.updateSpawnLeft();
			
			if (move_left)
			{
				xSpeed += xDistance * 0.10;
			}
			else if (move_right)
			{
				xSpeed += xDistance * 0.10;
			}
			
			if (playerShip.x < - playerShip.width / 2) 
			{
				playerShip.x = gameWidth;
				move_left = false;
				move_right = false;
			}
			if (playerShip.x > gameWidth + playerShip.width / 2) 
			{
				playerShip.x = 0;
				move_left = false;
				move_right = false;
			}
			
			xSpeed *= friction;
			//parallaxField.speedX *= friction;
			playerShip.x += xSpeed;
			playerShip.rotation = xSpeed * 0.6;
			playerShip.scaleX = (playerShip.width - Math.abs(xSpeed)) / (playerShip.width * 4) + 0.75;
			//spawnField.spawnXSpeed = xSpeed * 0.12;
		}

		
		private function addBackground():void
		{
			var mat:Matrix;
			var colors:Array;
			var alphas:Array;
			var ratios:Array;
			
			mat = new Matrix();
			colors = [ColourScheme.SKY_NIGHT_1, ColourScheme.SKY_NIGHT_2];
			alphas = [1, 1];
			ratios = [0, 255];
			mat.createGradientBox(gameWidth, gameHeight, ((90/180)*Math.PI));
			bg = new Sprite();
			bg.graphics.beginGradientFill(GradientType.LINEAR, colors, alphas, ratios, mat);
			bg.graphics.drawRect(0, 0, gameWidth, gameHeight); // (x spacing, y spacing, width, height)
			bg.graphics.endFill(); // not always needed but I like to put it in to end the fill
			this.addChild(bg); // adds the rectangle to the stage

		}
		
		public function removePlayer():void
		{
			TweenLite.to(playerShip, 1.25, { y: gameHeight + playerShip.height , ease:Strong.easeIn});
		}
		
	
	}
	
}
