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
	public class MenuButton extends Sprite
	{

		private var buttonWidth:Number;
		private var buttonHeight:Number;
		private var centerX:Number;
		private	var centerY:Number;
			
		private var bgGraphic:Sprite;
		private var menuGraphic:Sprite;
		
		
		public function MenuButton(_width:Number, _height:Number)
		{
			trace("PlayButton.as is running...");
			buttonWidth = _width;
			buttonHeight = _height;
			centerX = buttonWidth / 2;
			centerY = buttonHeight / 2;
			menuGraphic = drawMenu();
			bgGraphic = drawBg();

			
			this.addChild(bgGraphic);
			this.addChild(menuGraphic);
			bgGraphic.alpha = ColourScheme.CONTROL_PANEL_ALPHA;		
			
		}
		public function bgGlow():void
		{
			bgGraphic.alpha = 0.5;
			TweenLite.to(bgGraphic, 0.5, { alpha:ColourScheme.CONTROL_PANEL_ALPHA, ease:Strong.easeOut } );
		}
		public function drawMenu():Sprite
		{
			var color:uint = ColourScheme.CONTROL_PANEL_COLOUR;
			
			var temp:Sprite = new Sprite;
			temp.graphics.lineStyle(1, color);
			//temp.graphics.beginFill(color, 0.3);
			var h:Number = buttonHeight / 8;
			var w:Number = buttonWidth - h * 6;
			temp.graphics.drawRect(h*3, h * 1.5, w, h);
			temp.graphics.drawRect(h*3, h * 3.5, w, h);
			temp.graphics.drawRect(h*3, h * 5.5, w, h);
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