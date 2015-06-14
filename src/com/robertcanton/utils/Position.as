package com.robertcanton.utils
{
	
	/**
	 * ...
	 * @author Robert Canton
	 */
	public class Position 
	{
		private var xPos:Number;
		private var yPos:Number;
		
		public function Position(_x:Number, _y:Number)
		{
			xPos = _x;
			yPos = _y;	
		}
		
		//Setters and Getters
		public function setX(_x:Number):void
		{
			xPos = _x;
		}
		
		public function setY(_y:Number):void
		{
			yPos = _y;
		}
		
		public function getX():Number
		{
			return xPos;
		}
		
		public function getY():Number
		{
			return yPos;
		}
	}
	
}