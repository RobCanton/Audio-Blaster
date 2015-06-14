package com.robertcanton
{
	import com.robertcanton.static.ColourScheme;
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	
	/**
	 * ...
	 * @author Robert Canton
	 */
	public class PanelBorder extends Sprite
	{
		private var x1:Number;
		private var y1:Number;
		private var borderWidth:Number;
		private var borderHeight:Number;
		private var _g:Graphics;
		
		public function PanelBorder(_x1:Number, _y1:Number, _width:Number, _height:Number)
		{
			trace("PanelBorder.as is running...");
			_g = this.graphics;
			x1 = _x1;
			y1 = _y1;
			borderWidth = _width;
			borderHeight = _height;
			drawBox();
		}
		
		public function drawBox():void
		{
			var color:uint = ColourScheme.CONTROL_PANEL_COLOUR;
			var gradientBoxMatrix:Matrix = new Matrix();
			gradientBoxMatrix.createGradientBox(borderWidth, borderHeight, Math.PI / 2, 0, 0);

			_g.beginGradientFill(GradientType.LINEAR, [0x9CC9C6, 0x9CC9C6], [0.05, 0.9], [0, 255], gradientBoxMatrix);
			_g.lineStyle(1, 0xFFFFFF, 1);
			//_g.beginFill(color, 0.12);
			_g.drawRect(x1, y1, borderWidth, borderHeight); // (x spacing, y spacing, width, height)
			_g.endFill(); // not always needed but I like to put it in to end the fill
			
			_g.lineStyle(1, color, 0.25);
			_g.moveTo(0, borderHeight / 3);
			_g.lineTo(borderWidth, borderHeight / 3);
			
			_g.lineStyle(1, color, 1);
			_g.moveTo(x1, y1);
			_g.lineTo(borderWidth, y1);
			
			/*
			//HIDDEN BOX
			_g.beginFill(0xFFFFFF, 0);
			_g.lineStyle(1, 0xFFFFFF, 0);
			_g.drawRect(x1, y1 - borderHeight, borderWidth, borderHeight); // (x spacing, y spacing, width, height)
			_g.endFill(); // not always needed but I like to put it in to end the fill
			*/
		}
	}

}