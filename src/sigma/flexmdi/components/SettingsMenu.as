package sigma.flexmdi.components
{
	[Event(name="menuHide",type="mx.events.MenuEvent")]
	[Event(name="menuShow",type="mx.events.MenuEvent")]
	[Event(name="itemClick",type="mx.events.MenuEvent")]
	
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.geom.Point;
	
	import flashx.textLayout.formats.BackgroundColor;
	
	import mx.containers.Canvas;
	import mx.controls.Button;
	import mx.controls.Menu;
	import mx.core.UIComponent;
	import mx.events.MenuEvent;
	import mx.events.MoveEvent;
	import mx.events.ResizeEvent;
	import mx.managers.IFocusManager;
	import mx.managers.IFocusManagerComponent;
	import mx.managers.PopUpManager;
	
	import spark.filters.DropShadowFilter;
	import spark.filters.GlowFilter;
	
	public class SettingsMenu extends Canvas
	{
		public static const TOP_PADDING:int = 3;
		public static const RIGHT_PADDING:int = 3;
		public static const NUB_WIDTH:int = 25;
		public static const RADIUS:int = 5;
		public static const MENU_PADDING:int = 6;
		
		private var _menu:Menu;
		private var _button:Button;
		private var _dataProvider:Object;
		private var menuSource:XML = <root>
				<menuitem data="browse" label="Browse..."/>
				<menuitem data="remove" label="Remove All"/>
			</root>;
		
		[Bindable]
		private var _parentWidth:int;
		private var _rowHeight:int;
		
		public function SettingsMenu()
		{
			
			super.focusEnabled = true;
			_dataProvider = menuSource ;
			addEventListener( MoveEvent.MOVE, handleMove, false, 0, true );
			
			if (systemManager)
			{
				systemManager.addEventListener( ResizeEvent.RESIZE, handleResize, false, 0, true );
			}
			
			
			
			var localPoint:Point = new Point( 0, 0 );
			var globalPoint:Point = localToGlobal( localPoint ); 
			
			_menu = Menu.createMenu( this, _dataProvider, false );	
			_menu.labelField="@label";
			_menu.setStyle( "openDuration", 20 );
			_menu.setStyle( "dropShadowEnabled", false );
			_menu.setStyle( "borderStyle", "none" );
			_menu.setStyle( "borderVisible",false);
			_menu.setStyle( "dropShadowVisible",false);
			_menu.setStyle( "contentBackgroundAlpha",0.0);
			
			_menu.addEventListener( MenuEvent.MENU_HIDE, handleMenuHide );
			_menu.addEventListener( MenuEvent.MENU_SHOW, handleMenuShow );
			_menu.addEventListener( MenuEvent.ITEM_CLICK, handleItemClick );
			focusManager.setFocus(_menu);
			
			_menu.show( -1000, -1000 );
			
			
			
			var comp:UIComponent = new UIComponent();
			var mask:Shape = new Shape();
			var g:Graphics;
			
			g = mask.graphics;
			g.clear();
			g.beginFill(0x000000,1.0);
			g.lineStyle(0, 0xFF0000);
			
			var height:int = _rowHeight + (MENU_PADDING * 2) + 150;
			var point:Point = new Point( 100 - NUB_WIDTH, _rowHeight );								
			
			drawShape( g, 100, height, point, RADIUS );
			g.endFill();
			
			mask.x = _parentWidth - 100 - RIGHT_PADDING;
			mask.y = TOP_PADDING;
			
			comp.addChild( mask );
			addChild( comp );
			
			this.height = height + MENU_PADDING; 
			this.mask = comp; 		
			
			var ds:DropShadowFilter = new DropShadowFilter();
			ds.distance = 1;
			ds.blurX = 5;
			ds.blurY = 5;
			ds.alpha = .5;
			
			var gf:GlowFilter = new GlowFilter();
			gf.color = 0x000000;
			gf.alpha = .3;
			gf.blurX = 3;
			gf.blurY = 3;
			gf.quality = 1;
			gf.strength = 1;
			
			this.filters = [gf, ds];
			
		}
		
		private function drawShape( g:Graphics, width:int, height:int, point:Point, radius:int ):void
		{
			g.moveTo( 0, point.y + radius);
			g.lineTo( 0, height - radius );
			g.curveTo( 0, height, radius, height );
			g.lineTo( width - radius, height );
			g.curveTo( width, height, width, height - radius );
			g.lineTo( width, radius );
			g.curveTo( width, 0, width - radius, 0 );
			g.lineTo( point.x + radius, 0 );
			g.curveTo( point.x, 0, point.x, radius );
			g.lineTo( point.x, point.y - radius );
			g.curveTo( point.x, point.y, point.x - radius, point.y );
			g.lineTo( radius, point.y );
			g.curveTo( 0, point.y, 0, point.y + radius );				
		}
		
		private function getMenuPosition():Point
		{
			var localPoint:Point = new Point( 0, 0 );
			var globalPoint:Point = localToGlobal( localPoint ); 
			
			var x:int = globalPoint.x + (_parentWidth - _menu.width - RIGHT_PADDING);
			var y:int = globalPoint.y + _rowHeight + MENU_PADDING + TOP_PADDING;
			
			return new Point( x, y );
		}
		
		private function positionMenu():void
		{
			var point:Point = getMenuPosition();
			_menu.move( point.x, point.y );				
		}
		
		private function handleResize( event:Event ):void
		{
			callLater( positionMenu );
		}
		
		private function handleMove( event:Event ):void
		{
			callLater( positionMenu );		
		}
		
		private function handleMenuHide( event:MenuEvent ):void
		{
			if (event.menu == _menu)
			{
				PopUpManager.removePopUp( this );
			}
			
			dispatchEvent( event );
		}
		
		private function handleMenuShow( event:MenuEvent ):void
		{
			dispatchEvent( event );
		}
		
		private function handleItemClick( event:MenuEvent ):void
		{
			dispatchEvent( event );
		}
		
		
	}
}