package com.robertcanton
{
	
	import com.robertcanton.static.ColourScheme;
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	
	/**
	 * ...
	 * @author Robert Canton
	 */
	public class SpawnGlow extends Sprite
	{
		private var size:Number;
		
		public function SpawnGlow(_size:Number)
		{
			size = _size;
			draw();
		}
		
		private function draw():void
		{
			var mat:Matrix;
			var colors:Array;
			var alphas:Array;
			var ratios:Array;
			
			mat = new Matrix();
			colors = [ColourScheme.SPAWN_SMALL_COLOUR, ColourScheme.SPAWN_SMALL_COLOUR];
			alphas = [0.75, 0];
			ratios = [0, 255];


			mat.createGradientBox(2*size,2*size,0,-size,-size);
			this.graphics.lineStyle(1, ColourScheme.SPAWN_SMALL_COLOUR,1);
			this.graphics.beginGradientFill(GradientType.RADIAL, colors, alphas, ratios, mat);
			this.graphics.drawCircle(0, 0, size);
			this.graphics.endFill();
		}
	
	}

}
