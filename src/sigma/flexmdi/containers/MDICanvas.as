package sigma.flexmdi.containers
{
	import sigma.flexmdi.effects.IMDIEffectsDescriptor;
	import sigma.flexmdi.managers.MDIManager;
	
	import mx.containers.Canvas;
	import mx.core.UIComponent;
	import mx.events.FlexEvent;
	
	/**
	 * Convenience class that allows quick MXML implementations by implicitly creating
	 * container and manager members of MDI. Will auto-detect MDIWindow children
	 * and add them to list of managed windows.
	 */
	public class MDICanvas extends Canvas
	{
		public var windowManager:MDIManager;
		
		public function MDICanvas()
		{
			super();
			windowManager = new MDIManager(this);
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
	}
}