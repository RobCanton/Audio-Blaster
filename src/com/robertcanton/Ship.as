package com.robertcanton
{
	import com.robertcanton.static.GV;
	import flash.display.Sprite;
	
	//import com.robertcanton.Position;
	
	/**
	 * ...
	 * @author Robert Canton
	 */
	public class Ship extends Sprite
	{
		
		public var mc:mc_ship = new mc_ship;
		
		public function Ship()
		{
			this.mc.scaleX = GV.xFactor;
			this.mc.scaleY = GV.xFactor;
			//this.mc.x = - this.mc.width / 2;
			//this.mc.y = - this.mc.height / 2;
			this.addChild(mc);
		}
		

		
	}

}