package com.robertcanton
{
	import com.robertcanton.WaveformSpectrum;
	import com.robertcanton.static.ColourScheme;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Robert Canton
	 */
	public class Waveform extends Sprite
	{
		private var waveWidth:Number;
		private var waveHeight:Number;
		private var waveSprite:Sprite;
		public var vis:WaveformSpectrum;
		
		public function Waveform(_panelWidth:Number, _panelHeight:Number)
		{
			trace("Waveform.as is running...");
			waveWidth = _panelWidth;
			waveHeight = _panelHeight;
			waveSprite = createWaveform();
			this.addChild(waveSprite);
			
		}
		
		public function createWaveform():Sprite
		{
			var color:uint = ColourScheme.CONTROL_PANEL_COLOUR;
			var waveWidth:Number = waveWidth / 2;
			var waveHeight:Number = waveHeight;
			
			var temp:Sprite = new Sprite;
			var waveBox:Sprite = new Sprite; // initializing the variable named rectangle
			waveBox.graphics.lineStyle(1, color, 1);
			waveBox.graphics.moveTo(0, 0);
			waveBox.graphics.lineTo(0, 0 + waveHeight);
			waveBox.graphics.moveTo(0 + waveWidth, 0);
			waveBox.graphics.lineTo(0 + waveWidth, 0 + waveHeight);
			
			temp.addChild(waveBox);
			
			var waveMask:Sprite = new Sprite; // initializing the variable named rectangle
			waveMask.graphics.lineStyle(1, color, 1);
			waveMask.graphics.beginFill(color)
			waveMask.graphics.drawRect(0, 0, waveWidth, waveHeight);
			waveMask.graphics.endFill();
			temp.addChild(waveMask);
			
			vis = new WaveformSpectrum(waveHeight);
			vis.alpha = 0.9;
			
			vis.scaleX = waveWidth / 256; //Numb bytes
			vis.x = 0;
			vis.y = 0;
			vis.mask = waveMask;
			temp.addChild(vis);
			
			return temp;
		}
	}

}