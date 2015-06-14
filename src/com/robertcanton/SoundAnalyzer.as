package com.robertcanton
{
	import com.robertcanton.AudioTrack;
	import com.robertcanton.Game;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Robert Canton
	 */
	public class SoundAnalyzer
	{
		
		private var audioTrack:AudioTrack;
		private var soundTrack:Sound;
		public var isPlaying:Boolean = false;
		public var isLoaded:Boolean = false;
		private var soundPosition:Number = 0;
		private var channel:SoundChannel = new SoundChannel();
		private var trans:SoundTransform = new SoundTransform();
		private var channelFactor:Number = 10;
		private var numb:Number;
		private var _bytes:ByteArray = new ByteArray();
		private var _fft:Boolean;
		private var gameRef:Game;
		
		public function SoundAnalyzer(_audioTrack:AudioTrack, _game:Game)
		{
			trace("SoundAnalyzer.as is running...");
			audioTrack = _audioTrack;
			this.gameRef = _game;
		
		}
		
		public function playSound():void
		{
			if (!isPlaying)
			{
				isPlaying = true;
				soundTrack = audioTrack.getSong();
				channel = soundTrack.play(soundPosition);
				channel.addEventListener(Event.SOUND_COMPLETE, onPlayComplete, false, 0, true);
			}
		}
		
		public function pauseSound():void
		{
			if (isPlaying)
			{
				soundPosition = channel.position;
				channel.stop();
				isPlaying = false;
			}
		}
		
		public function onPlayProgress():void
		{
			trans.volume = 0.5;
			channel.soundTransform = trans;
			soundRecog();
		}
		
		public function onPlayComplete():void
		{
			channel.removeEventListener(Event.SOUND_COMPLETE, onPlayComplete);
			channel.stop();
			soundPosition = 0;
			isPlaying = false;
		}
		
		private function soundRecog():void
		{
			SoundMixer.computeSpectrum(_bytes, _fft);
			traceNotesL(50);
		}
		
		private function traceNotesL(chanBaseline:Number):void
		{
			for (var i:Number = 0; i < 256; i++)
			{
				numb = _bytes.readFloat() * 100;
				
				if (numb - channel.leftPeak * channelFactor > 25)
				{
					if (gameRef.spawnField.leftSpawnCheck)
					{
						gameRef.spawnField.spawnHigh("LEFT");
					}
				}
			}
		}
		
		public function getAudioTrack():AudioTrack
		{
			return audioTrack;
		}
		
		public function getProgress():Number
		{
			return (channel.position / audioTrack.getSong().length);
		}
		
		public function changeTrack(_audioTrack:AudioTrack):void
		{
			soundPosition = 0;
			audioTrack = _audioTrack;
			
		}
	
	}

}