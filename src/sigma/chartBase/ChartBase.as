package sigma.chartBase
{
	import mx.collections.ArrayCollection;
	import mx.core.UIComponent;
	
	import sigma.studies.Functions;

	public class ChartBase extends Chart
	{
		private var _value:Object = new Object();
		private var _index:int = 0 ;
		private var _duration:String ;
		private var _reuter:String ;
		private var _yMin:Number = 0 ;
		private var _yMax:Number = 0 ;
		[Bindable]
		public var chartData:ArrayCollection = new ArrayCollection() ;
		
		public function initializeClass(value:Object , duration:String , reuter:String ):void
		{
			//super.initialize();
			_value = value ;
			_duration = duration ;
			_reuter = reuter ;
			
			_value.main = new Object();
			_value.main['title'] = [];
			_value.main['title'].text = " MAIN Chart ";
			_value.main['y_axis'] = [];
			_value.main['y_axis']['stroke'] = 1;
			_value.main['y_axis']['grid-colour'] = "#dddddd";
			_value.main['y_axis']['colour'] = "#c6d9fd";
			_value.main['bg_colour'] = "#ffffff";
			_value.main['elements'] = [];
			_value.main['elements'][0] = [];
			_value.main['elements'][0]['colour'] = "#736AFF";
			_value.main['elements'][0]['text'] = _reuter ;
			_value.main['elements'][0]['font-size'] = 10 ;
			_value.main['elements'][0]['type']="area";
			_value.main['elements'][0]['fill']="#343399";
			_value.main['elements'][0]['fill-alpha']= 0.5;
			//_value['elements'][0]['negative-colour']= "#d04040";
			_value.main['elements'][0]['tip']= "Label:#x_label#<br>open:#open#<br>high:#high#<br>low:#low#<br>close:#value#";
			_value.main['elements'][0].values = [];
			
			
			_value.main['x_axis'] = [];
			_value.main['x_axis']['steps'] = 30 ;
			
			_value.main['x_axis']['offset'] = true ;
			_value.main['x_axis']['stroke'] = 1;
			_value.main['x_axis']['colour'] = "#c6d9fd";
			_value.main['x_axis']['grid-colour'] = '#dddddd';
			_value.main['x_axis'].labels = [];
			//_value['x_axis'].min = "10:30";
			//_value['x_axis'].max = "14:30";
			_value.main['x_axis']['labels']['visible-steps'] = 50 ;
			_value.main['x_axis']['labels'].labels = [];
		}
		
		public function ChartBase()
		{
			//super();			
			
			
		}
		
		public function addRecord(obj:Object , index:int):void
		{
			_index = index ;
			
			if( _index == 0)
			{
				yMin = Number(obj["Low"]);
				yMax = Number(obj["High"]);	
				
				
			}else{
				
				if(yMax < Number(obj["High"]))yMax = Number(obj["High"]) ;
				if(yMin > Number(obj["Low"]))yMin = Number(obj["Low"]) ;										
				
			}					
			
			/*_value.main['elements'][0].values.push({"timeStamp":obj["TimeStamp"],"value":Number(obj["Close"].toString()),"top":Number(obj["Open"].toString()),"high":Number(obj["High"].toString()),"low":Number(obj["Low"].toString()),"volume":Number(obj["Volume"].toString())});*/
			chartData.addItem({"timeStamp":obj["TimeStamp"],"value":Number(obj["Close"].toString()),"top":Number(obj["Open"].toString()),"high":Number(obj["High"].toString()),"low":Number(obj["Low"].toString()),"volume":Number(obj["Volume"].toString())});
			/*_value.main['x_axis'].labels.labels.push(Functions.returnLabel(obj["TimeStamp"] , _duration ));*/
			/*dateM.text = Functions.returnDateDay(_valueElement.attribute("TimeStamp"));*/
		}
		
		public function updateRecordAt(allData:Array , index:int):void
		{
			
		}
		
		public function setYaxisRange():void
		{
			_value.main['y_axis'].min = _yMin ;
			_value.main['y_axis'].max = _yMax ;
			_value.main['y_axis'].steps = Functions.get_steps(_yMin,_yMax,this.height);
		}
		
		public function set data(val:Object):void	{	_value = val ;	}
		public function get data():Object{	return _value ;	}
		public function get lastIndex():int{ return _index }
		public function set lastIndex(val:int):void{ _index = val }
		public function set yMin(val:Number):void	{	_yMin = val ;	}
		public function get yMin():Number{	return _yMin ;	}
		public function set yMax(val:Number):void	{	_yMax = val ;	}
		public function get yMax():Number{	return _yMax ;	}		
	}
}