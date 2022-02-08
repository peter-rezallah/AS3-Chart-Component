package sigma.studies.events
{
	import flash.events.Event;
	
	public class CompareEvent extends Event
	{
		public static const XMLLOADED:String = "xmlLoaded" ;
		public var code:String ;
		
		public function CompareEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		

	}
}