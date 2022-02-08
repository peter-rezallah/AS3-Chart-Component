/* */

package elements.labels {
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	
	import mx.core.IVisualElement;
	
	import spark.components.HGroup;
	import spark.components.Label;
	
	import string.Css;
	
	
	public class BaseLabel extends HGroup {
		public var text:String;
		protected var css:Css;
		public var style:String;
		protected var _height:Number;
		private var _closeBtn:CloseImageContainer ;
		private var title:Label ;
		/*private var _timeLabel:Label ;*/
		
		public function BaseLabel()	
		{
			 
		}
		
		protected function build( text:String ):void {
			
			
			this.percentWidth = 100 ;
			
			
			/*_timeLabel = new Label();
			
			_timeLabel.width = 100 ;
			_timeLabel.height = 20 ;
			
			_timeLabel.y = css.padding_top + css.margin_top ;
			_timeLabel.x = css.padding_left + css.margin_left ;*/
			
			//_timeLabel.text = "10:50" ;
			
			
			
			title = new Label();
           // title.x = 0;
			title.width = 100 ;
			title.height = 20 ;
			//title.y = 0;
			
			this.text = text;
			
			title.text = this.text;
			
			/*var fmt:TextFormat = new TextFormat();
			fmt.color = this.css.color;
			//fmt.font = "Verdana";
			fmt.font = this.css.font_family?this.css.font_family:'Verdana';
			fmt.bold = this.css.font_weight == 'bold'?true:false;
			fmt.size = this.css.font_size;
			fmt.align = "center";
		
			title.setTextFormat(fmt);
			title.autoSize = "left";*/
			
			title.y = css.padding_top + css.margin_top ;
			title.x = css.padding_left + css.margin_left ;
			
//			title.border = true;
			
			if ( this.css.background_colour_set )
			{
				this.graphics.beginFill( this.css.background_colour, 1);
				this.graphics.drawRect(0,0,this.css.padding_left + title.width + this.css.padding_right, this.css.padding_top + title.height + this.css.padding_bottom );
				this.graphics.endFill();
			}
			
			/*addElement(_timeLabel);*/
			addElement(title);
			
			
			buildCloseBtns();
		}
		
		private function buildCloseBtns():void
		{
			_closeBtn = new CloseImageContainer();
			_closeBtn.width = 25;
			_closeBtn.height = 25;			
			_closeBtn.x = width - _closeBtn.width ;			
			this.addElement(_closeBtn);				
		}
		
		public function get_width():Number {
			return this.getElementAt(0).width;
		}
		
		public function die(): void {
			
			this.graphics.clear();
			while ( this.numChildren > 0 )
				this.removeElementAt(0);
		}
		
		public function get closeButton():CloseImageContainer
		{
			return _closeBtn ;
		}
		
		/*public function get timeLabel():Label
		{
			return _timeLabel ;
		}*/
	}
}