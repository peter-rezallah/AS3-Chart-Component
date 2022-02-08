package sigma.studies.events
{
	import flash.events.Event;
	
	public class UpdateStudySettings extends Event
	{
		public static const UPDATE_STUDY_SETTINGS:String = "updateStudySettings" ;
		public var parametrs:Array = new Array();
		public var study:Object = new Object();
		
		public function UpdateStudySettings(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			var eventObj:UpdateStudySettings = new UpdateStudySettings(type);
			eventObj.parametrs = this.parametrs ;
			return eventObj ;
		}
	}
}