package sigma.drawingTools.classes
{
	import mx.core.UIComponent;

	public class VerticalLineTool extends DrawingTool
	{		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void {
			graphics.clear();
			graphics.lineStyle(1, 0x000000, 1);
			graphics.moveTo(startX,startY);
			graphics.lineTo(startX,endY);
		}
		
		public function get finalX():Number
		{
			return startX ;
		}
		
		public function get finalY():Number
		{
			return endY ;
		}
	}
}