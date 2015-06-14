package com.robertcanton.utils
{
	
	/**
	 * ...
	 * @author Robert Canton
	 */
	internal final class DataNode
    {
        public var value:Object;
        public var next:DataNode;

        public function DataNode(value:Object):void
        {
            this.value = value;
			this.next = null;
        }
    }
	
}