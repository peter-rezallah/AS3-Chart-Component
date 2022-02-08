package sigma.customeEvents
{
	import flash.events.Event;

	public class StudyPaneDeleted extends Event
	{
		public static const STUDY_PANE_REMOVED:String = "studyRemoved";
		private var _studyName:String ;
		
		public function StudyPaneDeleted(type:String , studyName:String , endPiobubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_studyName = studyName ;
		}
		
		override public function clone():Event
		{
			return new StudyPaneDeleted( type , _studyName );
		}
		
		public function get studyName():String
		{
			return _studyName ;
		}
	}
}