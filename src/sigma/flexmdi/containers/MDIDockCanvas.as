
package sigma.flexmdi.containers
{
	import sigma.flexmdi.effects.IMDIEffectsDescriptor;
	import sigma.flexmdi.managers.MDIDockManager;
	
	import mx.containers.Canvas;
	import mx.core.UIComponent;
	import mx.events.FlexEvent;
	import mx.styles.CSSStyleDeclaration;
	import mx.styles.StyleManager;
	
	//--------------------------------------
	//  Styles
	//--------------------------------------
	
	/**
	 *  Style declaration name for the distance at which windows will snap
	 *
	 *  @default 16
	 */
	[Style(name="snapDistance", type="Number", inherit="no")]
	
	/**
	 *  Style declaration name for the distance to which windows will snap
	 *
	 *  @default 8
	 */
	[Style(name="windowGap", type="Number", inherit="no")]
	
	/**
	 * Convenience class that allows quick MXML implementations by implicitly creating
	 * container and manager members of MDI. Will auto-detect MDIWindow children
	 * and add them to list of managed windows.
	 * 
	 * Same as MDICanvas except that it uses an MDIDockManager rather than MDIManager.
	 */
	public class MDIDockCanvas extends Canvas
	{
		public var windowManager:MDIDockManager;
		
		public static const DEFAULT_SNAP_DISTANCE:Number = 16;
		public static const DEFAULT_WINDOW_GAP:Number = 8;
		
		private static var classConstructed:Boolean = classConstruct();
		
		/**
		 * Define and prepare default styles.
		 */
		private static function classConstruct():Boolean
		{
			//------------------------
		    //  type selector
		    //------------------------
			var selector:CSSStyleDeclaration = StyleManager.getStyleDeclaration("MDIDockCanvas");
			if(!selector)
			{
				selector = new CSSStyleDeclaration();
			}
			// these are default names for secondary styles. these can be set in CSS and will affect
			// all windows that don't have an override for these styles.
			selector.defaultFactory = function():void
			{
				this.snapDistance = DEFAULT_SNAP_DISTANCE;
				this.windowGap = DEFAULT_WINDOW_GAP;
			}
			
			StyleManager.setStyleDeclaration("MDIDockCanvas", selector, false);
			
			return true;
		}
		
		public function MDIDockCanvas()
		{
			super();
			windowManager = new MDIDockManager(this);
			addEventListener(FlexEvent.CREATION_COMPLETE, onCreationComplete);
		}
		
		private function onCreationComplete(event:FlexEvent):void
		{
			for each(var child:UIComponent in getChildren())
			{
				if(child is MDIWindow)
				{
					windowManager.add(child as MDIWindow);
				}
			}
			removeEventListener(FlexEvent.CREATION_COMPLETE, onCreationComplete);
		}
		
		public override function styleChanged(styleProp:String):void
		{
			super.styleChanged(styleProp);
			
			var allStyles:Boolean = styleProp == null || styleProp == "styleName";
			
			if( allStyles || styleProp == "snapDistance" )
				windowManager.snapDistance = this.getStyle("snapDistance");
			if( allStyles || styleProp == "windowGap" )
				windowManager.windowGap = this.getStyle("windowGap");
		}
		
		/**
		 * Proxy to MDIManager effects property.
		 * 
		 * @deprecated use effects and class
		 * 
		 */ 
		public function set effectsLib(clazz:Class):void 
		{
			this.windowManager.effects = new clazz();
		}
		
		/**
		 * Proxy to MDIManager property of same name.
		 */
		public function set effects(effects:IMDIEffectsDescriptor):void 
		{
			this.windowManager.effects = effects;		
		}
		
		/**
		 * Proxy to MDIManager property of same name.
		 */
		public function get enforceBoundaries():Boolean
		{
			return windowManager.enforceBoundaries;
		}
		
		public function set enforceBoundaries(value:Boolean):void
		{
			windowManager.enforceBoundaries = value;
		}
		
		public function set disableTopLeft(value:Boolean):void
		{
			windowManager.disableTopLeft = value;
		}
	}
}