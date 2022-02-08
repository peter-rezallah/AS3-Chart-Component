package sigma.customeEvents
{
	import flash.events.Event;
	
	public class TrendLineAdded extends Event
	{
		public static const TRENDLINE_ADDED:String = "trendLineAdded";
		
		private var _point1:Object ;
		private var _point2:Object ;
		private var _pointsData:Array ;
		
		public function TrendLineAdded(type:String, point1:Object , point2:Object , pointsArray:Array , endPiobubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_point1 = point1 ;
			_point2 = point2 ;
			_pointsData = pointsArray ;
		}
		
		override public function clone():Event
		{
			return new TrendLineAdded(type, _point1 , _point2 , _pointsData );
		}
		
		public function get point1():Object
		{
			return _point1 ;
		}
		
		public function get point2():Object
		{
			return _point2 ;
		}
		
		public function get pointsArray():Array
		{
			return _pointsData ;
		}
	}
}