package com.robertcanton.utils
{
	
	/**
	 * ...
	 * @author Robert Canton
	 */
	public class Queue
    {
		private var N:int;
        private var first:DataNode = null;
		private var last:DataNode = null;

		public function size ():int
		{
			return N;
		}
		public function isEmpty():Boolean
		{
			return first == null;
		}

        public function peek():Object
        {
            if (isEmpty())
			{
				trace("Queue underflow");
			}
			return first.value;
			
        }
		
		public function enqueue(obj:Object):void
		{
			var newNode:DataNode = new DataNode(obj);
			if (isEmpty())
			{
				first = newNode;
				last = newNode;
			}
			else {
				last.next = newNode //Old last points to new last
				last = newNode //last is now new last
			}
			N += 1;
		}
		
		public function dequeue():Object
		{
			var returnValue:Object = null;
			if (!isEmpty())
			{
				returnValue = first.value;
				first = first.next;
				N -= 1;
			}
			else 
			{
				last = null;
				trace("Queue underflow");
			}
			
			return returnValue;
			
		}
    }
	
}