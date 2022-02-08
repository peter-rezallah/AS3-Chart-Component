package sigma.flexmdi.components
{
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	import mx.controls.Label;
	import mx.controls.TextInput;
	
	[Event(name="editLabel",type="flash.events.Event")]
	
	public class LabelEditor extends TextInput
	{
		// store the original text extension
		private var _textExtension:String = "";
		
		// store the updated text value
		private var _updatedText:String = "";
		
		// store the original text value
		private var _originalText:String = "";
		
		private var _defaultText:String="" ; 
			
			
		
		public function LabelEditor()
		{
			super();			
			//addEventListener(MouseEvent.ROLL_OVER, onRollOver);
			//addEventListener(MouseEvent.ROLL_OUT, onRollOut);
			addEventListener("editLabel", edit );
			addEventListener(MouseEvent.DOUBLE_CLICK, onClick);
			addEventListener(Event.CHANGE, onChange);
			addEventListener(FocusEvent.FOCUS_OUT, onFocusOut);
			addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);

			//editable = false; 
			setEditable(false);
			selectable = false ;
			
			
		}
		
		
		
		/**
		*  we overrid the setter for text so we can strip
		 * out any extension and store the initial values
		 * for _originalText and _updatedTex
		*/
		override public function set text(value:String):void
    	{
    		super.text = stripExtension(value);			
    		_originalText = value;
			_updatedText = value;	
			_defaultText = value ;
			
    	}
		
		/**
		*  public getter to return the updated text with extension
		 * if it originally had an extension. 
		*/
		public function get textfull():String
		{
			var txt:String = _originalText;
			if(_textExtension.length > 0)
				txt+= ("." + _textExtension);
			return txt;
		}
		
		protected function onRollOver(event:MouseEvent):void
		{
			//setStyle("textDecoration", "none");
		}
		
		protected function onRollOut(event:MouseEvent):void
		{
			//setEditable(false);
		}
		
		/**
		 *  checks to see if the text has actually changed
		 *  before it dispatches a change event.  We also
		 *  clean the text of any additional values.
		*/
		protected function onChange(event:Event):void
		{
			
			if(_updatedText != _originalText){
				//_originalText = cleanText(_updatedText);
				if(_updatedText.length != 0  ){
					_originalText  = _updatedText;
				}else{
					_originalText = _defaultText ;
				}
				
				text = _originalText;
				
				dispatchEvent(new Event(Event.CHANGE));
			} else {
				event.stopImmediatePropagation();
			}
			
				
			//super.width = super.textWidth + 10
			
			super.width = measureText(_originalText).width + 10 ;
		}
		
		/**
		 *  changes the text if edited item loses focus
		*/
		protected function onFocusOut(event:FocusEvent):void
		{
			_updatedText = text;
			
			if(_updatedText != _originalText){
					dispatchEvent(new Event(Event.CHANGE));
			}
			
			setEditable(false);
		}
		
		/**
		 *  changes the text the enter key is pressed
		 *  if the escape key is pressed, original text 
		 *  value is restored
		*/
		protected function onKeyDown(event:KeyboardEvent):void
		{
			event.stopImmediatePropagation(); // stop the main list from using alphabnumeric navigation
			
			if(event.keyCode == Keyboard.ENTER){
				_updatedText = text;
				setEditable(false);
				dispatchEvent(new Event(Event.CHANGE));
			} else if (event.keyCode == Keyboard.ESCAPE) {
				text = _originalText;
				setEditable(false);
			}
		}
		
		protected function edit(event:Event):void
		{
			setEditable(true);
		}
		
		/**
		 *  click in the textinput will initiate editing
		*/
		protected function onClick(event:MouseEvent):void
		{
			setEditable(true);
		}
		
		/**
		*  @private
		*/
		private function stripExtension(str:String):String
		{
			var ary:Array = str.split(".");
			if(ary.length > 0 && ary[1] != undefined)_textExtension = String(ary[1]); // check if has extension
			return String(ary[0]);
		}
		
		/**
		*  @private
		*/
		private function cleanText(str:String):String
		{
			var ary:Array = str.split(".");
			return String(ary[0]);
		}
		
		/**
		*  @private
		*/
		public function setEditable(bool:Boolean):void
		{
			if(bool){
				editable = true;
				//this.setFocus();
				this.setStyle("backgroundAlpha", "1");
				this.setStyle("borderStyle", "inset");
				this.setSelection(0,text.length);
				
			} else {
				this.setStyle("backgroundAlpha", "0");
				this.setStyle("borderStyle", "none");
				this.selectionBeginIndex = -1;
				this.selectionEndIndex = -1;
				this.editable = false;
			}
		}
	}
}