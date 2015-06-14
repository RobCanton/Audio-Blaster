package com.robertcanton
{
	import com.greensock.easing.Strong;
	import com.greensock.TweenLite;
	import com.robertcanton.PlayButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.robertcanton.InfoBar;
	import flash.events.TransformGestureEvent;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	/**
	 * ...
	 * @author Robert Canton
	 */
	public class ControlPanel extends Sprite
	{
		private var panelWidth:Number;
		private var panelHeight:Number;
		
		private var analyzer:SoundAnalyzer;
		private var infoBar:InfoBar;
		private var playBtn:PlayButton;
		private var menuBtn:MenuButton;
		private var waveform:Waveform;
		
		private var setup:Setup;
			
		public function ControlPanel(_panelWidth:Number, _panelHeight:Number, _setup:Setup)
		{
			trace("ControlPanel.as is running...");
			panelWidth = _panelWidth;
			panelHeight = _panelHeight;
			createControlPanel();
			setup = _setup;
		}
		
		private function createControlPanel():void
		{
			this.graphics.lineStyle(1, 0xFFFFFF);
			this.graphics.drawRect(0, 0, panelWidth, panelHeight);
			
			infoBar = new InfoBar(panelWidth, panelHeight * 0.25);
			this.addChild(infoBar);
			
			playBtn = new PlayButton(panelWidth / 4, panelHeight * 0.75);
			playBtn.y = panelHeight * 0.25;
			this.addChild(playBtn);
			
			waveform = new Waveform (panelWidth, panelHeight * 0.75);
			waveform.x = playBtn.width;
			waveform.y = panelHeight * 0.25;
			this.addChild(waveform);
			
			menuBtn = new MenuButton(panelWidth / 4, panelHeight * 0.75);
			menuBtn.x = panelWidth * 0.75;
			menuBtn.y = panelHeight * 0.25;
			this.addChild(menuBtn);
			
			initialHandlers();
			
			Multitouch.inputMode = MultitouchInputMode.GESTURE;
			infoBar.addEventListener(TransformGestureEvent.GESTURE_SWIPE, onSwipe);
			
			//infoBar.addEventListener(MouseEvent.CLICK, next);

		}
		
		public function initialHandlers():void
		{
			playBtn.addEventListener(MouseEvent.CLICK, pauseHandler);
			menuBtn.addEventListener(MouseEvent.CLICK, menuHandler);
		}
		
		public function setAnalyzer(_analyzer:SoundAnalyzer):void
		{
			analyzer = _analyzer;
			infoBar.setArtistName(analyzer.getAudioTrack().getSongArtist());
			infoBar.setSongName(analyzer.getAudioTrack().getSongTitle());
		}
		
		private function playHandler(evt:MouseEvent):void
		{
			playBtn.removeEventListener(MouseEvent.CLICK, playHandler);
			playBtn.addEventListener(MouseEvent.CLICK, pauseHandler);
			playBtn.bgGlow();
			play();
		}
		
		private function pauseHandler(evt:MouseEvent):void
		{
			playBtn.removeEventListener(MouseEvent.CLICK, pauseHandler);
			playBtn.addEventListener(MouseEvent.CLICK, playHandler);
			playBtn.bgGlow();
			pause();
		}
		
		public function play ():void
		{
			analyzer.playSound();
			playBtn.showPause();
		}
		public function pause ():void
		{
			analyzer.pauseSound();
			playBtn.showPlay();
		}
		
		private function menuHandler(evt:MouseEvent):void
		{
			menuBtn.removeEventListener(MouseEvent.CLICK, menuHandler);
			playBtn.removeEventListener(MouseEvent.CLICK, pauseHandler);
			playBtn.removeEventListener(MouseEvent.CLICK, playHandler);
			menuBtn.bgGlow();
			pause();
			setup.hidePanel();
		}
		
		public function lower():void
		{
			waveform.vis.stopWave();
		}
		
		public function raise():void
		{
			waveform.vis.startWave();
		}
		public function fetchProgress():void
		{
			var scale:Number = analyzer.getProgress();
			infoBar.updateProgressBar(scale);
			
			if (scale >= 0.99) {
				trace("done");
				//TweenLite.to(infoBar.infoText, 0.5, {alpha:0, x: -panelWidth / 2, ease:Strong.easeOut });
				//TweenLite.delayedCall(0.5, callInfoBar_next);
			}
			
		}
		
		private function onSwipe(e:TransformGestureEvent):void
		{
			if (e.offsetX == -1)
			{
				//User swiped Left
				TweenLite.to(infoBar.infoText, 0.5, {alpha:0, x: -panelWidth / 2, ease:Strong.easeOut });
				TweenLite.delayedCall(0.5, callInfoBar_next);
			}
			if (e.offsetX == 1)
			{
				//User swiped Right
				TweenLite.to(infoBar.infoText, 0.5, {alpha:0, x: panelWidth / 2, ease:Strong.easeOut });
				TweenLite.delayedCall(0.5, callInfoBar_prev);
			}
		}
		/*
		private function next(e:MouseEvent):void
		{
			TweenLite.to(infoBar.infoText, 0.5, {alpha:0, x: panelWidth / 2, ease:Strong.easeOut });
				setup.prevSong();
				TweenLite.delayedCall(0.5, callInfoBar_prev);
		}
		*/
		private function callInfoBar_next():void
		{
			setup.nextSong();
			infoBar.infoText.x = panelWidth / 2;
			TweenLite.to(infoBar.infoText, 0.5, { alpha: 1, x: 0, ease:Strong.easeOut });
		}
		private function callInfoBar_prev():void
		{
			setup.prevSong();
			infoBar.infoText.x = - panelWidth / 2;
			TweenLite.to(infoBar.infoText, 0.5, { alpha: 1, x: 0, ease:Strong.easeOut });
		}

		
				
	}
	
}