package com.robertcanton
{
	import com.robertcanton.static.ColourScheme;
	import adobe.utils.CustomActions;
	import com.robertcanton.static.GV;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.AntiAliasType;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	/**
	 * ...
	 * @author Robert Canton
	 */
	public class InfoBar extends Sprite
	{
		private var barWidth:Number;
		private var barHeight:Number;
		private var artistName:String;
		private var songName:String;
		private var url:String;
		private var infoFont:Font;
		private var infoFormat:TextFormat;
		public var infoText:TextField;
		private var infoMask:Sprite;
		private var progressBar:Sprite;
			
		public function InfoBar(_panelWidth:Number, _panelHeight:Number)
		{
			trace("InfoBar.as is running...");
			
			barWidth = _panelWidth;
			barHeight = _panelHeight;
			infoFont = new Neou();
			infoFormat = new TextFormat();
			infoText = new TextField();
			createInfoBar();
			progressBar = createProgressBar();
			this.addChild(progressBar);
			progressBar.scaleX = 0;
			//progressBar.addEventListener(Event.ENTER_FRAME, updateProgressBar);
			
		}
		
		private function createInfoBar():void
		{
			this.graphics.lineStyle(1, ColourScheme.CONTROL_PANEL_COLOUR,0.5);
			this.graphics.drawRect(0, 0, barWidth, barHeight);
			infoFormat.size = 18 * barWidth / 480;
			infoFormat.align = TextFormatAlign.CENTER;
			infoFormat.font = infoFont.fontName;
			
			infoText.defaultTextFormat = infoFormat;
			infoText.embedFonts = true;
			infoText.antiAliasType = AntiAliasType.ADVANCED;
		
			infoText.textColor = ColourScheme.CONTROL_PANEL_COLOUR;
			infoText.wordWrap = false;
			infoText.width = barWidth;
			infoText.selectable = false;
			infoText.multiline = false;
			infoText.x = 10 * GV.xFactor;
			infoText.y = 0;
			infoText.width = barWidth - (20 * GV.xFactor);
			this.addChild(infoText);
			
			infoMask = new Sprite;
			infoMask.graphics.lineStyle(1, 0xFF0000);
			infoMask.graphics.beginFill(0x000000, 0.5);
			infoMask.graphics.drawRect(0, 0, barWidth - (20 * GV.xFactor), barHeight);
			infoMask.x = 10 * GV.xFactor;
			this.addChild(infoMask);
			
			infoText.mask = infoMask;
		}
		private function createProgressBar():Sprite
		{
			var temp:Sprite = new Sprite;
			temp.graphics.beginFill(ColourScheme.CONTROL_PANEL_COLOUR, ColourScheme.CONTROL_PANEL_ALPHA);
			temp.graphics.lineStyle(0 , ColourScheme.CONTROL_PANEL_COLOUR, 0);
			temp.graphics.drawRect(0, 0, barWidth, barHeight);
			temp.graphics.endFill(); 
			return temp;
		}
		public function updateProgressBar(scale:Number):void
		{
			progressBar.scaleX = scale;
		}
		public function setArtistName(_artistName:String):void
		{
			artistName = _artistName;
			updateText();
		}
		
		public function setSongName(_songName:String):void
		{
			songName = _songName;
			updateText();
		}
		
		public function setSongURL(_url:String):void
		{
			url = _url;
		}
		
		private function updateText():void
		{
			if (artistName == null && songName == null)
			{
				infoText.text = url;
			}
			else
			{
				infoText.text = artistName + " - " + songName;
			}
		}
	}
	
}