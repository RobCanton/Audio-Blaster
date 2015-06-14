package com.robertcanton
{
	import com.greensock.easing.Strong;
	import com.greensock.TweenLite;
	import com.robertcanton.static.ColourScheme;
	import flash.display.Graphics;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.text.ReturnKeyLabel;
	
	/**
	 * ...
	 * @author Robert Canton
	 */
	public class PlayButton extends Sprite
	{

		private var buttonWidth:Number;
		private var buttonHeight:Number;
		private var centerX:Number;
		private	var centerY:Number;
			
		private var bgGraphic:Sprite;
		private var playGraphic:Sprite;
		private var pauseGraphic:Sprite;
		
		
		public function PlayButton(_width:Number, _height:Number)
		{
			trace("PlayButton.as is running...");
			buttonWidth = _width;
			buttonHeight = _height;
			centerX = buttonWidth / 2;
			centerY = buttonHeight / 2;
			playGraphic = drawPlay();
			bgGraphic = drawBg();
			pauseGraphic = drawPause();
			
			this.addChild(bgGraphic);
			this.addChild(playGraphic);
			this.addChild(pauseGraphic);
			bgGraphic.alpha = ColourScheme.CONTROL_PANEL_ALPHA;
			pauseGraphic.alpha = 1;
			playGraphic.alpha = 0;
			
			
		}
		public function showPause():void
		{
			pauseGraphic.alpha = 1;
			playGraphic.alpha = 0;
		}
		public function showPlay():void
		{
			pauseGraphic.alpha = 0;
			playGraphic.alpha = 1;
		}
		public function bgGlow():void
		{
			bgGraphic.alpha = 0.5;
			TweenLite.to(bgGraphic, 0.5, { alpha:ColourScheme.CONTROL_PANEL_ALPHA, ease:Strong.easeOut } );
		}
		public function drawPlay():Sprite
		{
			var color:uint = ColourScheme.CONTROL_PANEL_COLOUR;
			var dist:Number = buttonWidth / 8;
			
			var temp:Sprite = new Sprite;
			temp.graphics.lineStyle(1, color);
			//temp.graphics.beginFill(color, 0.3);
			temp.graphics.moveTo(centerX - dist, centerY - dist);
			temp.graphics.lineTo(centerX - dist, centerY + dist);
			temp.graphics.lineTo(centerX + dist, centerY)
			temp.graphics.lineTo(centerX - dist, centerY - dist)
			temp.graphics.endFill();
			return temp;
		}
		
		public function drawPause():Sprite
		{
			var color:uint = ColourScheme.CONTROL_PANEL_COLOUR;
			var dist:Number = buttonWidth / 8;
			
			var temp:Sprite = new Sprite;
			temp.graphics.lineStyle(1, color);
			
			//temp.graphics.beginFill(color, 0.3);
			temp.graphics.drawRect(centerX - dist * 1.20, centerY - dist , dist, dist * 2)
			temp.graphics.drawRect(centerX + dist * 0.20 ,centerY - dist ,dist, dist * 2)
			temp.graphics.endFill();
			return temp;
		}
		
		private function drawBg():Sprite
		{
			var color:uint = ColourScheme.CONTROL_PANEL_COLOUR;
			var temp:Sprite = new Sprite;
			temp.graphics.beginFill(color, 1);
			//temp.graphics.lineStyle(1 , color, 0.5);
			temp.graphics.drawRect(0, 0, buttonWidth, buttonHeight);
			temp.graphics.endFill(); // not always needed but I like to put it in to end the 
			return temp;
		}
	
	}
	
}