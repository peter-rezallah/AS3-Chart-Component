package sigma.drawingTools.containers
{
	import mx.core.UIComponent;
	import flash.display.Shape;
	import mx.events.FlexEvent;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import sigma.drawingTools.classes.TrendLineTool;
	import flash.geom.Point;
	import sigma.drawingTools.classes.RectangleTool;
	import sigma.drawingTools.classes.DrawingTool;
	import mx.managers.PopUpManager;
	import sigma.drawingTools.classes.DrawingToolManager;

	[Bindable]
	public class BlankPaperWrapper extends UIComponent
	{
		//public STATIC PROPERTIES
		
		//private STATIC PROPERTIES		
		private static var BORDER_WIDTH:int = 400;
		private static var BORDER_HEIGHT:int = 400;
		private static var DEFAULT_TOOL:Class = TrendLineTool; //must extend DrawingTool
		
		public function BlankPaperWrapper():void {
			super();

			this.addEventListener(FlexEvent.CREATION_COMPLETE,onCreationComplete);
			this.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			
		}
		
		//OTHER PROPERTIES (alphabetical)
		private var _border:Shape;
		private var _newTool:DrawingTool = new DrawingTool();
		
		/***
		 * selectedTool 
		 * 
		 * is here so the user can give 
		 * the component a selected tool wf
		 * 
		 * selectedTool must extend the com.acj.paperClasses.DrawingTool class
		 **/
		private var _selectedTool:Class;
		public function set selectedTool(val:Class):void{
			_selectedTool = val;
		}
		public function get selectedTool():Class{
			return _selectedTool;
		}
		
		//EVENT LISTENERS
		private function onCreationComplete(event:FlexEvent):void{
			//placeholder
		}
		
		private function onMouseDown(event:MouseEvent):void{
			trace('onMouse_Down');
			startDragging(event);
		}
				
		protected function startDragging(event:MouseEvent):void
	    {
	    	createTool(event);
	    	
	        systemManager.addEventListener(
	            MouseEvent.MOUSE_MOVE, systemManager_mouseMoveHandler, true);
	
	        systemManager.addEventListener(
	            MouseEvent.MOUSE_UP, systemManager_mouseUpHandler, true);
	
	        systemManager.stage.addEventListener(
	            Event.MOUSE_LEAVE, stage_mouseLeaveHandler);
	    }
	    
	    protected function stopDragging():void
	    {
	    	
	        systemManager.removeEventListener(
	            MouseEvent.MOUSE_MOVE, systemManager_mouseMoveHandler, true);
	
	        systemManager.removeEventListener(
	            MouseEvent.MOUSE_UP, systemManager_mouseUpHandler, true);
	
	        systemManager.stage.removeEventListener(
	            Event.MOUSE_LEAVE, stage_mouseLeaveHandler);
	    }
	    
	    private function systemManager_mouseMoveHandler(event:MouseEvent):void
	    {
	    	var pt:Point = new Point(event.stageX,event.stageY);
	    	pt = globalToLocal(pt);
	    	
	    	_newTool.endX = pt.x;
	    	_newTool.endY = pt.y;
	    	
	    	_newTool.invalidateDisplayList();
	    }
	    
	    private function systemManager_mouseUpHandler(event:MouseEvent):void
	    {
	        //if (!isNaN(regX))
	            stopDragging();
	    }
	    
	    private function stage_mouseLeaveHandler(event:MouseEvent):void
	    {
	        //if (!isNaN(regX))
	            stopDragging();
	    }
	    
	    //OVERRIDDEN METHODS
		override protected function createChildren():void {
			super.createChildren();
			
			/// draws white background
			_border = new Shape();
			_border.graphics.clear();
			_border.graphics.beginFill(0xFFFFFF,1);
			_border.graphics.drawRect(0,0,BORDER_WIDTH,BORDER_HEIGHT);
			_border.graphics.endFill();

			addChild(_border);
		}
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void {
			
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			
			if(isNaN(unscaledWidth) || isNaN(unscaledHeight)) {
				return;
			}
			
		}
		
		//OTHER FUNCTIONS
		private function createTool(event:MouseEvent):void{
			
			if( selectedTool == null )
				selectedTool = DEFAULT_TOOL;
				
			_newTool = DrawingToolManager.createTool(selectedTool,event);
			
	    	addChild(_newTool);
		}
		
	}
}