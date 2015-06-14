package com.robertcanton
{
	import com.greensock.easing.Strong;
	import com.greensock.TweenLite;
	import com.robertcanton.Game;
	import com.robertcanton.static.GV;
	import com.robertcanton.ControlPanel;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.events.TransformGestureEvent;
	import flash.filesystem.File;
	import flash.media.Sound;
	import flash.media.SoundLoaderContext;
	import flash.net.FileFilter;
	import flash.net.URLRequest;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.ui.Mouse;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	/**
	 * ...
	 * @author Robert Canton
	 */
	public class Setup extends Sprite
	{
		private var file:File = new File();
		private var _stage:Stage;
		private var _stageWidth:Number;
		private var _stageHeight:Number;
		private var gameContainer:Game;
		private var menu:Sprite;
		private var menu_btn_addSong: btn_addSong;
		private var menu_btn_play: btn_play;
		private var menu_songList:SongList;
		private var newTrack:AudioTrack;
		private var song_dispatcher:EventDispatcher = new EventDispatcher();
		private var analyzer:SoundAnalyzer;
		private var controlPanel:ControlPanel;
		
		public function Setup(stage:Stage)
		{
			trace("Setup.as is running...");
			_stage = stage;
			_stageWidth = stage.stageWidth;
			_stageHeight = stage.stageHeight;
			GV.xFactor = _stageWidth / GV.android_baseWidth;
			GV.yFactor = _stageHeight / GV.android_baseHeight;
			trace(GV.xFactor + " | " + GV.yFactor);
			gameContainer = new Game(_stageWidth, _stageHeight);
			_stage.addChild(gameContainer);
			showMenu();
		
		}
		
		private function showMenu():void
		{
			menu = new Sprite;
			
			var format:TextFormat = new TextFormat();
			format.font = GV.boldFont.fontName;
			format.size = 28 * GV.yFactor;
			format.align = TextFormatAlign.CENTER;
			format.color = 0xFFFFFF;
			
			var text:TextField = new TextField();
			text.defaultTextFormat = format;
			text.embedFonts = true;
			text.antiAliasType = AntiAliasType.ADVANCED;
			text.text = "Create a Playlist";
			
			menu.addChild(text);
			
			text.selectable = false;
			text.wordWrap = false;
			text.width = _stageWidth;
			text.height = 50 * GV.yFactor;
			text.y = 60 * GV.yFactor
			
			menu_songList = new SongList();
			menu_songList.x = 40 * GV.xFactor;
			menu_songList.y = text.y + 50 * GV.yFactor;
			menu.addChild(menu_songList);
			
			_stage.addChild(menu);
			menu_btn_addSong = new btn_addSong;
			menu_btn_addSong.scaleX  = menu_btn_addSong.scaleY *= GV.xFactor;
			menu_btn_addSong.x = menu_songList.x;
			menu_btn_addSong.y = menu_songList.y + menu_songList.height + 10 * GV.yFactor;
			menu.addChild(menu_btn_addSong);
			
			menu_btn_play = new btn_play;
			menu_btn_play.scaleX  = menu_btn_play.scaleY *= GV.xFactor;
			menu_btn_play.x = menu_songList.x + menu_songList.width - menu_btn_play.width;
			menu_btn_play.y = menu_btn_addSong.y;
			menu.addChild(menu_btn_play);
			
			menu_btn_addSong.addEventListener(MouseEvent.MOUSE_DOWN, selectSong);
			menu_btn_play.addEventListener(MouseEvent.MOUSE_DOWN, gameStart);
			
			controlPanel = new ControlPanel(460 * GV.xFactor, 100 * GV.xFactor, this);
			controlPanel.x = 10 * GV.xFactor;
			controlPanel.y = _stageHeight + controlPanel.height + controlPanel.height;
			_stage.addChild(controlPanel);
			
		}
		
		private function selectSong(e:MouseEvent):void
		{
			song_dispatcher.addEventListener("songLoaded", addSong);
			newTrack = new AudioTrack(song_dispatcher);	
		}
		
		private function addSong(e:Event):void
		{
			//menu_songList.current ++;
			trace("song added");
			if (menu_songList.numItems < 10)
			{
				menu_songList.addItem(newTrack);
			}
			else {
				trace("Error");
			}
		}
		
		public function gameStart(e:MouseEvent):void
		{
			menu_btn_addSong.removeEventListener(MouseEvent.MOUSE_DOWN, selectSong);
			menu_btn_play.removeEventListener(MouseEvent.MOUSE_DOWN, gameStart);
			analyzer = new SoundAnalyzer(menu_songList.songArray[menu_songList.current], gameContainer);
			controlPanel.setAnalyzer(analyzer);
			TweenLite.to(menu, 0.95, { alpha:0, y: - menu.height, ease:Strong.easeIn } );
			TweenLite.delayedCall(1.25, hideMenu);
			gameContainer.parallaxField.upPressed = true;
			trace("Star Speed: " + gameContainer.parallaxField.speedY);
		}
		
		public function updateAnalyzer():void
		{

			analyzer.changeTrack(menu_songList.songArray[menu_songList.current]);
			controlPanel.setAnalyzer(analyzer);
			controlPanel.play();
			controlPanel.initialHandlers();
		}
		
		private function hideMenu():void
		{
			//menu.visible = false;
			this.addEventListener(Event.ENTER_FRAME, gameRun);
			TweenLite.to(controlPanel, 1.5, { y: _stageHeight - controlPanel.height - controlPanel.x, ease:Strong.easeOut } );
			gameContainer.addPlayer();
			controlPanel.play();
			controlPanel.initialHandlers();
			gameContainer.parallaxField.upPressed = false;

			trace("Star Speed: " + gameContainer.parallaxField.speedY);
			
			Multitouch.inputMode = MultitouchInputMode.GESTURE;
			controlPanel.addEventListener(TransformGestureEvent.GESTURE_SWIPE, onSwipe);
		}
		
		public function gameRun(e:Event):void
		{
			if (analyzer.isPlaying)
			{
				controlPanel.fetchProgress();
				analyzer.onPlayProgress();
			}
			gameContainer.update();
		}
		
		public function gamePause():void
		{
			this.removeEventListener(Event.ENTER_FRAME, gameRun);
		}
		
		public function gameResume():void
		{
		
		}
		
		private function onSwipe(e:TransformGestureEvent):void
		{
			if (e.offsetY == 1)
			{
				//User swiped down
				TweenLite.to(controlPanel, 0.5, { alpha:0.5, scaleX: _stageWidth / controlPanel.width, x: 0, y:_stageHeight - controlPanel.height * 0.25, ease:Strong.easeOut } );
				controlPanel.addEventListener(MouseEvent.MOUSE_DOWN, onTap);
				controlPanel.removeEventListener(TransformGestureEvent.GESTURE_SWIPE, onSwipe);
				controlPanel.lower();
			}
		}
		
		private function onTap(e:MouseEvent):void
		{
			controlPanel.removeEventListener(MouseEvent.MOUSE_DOWN, onTap);
			controlPanel.addEventListener(TransformGestureEvent.GESTURE_SWIPE, onSwipe);
			TweenLite.to(controlPanel, 0.5, { alpha:1, scaleX: 1, x: 10 * GV.xFactor, y: _stageHeight - controlPanel.height - 10 * GV.xFactor, ease:Strong.easeOut } );
			controlPanel.raise();
		}
		
		public function hidePanel():void
		{
			trace("hello");
			TweenLite.to(controlPanel, 1, { y: _stageHeight + controlPanel.height + controlPanel.height, ease:Strong.easeIn } );
			gameContainer.removePlayer();
			TweenLite.delayedCall(1.25, returnMenu);
			gameContainer.parallaxField.downPressed = true;
		}
		
		private function returnMenu():void
		{
			menu.visible = true;
			TweenLite.to(menu, 1.5, { alpha:1, y: 0, ease:Strong.easeOut } );
			menu_btn_addSong.addEventListener(MouseEvent.MOUSE_DOWN, selectSong);
			menu_btn_play.addEventListener(MouseEvent.MOUSE_DOWN, gameStart);
			gameContainer.parallaxField.downPressed = false;
			gameContainer.parallaxField.speedY = 1 * GV.yFactor;
		}
		
		public function nextSong():void
		{
			trace("Next Song...");
			controlPanel.pause();
			menu_songList.nextSong();
			updateAnalyzer();
		}
		public function prevSong():void
		{
			trace("Previous Song...");
			controlPanel.pause();
			menu_songList.prevSong();
			updateAnalyzer();
		}
		
	}

}