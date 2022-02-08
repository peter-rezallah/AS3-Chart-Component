package sigma.flexmdi.managers
{
	import flash.geom.Rectangle;
	
	import sigma.flexmdi.containers.MDIResizeHandle;
	import sigma.flexmdi.containers.MDIWindow;
	import sigma.flexmdi.effects.IMDIEffectsDescriptor;
	import sigma.flexmdi.events.MDIManagerEvent;
	
	import mx.core.EventPriority;
	import mx.core.UIComponent;
	
	/**
	 * Extends the functionality of MDIManager with snapping and (coming soon) docking features
	 */
	public class MDIDockManager extends MDIManager
	{
		/**
		 * Distance at which one window will snap to another when dragging/resizing
		 */
		private var _snapDistance:Number;
		
		/**
		 * Gap between windows that they will snap to
		 */
		private var _windowGap:Number;
		
		/**
		 * Constructor
		 */
		public function MDIDockManager(container:UIComponent, effects:IMDIEffectsDescriptor = null)
		{
			super(container, effects);
			
			addEventListener(MDIManagerEvent.WINDOW_DRAG_END, snapHandler, false, EventPriority.DEFAULT, true);
			addEventListener(MDIManagerEvent.WINDOW_RESIZE_END, snapHandler, false, EventPriority.DEFAULT, true);
			addEventListener(MDIManagerEvent.WINDOW_RESIZE, snapHandler, false, EventPriority.DEFAULT, true);
		}
		
		/**
		 * Handler for MDIManagerEvent.WINDOW_DRAG and MDIManagerEvent.WINDOW_RESIZE events.
		 * 
		 * Check to see if the target window is within snapping distance of any other windows.
		 * Execute the snap that requires the least movement.
		 */
		private function snapHandler(event:MDIManagerEvent):void
		{
			var dragWindow:MDIWindow = event.window;	
			var xDist:Number = Number.MAX_VALUE;
			var yDist:Number = Number.MAX_VALUE;
			var dragRect:Rectangle = getPaddedBounds( dragWindow );
		
			// find the minimum snap (if one exists)
			for each( var window:MDIWindow in windowList )
			{
				var windowRect:Rectangle = getPaddedBounds( window );
				if( window != dragWindow && dragRect.intersects( windowRect ) )
				{
					xDist = calculateSnapDistance( dragWindow.x, window.x + window.width + _windowGap, xDist );
					xDist = calculateSnapDistance( dragWindow.x, window.x, xDist );
					xDist = calculateSnapDistance( dragWindow.x + dragWindow.width, window.x - _windowGap, xDist );
					xDist = calculateSnapDistance( dragWindow.x + dragWindow.width, window.x + window.width, xDist );
					
					yDist = calculateSnapDistance( dragWindow.y, window.y + window.height + _windowGap, yDist );
					yDist = calculateSnapDistance( dragWindow.y, window.y, yDist );
					yDist = calculateSnapDistance( dragWindow.y + dragWindow.height, window.y - _windowGap, yDist );
					yDist = calculateSnapDistance( dragWindow.y + dragWindow.height, window.y + window.height, yDist );
				}
			}
			
			var xChanged:Boolean = xDist < Number.MAX_VALUE;
			var yChanged:Boolean = yDist < Number.MAX_VALUE;
	
			// update the x, y, width, height based on the user interaction
			// event.resizeHandle contains either a resize handle, or null if the window is being dragged
			switch(event.resizeHandle)
			{				
				case MDIResizeHandle.LEFT:
					if( xChanged )
					{
						dragWindow.x -= xDist;
						dragWindow.width += xDist;
					}
				break;
				
				case MDIResizeHandle.RIGHT:
					if( xChanged )
						dragWindow.width -= xDist;
				break;
				
				case MDIResizeHandle.TOP:
					if( yChanged )
					{
						dragWindow.y -= yDist;
						dragWindow.height += yDist;
					}
				break;
				
				case MDIResizeHandle.BOTTOM:
					if( yChanged )
						dragWindow.height -= yDist;
				break;
						
				case MDIResizeHandle.TOP_LEFT:
					if( xChanged )
					{
						dragWindow.x -= xDist;
						dragWindow.width += xDist;
					}
					if( yChanged )
					{
						dragWindow.y -= yDist;
						dragWindow.height += yDist;
					}
				break;
				
				case MDIResizeHandle.TOP_RIGHT:
					if( xChanged )
						dragWindow.width -= xDist;
					if( yChanged )
					{
						dragWindow.y -= yDist;
						dragWindow.height += yDist;
					}
				break;
				
				case MDIResizeHandle.BOTTOM_LEFT:
					if( xChanged )
					{
						dragWindow.x -= xDist;
						dragWindow.width += xDist;
					}
					if( yChanged )
						dragWindow.height -= yDist;
				break;
				
				case MDIResizeHandle.BOTTOM_RIGHT:
					if( yChanged )
						dragWindow.height -= yDist;
					if( xChanged )
						dragWindow.width -= xDist;
				break;
				
				default:
					if( xChanged )
						dragWindow.x -= xDist;
					if( yChanged )
						dragWindow.y -= yDist;
				break;
			}
		}
		
		/**
		 * @return a Rectangle which represents the windows bounds
		 * 	with a buffer around the edge for the _snapDistance
		 */
		private function getPaddedBounds( window:MDIWindow ):Rectangle
		{
			return new Rectangle( window.x-_snapDistance/2, 
									window.y-_snapDistance/2, 
									window.width+_snapDistance, 
									window.height+_snapDistance );
		}
		
		/**
		 * Determine whether these two edges are closer together than the currentShift.  
		 * If so then update the currentShift to the distance between them.
		 * 
		 * @return the updated currentShift
		 */
		private function calculateSnapDistance( edge1:Number, edge2:Number, currentShift:Number ):Number
		{
			var gap:Number = edge1 - edge2;
			if( gap > -_snapDistance && gap < _snapDistance 
				&& Math.abs(gap) < Math.abs(currentShift) )
			{
				currentShift = gap;
			}
			
			return currentShift;
		}
		
		public function set snapDistance( newVal:Number ):void
		{
			_snapDistance = newVal;
		}
		public function get snapDistance():Number
		{
			return _snapDistance;
		}
		
		public function set windowGap( newVal:Number ):void
		{
			_windowGap = newVal;
		}
		public function get windowGap():Number
		{
			return _windowGap;
		}
	}
}