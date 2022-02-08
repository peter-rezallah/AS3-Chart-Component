package sigma
{
	public class Constants
	{
		private static const DOMAIN:String = "http://www.sigma-capital.com";	
		public static const RESOURCE_FILE_SERVER_PATH:String = "assets/resources/";
		public static const THEMEPATH:String = "sigma/themes/" ;
		
		
		
		
		/*public static const THEMEPATH:String = "/flex/sigma/themes/"
		private static const DOMAIN:String = "" ;
		public static const RESOURCE_FILE_SERVER_PATH:String = "/flex/assets/resources/" ;*/
		
		
		public static const RESOURCE_FILE_EXTENSION:String = ".xml";
		
		// search panel properties
		public static const MASK_HEIGHT:int = 80;
		public static const RADIUS:int = 5;
		public static const BUTTON_HIGHT:int = 20 ;
		public static const ANIMATION_DURATION:int = 200;
		public static const PRELOADER_WIDTH:int = 220;
		public static const PRELOADER_HEIGHT:int = 200;
		
		public static const CONNECTION_URL:String = "streamer.sigma-capital.com" ;
		public static const SYMBOLS_URL:String = DOMAIN + "/test/get_shares_xml?lang=en";
		public static const FIELDS_URL:String = DOMAIN + "/test/get_streamer_fields_xml";
		public static const USER_DATA_URL:String = DOMAIN + "/test/get_streamer_cust_param_xml";
		public static const USER_DATA_URL_SAVE:String = DOMAIN + "/test/Set_streamer_cust_param";
		public static const TRADES_URL:String = DOMAIN + "/test/get_market_trades_xml";
		public static const NEWS_URL:String = DOMAIN + "/test/get_news_xml";
		public static const CHART_URL:String = DOMAIN + "/test/get_chart_hist_xml";
		
		//window type/name
		
		public static const QUOTES_WINDOW:String = "wtQuotes";
		public static const DETAILED_WINDOW:String = "wtDetailed";
		public static const LEVEL2_WINDOW:String = "wtLevel ||";
		public static const TIMESALES_WINDOW:String = "wtTime & Sales";
		public static const NEWS_WINDOW:String = "wtNews";
		public static const TOPTEN_WINDOW:String = "wtTop Ten";
		public static const INVESTORS_WINDOW:String = "wtInvestors";
		public static const CHART_WINDOW:String = "wtChart";
		
		// window width
		
		public static const WIDTH_QUOTES_WINDOW:int = 550;
		public static const HEIGHT_QUOTES_WINDOW:int = 200 ;
		public static const WIDTH_DETAILED_WINDOW:int = 100 ;
		public static const HEIGHT_DETAILED_WINDOW:int = 200 ;
		public static const WIDTH_LEVEL2_WINDOW:int = 230;
		public static const MINWIDTH_LEVEL2_WINDOW:int = 230;
		public static const HEIGHT_LEVEL2_WINDOW:int = 270;
		public static const WIDTH_TIMESALES_WINDOW:int = 550 ;
		public static const HEIGHT_TIMESALES_WINDOW:int = 200 ;
		public static const WIDTH_NEWS_WINDOW:int = 100;
		public static const HEIGHT_NEWS_WINDOW:int = 200 ;
		public static const WIDTH_TOPTEN_WINDOW:int = 100 ;
		public static const WIDTH_INVESTORS_WINDOW:int = 100 ;
		public static const WIDTH_CHART_WINDOW:int = 100 ;
		public static const HEIGHT_CHART_WINDOW:int = 200 ;

		public static const QL_CONTEXTMENU_BUY:String = "Buy";
		public static const QL_CONTEXTMENU_SELL:String = "Sell";
		public static const QL_CONTEXTMENU_TRADES:String = "Trades";
		public static const QL_CONTEXTMENU_DETQUOTE:String = "Detailed Quote";
		public static const QL_CONTEXTMENU_CHART:String = "Chart";
		public static const QL_CONTEXTMENU_NEWS:String = "News";
		public static const QL_CONTEXTMENU_LEVEL2:String = "Level2";
		public static const QL_CONTEXTMENU_DELETE:String = "Delete Symbol";	
		
		public static const QL_CONTEXTMENU_BUY_AR:String = "طلب شراء";
		public static const QL_CONTEXTMENU_SELL_AR:String = "طلب بيع";
		public static const QL_CONTEXTMENU_TRADES_AR:String = "تنفيذات";
		public static const QL_CONTEXTMENU_DETQUOTE_AR:String = "أسعار تفصيلية";
		public static const QL_CONTEXTMENU_CHART_AR:String = "رسم بيانى";
		public static const QL_CONTEXTMENU_NEWS_AR:String = "أخبار";
		public static const QL_CONTEXTMENU_LEVEL2_AR:String = "عروض و طلبات";
		public static const QL_CONTEXTMENU_DELETE_AR:String = "حذف";	
		
		
		public static const CONTEXT_MENU_LABEL_MINIMIZE:String = "Minimize";
		public static const CONTEXT_MENU_LABEL_MAXIMIZE:String = "Maximize";
		public static const CONTEXT_MENU_LABEL_RESTORE:String = "Restore";
		public static const CONTEXT_MENU_LABEL_CLOSE:String = "Close";
		
		public static const CONTEXT_MENU_LABEL_TILE:String = "Tile";
		public static const CONTEXT_MENU_LABEL_TILE_FILL:String = "Tile + Fill";
		public static const CONTEXT_MENU_LABEL_CASCADE:String = "Cascade";
		public static const CONTEXT_MENU_LABEL_SHOW_ALL:String = "Show All Windows";
		
		public static const CONTEXT_MENU_LABEL_MINIMIZE_AR:String = "تصغير";
		public static const CONTEXT_MENU_LABEL_MAXIMIZE_AR:String = "تكبير";
		public static const CONTEXT_MENU_LABEL_RESTORE_AR:String = "إستعادة";
		public static const CONTEXT_MENU_LABEL_CLOSE_AR:String = "إغلاق";
		
		public static const CONTEXT_MENU_LABEL_TILE_AR:String = "ترتيب النوافذ";
		public static const CONTEXT_MENU_LABEL_TILE_FILL_AR:String = "ترتيب + ملء الشاشة";
		public static const CONTEXT_MENU_LABEL_CASCADE_AR:String = "تتابع النوافذ";
		public static const CONTEXT_MENU_LABEL_SHOW_ALL_AR:String = "عرض جميع النوافذ";
		
		
		/* time sales window fields name */
		
		public static const EngName:String = "Share Name";
		public static const ArbName_AR:String = "اسم السهم";
		public static const Symbol:String = "Stock" ;
		public static const Symbol_AR:String = "الرمز" ;
		public static const Time:String = "Time";
		public static const Time_AR:String = "وقت";
		public static const Price:String = "Price";
		public static const Price_AR:String = "سعر";
		public static const Volume:String = "QTY";
		public static const Volume_AR:String = "كمية";
		public static const VWAP:String = "VWAP";
		public static const VWAP_AR:String = "م.م";
		public static const Indicator:String = "Flag";
		public static const Indicator_AR:String = "مؤشر";
		
		public static const TIME_SALES_FIELDS_EN:Array = ["Symbol","RecCount","Ticket","Price","QTY","Time","Flag","Share Name","Arb Name","V. wap"];
		public static const TIME_SALES_FIELDS_AR:Array = ["Symbol","RecCount","Ticket","Price","QTY","Time","Flag","Share Name","Arb Name","V. wap"];

		
		public static const BA_TABLE_COL_NAME_0:String = "price";
		public static const BA_TABLE_COL_NAME_1:String = "QTY.";
		public static const BA_TABLE_COL_NAME_2:String = "#";
		
		public static const BA_TABLE_COL_NAME_AR_0:String = "سعر";
		public static const BA_TABLE_COL_NAME_AR_1:String = "كمية";
		public static const BA_TABLE_COL_NAME_AR_2:String = "#"; 
		
		public static const BA_TABLE_COLS:Array = ["PRICE","QTY","COUNT"];
		
				
		public static const NEWS_TABLE_COL_NAME_0:String = "reuter";
		public static const NEWS_TABLE_COL_NAME_2:String = "Name";		
		public static const NEWS_TABLE_COL_NAME_5:String = "Date.";
		public static const NEWS_TABLE_COL_NAME_6:String = "head"; 
		public static const NEWS_TABLE_COL_NAME_7:String = "News";
		public static const NEWS_FIELDS:Array = ["","Sym","Name","Token","NewsDate","Head","News","Typ"];
		
		public static const TOP_TEN_TABLE_COL_NAME_0:String = "SYM";
		public static const TOP_TEN_TABLE_COL_NAME_1:String = "Change";
		public static const TOP_TEN_TABLE_COL_NAME_2:String = "Change%";
		public static const TOP_TEN_TABLE_COL_NAME_3:String = "Fluct";
		public static const TOP_TEN_TABLE_COL_NAME_4:String = "Volume";
		public static const TOP_TEN_TABLE_COL_NAME_5:String = "High";
		public static const TOP_TEN_TABLE_COL_NAME_6:String = "Low";
		public static const TOP_TEN_TABLE_COL_NAME_7:String = "First Price";
		public static const TOP_TEN_TABLE_COL_NAME_8:String = "Close price";
		public static const TOP_TEN_TABLE_COL_NAME_9:String = "Price";
		public static const TOP_TEN_TABLE_COL_NAME_10:String = "Previous Close";
		public static const TOP_TEN_TABLE_COL_NAME_11:String = "Turnover";
		public static const TOP_TEN_TABLE_COL_NAME_12:String = "Code";
		public static const TOP_TEN_TABLE_COL_NAME_13:String = "Share Name";
		public static const TOP_TEN_TABLE_COL_NAME_14:String = "Share Name AR";
		
		public static const TOP_TEN_TABLE_COL_NAME_AR_0:String = "سهم";
		public static const TOP_TEN_TABLE_COL_NAME_AR_1:String = "مقدار التغير";
		public static const TOP_TEN_TABLE_COL_NAME_AR_2:String = "نسبة التغير";
		public static const TOP_TEN_TABLE_COL_NAME_AR_3:String = "الفرق";
		public static const TOP_TEN_TABLE_COL_NAME_AR_4:String = "حجم التداول";
		public static const TOP_TEN_TABLE_COL_NAME_AR_5:String = "أعلى سعر";
		public static const TOP_TEN_TABLE_COL_NAME_AR_6:String = "أقل سعر";
		public static const TOP_TEN_TABLE_COL_NAME_AR_7:String = "سعر الفتح";
		public static const TOP_TEN_TABLE_COL_NAME_AR_8:String = "سعر الإغلاق";
		public static const TOP_TEN_TABLE_COL_NAME_AR_9:String = "السعر";
		public static const TOP_TEN_TABLE_COL_NAME_AR_10:String = "الإغلاق السابق";
		public static const TOP_TEN_TABLE_COL_NAME_AR_11:String = "قيمة التداول";
		public static const TOP_TEN_TABLE_COL_NAME_AR_12:String = "رمز";
		public static const TOP_TEN_TABLE_COL_NAME_AR_13:String = "اسم السهم";
		public static const TOP_TEN_TABLE_COL_NAME_AR_14:String = "اسم السهم";
		
		
		public static const TOP_TEN_TABLE_COLS:Array = ["SYM","CHANGE","CHANGE_PERCENTAGE","FLUCTUATION","VOLUME","HIGH_PRICE","LOW_PRICE","FIRST_PRICE","CLOSING_PRICE","LAST_PRICE","PREVIOUS_CLOSE","TURN_OVER","EQ_CODE","ENG_NAME","ARB_NAME"];
		
		// OTC & Normal CONSTANTS
		
		public static const SESSION_STATE_0:String = "CLOSED";
		public static const SESSION_STATE_1:String = "CLOSED";
		public static const SESSION_STATE_11:String = "CLOSED";
		public static const SESSION_STATE_13:String = "CLOSED";
		public static const SESSION_STATE_2:String = "CLOSED";
		public static const SESSION_STATE_12:String = "OPEN";
		public static const SESSION_STATE_15:String = "OPEN";
		public static const SESSION_STATE_14:String = "PRE-OPEN";
		public static const SESSION_STATE_19:String = "ADJUSTEMENT";
		
		public static const SESSION_STATE_AR_0:String = "مغلق";
		public static const SESSION_STATE_AR_1:String = "مغلق";
		public static const SESSION_STATE_AR_11:String = "مغلق";
		public static const SESSION_STATE_AR_13:String = "مغلق";
		public static const SESSION_STATE_AR_2:String = "مغلق";
		public static const SESSION_STATE_AR_12:String = "مفتوح";
		public static const SESSION_STATE_AR_15:String = "مفتوح";
		public static const SESSION_STATE_AR_14:String = "إستكشاف";
		public static const SESSION_STATE_AR_19:String = "تعدبل";
		
		//style otc & normal sessions
		
		public static const STYLE_SESSION_STATE_0:String = "closedStyle";
		public static const STYLE_SESSION_STATE_1:String = "closedStyle";
		public static const STYLE_SESSION_STATE_11:String = "closedStyle";
		public static const STYLE_SESSION_STATE_13:String = "closedStyle";
		public static const STYLE_SESSION_STATE_2:String = "closedStyle";
		public static const STYLE_SESSION_STATE_12:String = "openedStyle";
		public static const STYLE_SESSION_STATE_15:String = "openedStyle";
		public static const STYLE_SESSION_STATE_14:String = "openedStyle";
		public static const STYLE_SESSION_STATE_19:String = "openedStyle";
		
		public static const SUPPORTEDLOCALES:XML =
			 	
			<locales>
				<locale id='en' label='English'>
					<localeChain>
						<item>en_US</item> 
					</localeChain>
				</locale>
				<locale id='ar' label='العربية'>
					<localeChain>
						<item>ar_EG</item> 
					</localeChain>
				</locale>
			</locales>;
		
		
		/*[Embed(source="sigma/assets/connected.png")]
		public static var CONNECTED:Class;
		
		[Embed(source="sigma/assets/connected_ar.png")]
		public static var CONNECTED_AR:Class;
		
		[Embed(source="sigma/assets/connecting.png")]
		public static var CONNECTING:Class;
		
		[Embed(source="sigma/assets/connecting_ar.png")]
		public static var CONNECTING_AR:Class;
		
		[Embed(source="sigma/assets/disconnected.png")]
		public static var DISCONNECTED:Class;
		
		[Embed(source="sigma/assets/disconnected_ar.png")]
		public static var DISCONNECTED_AR:Class;
		
		[Embed(source="sigma/assets/rocks.png")]
		public static var ROCKS:Class;
		
		[Embed(source="sigma/assets/aeon.png")]
		public static var AEON:Class;
		
		[Embed(source="sigma/assets/original.png")]
		public static var ORIGINAL:Class;
		
		[Embed(source="sigma/assets/oil.png")]
		public static var OIL:Class;
		*/
		public static const STARTED:String = "resourceLoadStarted";
		public static const COMPLETED:String = "resourceLoadCompleted";
		
		public static const DEFAULTTHEME:String = "rocks";
		
		private static const COLOR_GRAY:String 	= "#999999";		
		public static const COLOR_TEXT_DISABLED:String 	= COLOR_GRAY;
		public static const BUTTON_WIDTH:uint 			= 80;
	
			
		
		
		
		
	}
}