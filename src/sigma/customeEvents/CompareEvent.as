package sigma.customeEvents
{
	import flash.events.Event;
	
	public class CompareEvent extends Event
	{
		public static const ADD_TO_COMPARE:String = "addToCompare";
		public var CODE:String = null ;
		public var EGX20:Boolean = false ;
		public var EGX30:Boolean = false ;
		public var EGX70:Boolean = false ;
		public var EGX100:Boolean = false ;
		
		public function CompareEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			var eventObj:CompareEvent = new CompareEvent(type);
			eventObj.CODE = this.CODE ;
			eventObj.EGX20 = this.EGX20 ;
			eventObj.EGX30 = this.EGX30 ;
			eventObj.EGX70 = this.EGX70 ;
			eventObj.EGX100 = this.EGX100 ;
			return eventObj ;
			
		}
	}
}