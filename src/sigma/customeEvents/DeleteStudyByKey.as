package sigma.customeEvents
{
	import flash.events.Event;
	
	public class DeleteStudyByKey extends Event
	{
		public static const DELETE_STUDY:String = "studyRemovedByKeyClick" ;
		public var studyIndex:int = 0 ;
		public var drawInNewPane:Boolean ;
		
		public function DeleteStudyByKey(type:String, index:int , drawInNewPanePro:Boolean , bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			studyIndex = index ;
			drawInNewPane = drawInNewPanePro ;
			
		}
		
		override public function clone():Event
		{
			return DeleteStudyByKey(type);
		}
	}
}