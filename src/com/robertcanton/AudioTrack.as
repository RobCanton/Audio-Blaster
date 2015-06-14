package com.robertcanton
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.filesystem.File;
	import flash.media.ID3Info;
	import flash.media.Sound;
	import flash.media.SoundLoaderContext;
	import flash.net.FileFilter;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author Robert Canton
	 */
	public class AudioTrack
	{
		private var file:File = new File();
		private var song:Sound = new Sound();
		private var songID3:ID3Info;
		private var songTitle:String;
		private var songArtist:String;
		private var songAlbum:String;
		private var songGenre:String;
		private var songTrack:String;
		private var songYear:String;
		private var songURL:String;
		private var _dispatcher:EventDispatcher;
		
		public function AudioTrack(dispatcher:EventDispatcher)
		{
			
			trace("AudioTrack.as is running...");
			var musicFilter:FileFilter = new FileFilter("Music", "*.mp3;*.m4a;");
			file.browseForOpen("Open file", [musicFilter]);
			file.addEventListener(Event.SELECT, sndSelected);
			_dispatcher = dispatcher;
		}
		
		private function sndSelected(event:Event):void
		{
			var urlReq:URLRequest = new URLRequest(file.url);
			var context:SoundLoaderContext = new SoundLoaderContext(5000);
			song.addEventListener(Event.COMPLETE, onSoundLoaded);
			song.load(urlReq, context);
		
		}
		
		private function onSoundLoaded(event:Event):void
		{
			song = event.target as Sound;
			
			songID3 = song.id3;
			
			songTitle = (songID3.songName != null) ? songID3.songName : "";
			songArtist = (songID3.artist != null) ? songID3.artist : "";
			songAlbum = (songID3.album != null) ? songID3.album : "";
			songGenre = (songID3.genre != null) ? songID3.genre : "";
			songTrack = (songID3.track != null) ? songID3.track : "";
			songYear = (songID3.year != null) ? songID3.year : "";
			songURL = song.url;
			trace ("SONG INFO: \n" + songTitle + "\n" + songAlbum + "\n" + songGenre + "\n" + songYear + "\n" + songURL);
			
			_dispatcher.dispatchEvent(new Event("songLoaded"));
		}
		
		public function playSong():void
		{
			song.play();
		}
		
		//Getters
		
		public function getSong():Sound
		{
			return song;
		}
		public function getSongTitle():String
		{
			return songTitle;
		}
		
		public function getSongArtist():String
		{
			return songArtist;
		}
		
		public function getSongAlbum():String
		{
			return songAlbum;
		}
		
		public function getSongGenre():String
		{
			return songGenre;
		}
		
		public function getSongTrack():String
		{
			return songTrack;
		}
		
		public function getSongYear():String
		{
			return songYear;
		}
		
		public function getSongURL():String
		{
			return songURL;
		}
	}

}