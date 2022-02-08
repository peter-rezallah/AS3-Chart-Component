package elements.labels
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	import spark.core.SpriteVisualElement;
	
	public class CloseImageContainer extends SpriteVisualElement
	{
		private var _relevantTarget:String ;
		private var _index:int ;
		[Embed(source='../../sigma/assets/close_pane.png')]
		private var CloseImage:Class;	
		private var img:Bitmap ;
		
		public function CloseImageContainer()
		{
			super();
			img = new CloseImage();
			addChild(img);
			buttonMode = true ;
		}
		
		public function set index(val:int):void
		{
			_index = val ;
		}
		
		public function get index():int
		{
			return _index ;
		}
		
		public function set studyTargetName(val:String):void
		{
			_relevantTarget = val ;
		}
		
		public function get studyTargetName():String
		{
			return _relevantTarget ;
		}
	}
}