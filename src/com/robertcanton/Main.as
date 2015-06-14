package com.robertcanton
{
	import com.robertcanton.Setup;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Robert Canton
	 */
	public class Main extends Sprite
	{
		var _setup:Setup;
		
		public function Main():void
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(Event.DEACTIVATE, deactivate);
			trace("Main.as is running...");
			// touch or gesture?
			//Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			//stage.quality = "LOW";
			_setup = new Setup(stage);
		}
		
		private function deactivate(e:Event):void
		{
			// make sure the app behaves well (or exits) when in background
			//NativeApplication.nativeApplication.exit();
			stage.removeEventListener(Event.DEACTIVATE, deactivate);
			stage.addEventListener(Event.ACTIVATE, activate);
		}
		
		private function activate (e:Event):void
		{
			stage.removeEventListener(Event.ACTIVATE, activate);
			stage.addEventListener(Event.DEACTIVATE, deactivate);
		}
	
	}

}