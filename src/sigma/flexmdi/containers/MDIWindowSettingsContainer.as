package sigma.flexmdi.containers
{
	[Event(name="menuHide",type="mx.events.MenuEvent")]
	[Event(name="menuShow",type="mx.events.MenuEvent")]
	[Event(name="itemClick",type="mx.events.MenuEvent")]
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import mx.controls.Button;
	import mx.controls.LinkButton;
	import mx.core.ContainerLayout;
	import mx.core.EdgeMetrics;
	import mx.core.FlexGlobals;
	import mx.core.LayoutContainer;
	import mx.core.UITextField;
	import mx.events.FlexEvent;
	import mx.events.MenuEvent;
	import mx.events.MoveEvent;
	import mx.graphics.SolidColorStroke;
	import mx.managers.PopUpManager;
	
	import sigma.flexmdi.components.DropDownSettingsMenu;
	import sigma.flexmdi.components.LabelEditor;
	import sigma.flexmdi.components.SettingsMenu;
	
	import spark.primitives.Line;
	
	
	public class MDIWindowSettingsContainer extends LayoutContainer
	{
		public var windowCaptionLabel:LabelEditor;
		public var window:MDIWindow;
		public var settingsMenu:DropDownSettingsMenu;
		public var settingsButton:LinkButton;
		public var addSymbolBtn:LinkButton ;
		
		private var tf:UITextField;
		private var _vSep:Line;
		private var _solidStroke:SolidColorStroke ;
		private var _menuDataProvider:XML ;
		private var _windowCaptionLabelText:String ;
		private var _lang:String ;
		private var _showWindowCaption:Boolean ; 
		private var _showWindowMenuSettings:Boolean ;
		private var _searchWindowState:String ;
		
		
		private static const LEFT_PADDING:int = 10;
		
		public function MDIWindowSettingsContainer()
		{
			super();
			_solidStroke = new SolidColorStroke(0xcc0000);
			layout = ContainerLayout.HORIZONTAL;
			addEventListener( MoveEvent.MOVE, handleMove );
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			/*if(!_vSep)
			{
				_vSep = new Line();
				_vSep.stroke = _solidStroke;
				addChild(_vSep);
			}*/
			
			
			
			if(_showWindowCaption)
			{
				if(!windowCaptionLabel)
				{
					windowCaptionLabel = new LabelEditor();
					// windowCaptionLabel.addEventListener()
					addChild(windowCaptionLabel);
					
				}
			}
			
			if(_showWindowMenuSettings)
			{
				if(!settingsButton)
				{
					settingsButton = new LinkButton();
					settingsButton.buttonMode = true ;
					settingsButton.styleName = "linkButtonMDIWindow";
					switch(_lang)
					{
						case("en_US"):
							settingsButton.label = "Window Settings";
							break;
						case("ar_EG"):
							settingsButton.label = "خيارات النافذة";
							break
					}
					
					/*settingsButton.setStyle("backgroundStyle","none" );
					settingsButton.setStyle( "borderStyle", "none" );*/
					settingsButton.addEventListener(MouseEvent.CLICK , hadleSettingsBtnClick )
					addChild(settingsButton);
					
				}
			}
			
			
			if(!addSymbolBtn)
			{
				addSymbolBtn = new LinkButton();
				addSymbolBtn.buttonMode = true ;
				addChild(addSymbolBtn);
			}
		}		
		
		
		override protected function resourcesChanged():void
		{
			try{
				_lang = FlexGlobals.topLevelApplication.langCombo.selectedItem.localeChain.item.toString() ;
				
				if(_searchWindowState == "opened")
				{
					addSymbolBtn.label = resourceManager.getString("myResources", "closesymbolbtn" ) ;
					
				}else{
					
					addSymbolBtn.label = resourceManager.getString("myResources", "addsymbolbtn" ) ;
				}
				
				switch(_lang)
				{
					case("en_US"):
						if(_showWindowMenuSettings)settingsButton.label = "Window Settings";
						break;
					case("ar_EG"):
						if(_showWindowMenuSettings)settingsButton.label = "خيارات النافذة";						
						break
				}
			}catch(e)
			{
				
			}
			
		}
		
		override protected function updateDisplayList(w:Number, h:Number):void
		{
			super.updateDisplayList(w,h);
			var minX:Number = 9999;
			var minY:Number = 9999;
			var maxX:Number = -9999;
			var maxY:Number = -9999;
			for each(var child:DisplayObject in this.getChildren())
			{
				minX = Math.min(minX, child.x);
				minY = Math.min(minY, child.y);
				maxX = Math.max(maxX, child.x + child.width);
				maxY = Math.max(maxY, child.y + child.height);
			}
			this.setActualSize(maxX - minX, maxY - minY);
			
			// now that we're sized we set our position
			// right aligned, respecting border width
			tf = window.getTitleTextField();
			var icon:DisplayObject = window.getTitleIconObject();
			
			this.x = tf.textWidth + Number(window.getStyle("borderThicknessRight"))+ LEFT_PADDING ;
			// vertically centered
			this.y = (window.titleBarOverlay.height - this.height) / 2 ;
			
			// lay out the title field and icon (if present)
			
			
			tf.x = Number(window.getStyle("borderThicknessLeft"));
			
			if(icon)
			{
				icon.x = tf.x;
				tf.x = icon.x + icon.width + 4;
			}
			
			// ghetto truncation
			if(!window.minimized)
			{
				tf.width = this.x - tf.x;
			}
			else
			{
				tf.width = window.width - tf.x - 4;
			}
		}
		
		private function hadleSettingsBtnClick(e:Event = null):void
		{
			settingsMenu = new DropDownSettingsMenu();
			settingsMenu.dataProvider = _menuDataProvider;
			if(_showWindowCaption)
			{
				settingsMenu.parentWidth = tf.textWidth+windowCaptionLabel.width+100;
			}else{
				
				settingsMenu.parentWidth = tf.textWidth + 100  ;
			}
			
			settingsMenu.rowHeight = 20;
			settingsMenu.addEventListener( MenuEvent.MENU_HIDE, handleMenuHide );
			settingsMenu.addEventListener( MenuEvent.MENU_SHOW, handleMenuShow );
			settingsMenu.addEventListener( MenuEvent.ITEM_CLICK, handleItemClick );
			positionActionsMenu();
			PopUpManager.addPopUp( settingsMenu, this );
			if (e)
			{
				e.stopPropagation();
			}
			
		}
		
		private function positionActionsMenu():void
		{
			if (!settingsMenu)
			{
				return;
			}
			
			var localPoint:Point = new Point( 0, 0 );
			var globalPoint:Point = localToGlobal( localPoint );
			
			var vm:EdgeMetrics = viewMetricsAndPadding;
			var textHeight:int = settingsButton.height + vm.top + vm.bottom;
			
						
			settingsMenu.x = globalPoint.x ;
			settingsMenu.y = globalPoint.y + (height - textHeight);			
		}
		
		private function handleMenuHide( event:Event ):void
		{	
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
		
		private function handleMove( event:Event ):void
		{
			callLater( positionActionsMenu );
		}
		
		public function set windowSettingsDataProvider(val:XML):void
		{
			_menuDataProvider =val ;
		}
		
		public function setWindowCaptionLabelText(val:String):void
		{
			_windowCaptionLabelText = val ;
			if(_windowCaptionLabelText == null ) windowCaptionLabel.text = "Edit Window Caption" 
			else windowCaptionLabel.text = _windowCaptionLabelText ;
		}
		
		public function get windowCaptionLabelText():String
		{
			return windowCaptionLabel.text ;
		}
		
		public function updateSelectedTab(index:uint , newLabel):void
		{
			
		}
		
		public function set lang(val:String):void
		{
			_lang = val ;
		}
		
		public function set showWindowCaption(val:Boolean):void
		{
			_showWindowCaption = val
		}
		
		public function set showWindowMenuSettings(val:Boolean):void
		{
			_showWindowMenuSettings = val
		}
		
		public function set searchWindowState(val:String):void
		{
			_searchWindowState = val ;
		}
											  
	}
}