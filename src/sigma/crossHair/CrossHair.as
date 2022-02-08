package sigma.crossHair
{
	import charts.series.has_tooltip;
	
	import flash.display.Sprite;
	import flash.geom.Point;
	
	public class CrossHair extends Sprite
	{
		private var xLine:Sprite = new Sprite();
		private var yline:Sprite =  new Sprite();
		
		public function CrossHair(x:Number ,y:Number , w:Number , h:Number )
		{
			super();
			drawHorizontalLine(x,y,w,h);
			drawVerticalLine(x,y,w,h);
		}
		
		public function resize(sc:ScreenCoords):void
		{
			yline.height = sc.height;
			yline.y = sc.top
			xLine.width = sc.width ;
			xLine.x = sc.left ;
		}
		
		private function drawHorizontalLine(x:Number ,y:Number , w:Number , h:Number):void
		{
			xLine.graphics.clear();
			xLine.graphics.lineStyle(1, 0x999999, 1);
			xLine.graphics.moveTo(0,y);
			xLine.graphics.lineTo(w,y);
			addChild(xLine);
		}
		
		private function drawVerticalLine(x:Number ,y:Number , w:Number , h:Number):void
		{
			/*trace("draw ver line");*/
			yline.graphics.clear();
			yline.graphics.lineStyle(1, 0x999999, 1);
			yline.graphics.moveTo(x,0);
			yline.graphics.lineTo(x,h);
			addChild(yline);
		}
		
		public function moveCross(x:Number,y:Number):void
		{
			yline.x = x ;
			xLine.y = y ;
		}
		
		public function closest( elements:Array ):void {
			
			if( elements.length == 0 )return;
			
			
			
			//this.make_tip( elements );
			
			var p:flash.geom.Point = get_pos( elements[0] );			
			this.visible = true;
			
			yline.x = p.x ;
			xLine.y = p.y ;
			
			/*Tweener.addTween(this, { x:p.x, time:0.3, transition:Equations.easeOutExpo } );
			Tweener.addTween(this, { y:p.y, time:0.3, transition:Equations.easeOutExpo } );*/
		}
		
		private function get_pos( e:has_tooltip ):flash.geom.Point {
			
			var pos:Object = e.get_tip_pos();
			
			var x:Number = pos.x;
			
			var y:Number = pos.y;
			//y -= 4;
			//y -= (this.height + 10 ); // 10 == border size
			
			if( y < 0 )
			{
				// the tooltip has drifted off the top of the screen, move it down:
				y = 0;
			}
			return new flash.geom.Point(x, y);
		}
		
		public function die():void
		{			
			xLine.graphics.clear();
			yline.graphics.clear();
			
			while( this.numChildren > 0 )
				this.removeChildAt(0);
		}
	}
}