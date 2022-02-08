package elements.labels {
	import charts.Base;
	import charts.ObjectCollection;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import mx.controls.Label;
	import mx.core.FlexGlobals;
	import mx.messaging.messages.ErrorMessage;
	
	import org.flashdevelop.utils.FlashConnect;
	
	import sigma.customeEvents.DeleteStudyByKey;
	
	import spark.components.BorderContainer;
	
	
	
	public class Keys extends Sprite {
		private var _height:Number = 0;
		private var count:Number = 0;
		public var colours:Array;
		private var _timeLabel:TextField ;
		private var _tfArrayLabels:Array = new Array();
		private var _tfArray:Array = new Array();
		private var _closeImg:Array = new Array(); 
		private var _chartType:String ;	
		private var _closeImageTarget:TextField ;
		private var _drawInNewPane:Boolean ;
		
		
		private var imgContainer:CloseImageContainer;
		
		public function Keys( stuff:ObjectCollection , lineType:String = null , drawInNewPane:Boolean = false )
		{
				
			imgContainer = new CloseImageContainer();		
			
			_chartType = lineType ;
			_drawInNewPane = drawInNewPane ;
			
			_timeLabel = new TextField();
			_timeLabel.width = 90 ;
			_timeLabel.height = 20 ;
			addChild(_timeLabel);
			
			
			this.colours = new Array("");
			
			var key:Number = 0;
			for each( var b:Base in stuff.sets )
			{
				for each( var o:Object in b.get_keys() ) {
					
					this.make_key( o.text, o['font-size'], o.colour );
					this.colours.push( o.colour );
					key++;
					
				}
			}
			
			this.count = key;			
			
		}
		
		// each key is a MovieClip with text on it
		private function make_key( text:String, font_size:Number, colour:Number ) : void
		{
			
			var tf:TextField = new TextField();
			var tf_label:TextField = new TextField();
			
			tf.text = text;
			var fmt:TextFormat = new TextFormat();
			fmt.color = colour;
			fmt.font = "Verdana";
			fmt.size = font_size;
			fmt.align = "left";
			
			tf.setTextFormat(fmt);
			tf_label.setTextFormat(fmt);
			tf.autoSize="left";
			tf_label.autoSize="left";
			if( _chartType == "candle")tf_label.width = 150 ;
			else tf_label.width = 40 ;
			
			this.addChild(tf);
			_tfArray.push(tf);
			this.addChild(tf_label);
			_tfArrayLabels.push(tf_label);
			if(!_drawInNewPane && _tfArrayLabels.length > 1)
			{
				tf_label.addEventListener(MouseEvent.MOUSE_OVER , displayCloseImage ) ;
			}
			
			
		}
		
		
		private function displayCloseImage(e:MouseEvent):void
		{			
			_closeImageTarget = TextField(e.target) ;
			
			var _index:int = 0 ;
			
			for each( var _tf:TextField in _tfArrayLabels)
			{
				if ( _closeImageTarget == _tf )
				{
					
					imgContainer.index =  _index ;
				}
				
				_index++ ;
			}		
			
			var _x:Number = e.target.x + e.target.width ;			
			imgContainer.x = _x ;				
			addChild(imgContainer);
			imgContainer.addEventListener(MouseEvent.CLICK , closeImageCliked ) ;
			addEventListener(MouseEvent.ROLL_OUT , removeCloseImage ) ;				
		}
		
		
		private function closeImageCliked(e:MouseEvent):void
		{			
			FlexGlobals.topLevelApplication.dispatchEvent(new DeleteStudyByKey(DeleteStudyByKey.DELETE_STUDY,CloseImageContainer(e.target).index , _drawInNewPane )) ;
						
		}
		
		private function removeCloseImage(e:MouseEvent):void
		{
			/*trace(e.currentTarget);*/
			if( !(e.target == TextField || e.target == CloseImageContainer) )
			{
				if(numChildren > 0 )
				removeChild(imgContainer) ;				
			}			
			removeEventListener(MouseEvent.ROLL_OUT , removeCloseImage);
				
			
		}
		
		//
		// draw the colour block for the data set
		//
		private function draw_line( x:Number, y:Number, height:Number, colour:Number ):Number {
			y += (height / 2);
			this.graphics.beginFill( colour, 100 );
			this.graphics.drawRect( x, y - 1, 10, 2 );
			this.graphics.endFill();
			return x+12;
		}
		
		// shuffle the keys into place, keeping note of the total
		// height the key block has taken up
		public function resize( x:Number, y:Number ):void {
			if( this.count == 0 )
				return;
			
			this.x = x ;
			this.y = y ;
			
			var height:Number = 0;
			var x:Number = 0 + _timeLabel.width ;
			var y:Number = 0;
			
			this.graphics.clear();
			
			var _index:int = 0 ;
			
			for each(var t:TextField in _tfArray )
			{
				var width:Number = t.width;
				var labelWidth:Number = 40 ;
				if(_index == 0 )
				{
					if(_chartType == "candle" || _chartType == "ohlc" )labelWidth = 170 ;
					if(_chartType == "hilo")labelWidth = 80 ;
				}			
				
				if( ( this.x + x + width + 12 + _timeLabel.width ) > this.stage.stageWidth )
				{
					// it is past the edge of the stage, so move it down a line
					x = 0;
					y += t.height;
					height += t.height;
				}
				
				this.draw_line( x, y, t.height, colours[ _index + 1 ] );
				x += 12;
				
				t.x = x;
				t.y = y;
				
				_tfArrayLabels[_index].x = t.x + t.width ;
				_tfArrayLabels[_index].y = y ; 
				
				// move next key to the left + some padding between keys
				x += width + 10 + labelWidth ;
				
				_index ++ ;
			}
			
			
			
			// Ugly code:
			height += this.getChildAt(0).height;
			this._height = height;
		}
		
		public function get_height() : Number {
			return this._height;
		}
		
		public function die(): void {
			
			this.colours = null;
			
			this.graphics.clear();
			while ( this.numChildren > 0 )
				this.removeChildAt(0);
		}
		
		public function get timeLabel():TextField
		{
			return _timeLabel ;
		}
		
		public function getkeyAt(index:int):TextField
		{
			return _tfArrayLabels[index] ;
		}
		
		public function getKeyColorAt(index:int):TextFormat
		{
			if(index == 0 )
			{
				return TextField(getChildAt(index + 1 )).getTextFormat() ;
			}else{
				
				var i:int  = index ;
				index++;
				return TextField(getChildAt(index + i )).getTextFormat() ;
			}
			
		}
		
	}
}