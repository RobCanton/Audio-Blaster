package com.robertcanton{

	import com.robertcanton.static.ColourScheme;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.media.SoundMixer;
	import flash.utils.ByteArray;
	public class WaveformSpectrum extends Sprite {

		private var _bytes:ByteArray = new ByteArray();
		private var _fft:Boolean;
		private var _g:Graphics;
		private var numb:Number;
		private var waveHeight:Number;

		public function WaveformSpectrum(_waveHeight:Number, fft:Boolean = false) 
		{
			trace("WaveformSpectrum.as is running...");
			_fft=fft;
			_g = this.graphics;
			waveHeight = _waveHeight;
			startWave();
		}

		public function stopWave():void
		{
			this.removeEventListener(Event.ENTER_FRAME, onVisualize);
		}
		
		public function startWave():void
		{
			this.addEventListener(Event.ENTER_FRAME, onVisualize,
			  false, 0, true);
		}
		private function onVisualize(evt:Event):void {
			SoundMixer.computeSpectrum(_bytes, _fft);
			_g.clear();
			plotWaveform(ColourScheme.CONTROL_PANEL_COLOUR, waveHeight * 0.25);
			plotWaveform(ColourScheme.CONTROL_PANEL_COLOUR, waveHeight * 0.75);
		}
	
		private function plotWaveform(col:uint, 
		  chanBaseline:Number):void {
			_g.lineStyle(1, ColourScheme.CONTROL_PANEL_COLOUR);
			_g.beginFill(col,0.1);
			_g.moveTo(0, chanBaseline);
			
			for (var i:Number = 0; i < 256; i++) {
				numb=_bytes.readFloat()*100;
				//if (numb > 45) {
					//trace("High", numb);
				//}
				//if (numb < -25 && numb > -49.9 ) {
					//trace("Low", numb);
				//}
				//if (numb < -50 ) {
					//trace("Super Bass", numb);
				//}
				_g.lineTo(i, chanBaseline - numb * 0.25);
			
			}
			_g.lineTo(i, chanBaseline);

			_g.endFill();
		}
	}
}