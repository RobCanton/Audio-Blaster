package com.robertcanton
{
	import com.robertcanton.static.GV;
	import flash.display.Sprite;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import com.greensock.easing.Strong;
	import com.greensock.TweenLite;
	import com.robertcanton.utils.Queue;
	
	
	/**
	 * ...
	 * @author Robert Canton
	 */
	public class SongList extends Sprite
	{
		public var numItems:int = 0;
		public var current:int = 0;
		public var songArray:Array = new Array();
		
		public function SongList()
		{
			this.graphics.lineStyle(2, 0xFFFFFF);
			this.graphics.drawRect(0, 0, 400 * GV.xFactor, 505 * GV.yFactor);
		}
		
		public function addItem(track:AudioTrack):void
		{	
			songArray.push(track);
			
			var tempItem:Sprite = new Sprite;
			//tempItem.graphics.lineStyle(1, 0xFFFFFF,0.5);
			tempItem.graphics.beginFill(0xFFFFFF, 0.2);
			tempItem.graphics.drawRect(0, 0, 390 * GV.xFactor, 45 * GV.yFactor);
			tempItem.x = 5 * GV.xFactor;
			tempItem.y = this.y + this.height - tempItem.height;
			tempItem.alpha = 0;
			this.addChild(tempItem);
			
			var format:TextFormat = new TextFormat();
			format.font = GV.thinFont.fontName;
			format.size = 14 * GV.yFactor;
			format.align = TextFormatAlign.CENTER;
			format.color = 0xFFFFFF;
			
			var text:TextField = new TextField();
			text.defaultTextFormat = format;
			text.embedFonts = true;
			text.antiAliasType = AntiAliasType.ADVANCED;
			if (track.getSongTitle() == null && track.getSongArtist() == null)
			{
				text.text = track.getSongURL();
			}
			else {
				text.text = track.getSongTitle() + "\n" + track.getSongArtist() + " - " + track.getSongAlbum();
			}
			
			tempItem.addChild(text);
			
			text.selectable = false;
			text.wordWrap = false;
			text.width = tempItem.width;
			text.height = tempItem.height;
			
			var t:TweenLite = TweenLite.to(tempItem, 0.5, { alpha:1, y:5 * GV.yFactor + (50 * GV.yFactor) * numItems, ease:Strong.easeOut } );
			
			numItems ++;
			
		}
		
		public function nextSong():void
		{
			if (current < numItems - 1)
			{
				current ++;
				trace("Current +1");
			}
			else
			{
				current = 0;
				trace("Current reset");
			}
		}
		
		public function prevSong():void
		{
			if (current > 0)
			{
				current --;
				trace("Current -1");
			}
			else
			{
				current = numItems - 1;
				trace("Current reset");
			}
		}
		
	}

}