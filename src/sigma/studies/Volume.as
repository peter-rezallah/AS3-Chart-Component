package sigma.studies
{
	import mx.collections.ArrayCollection;
	import mx.core.UIComponent;	
	
	public class Volume extends Pane
	{
		
		private var _value:Object = new Object();
		private var _duration:String ;
		private var _yMin:Number = 0 ;
		private var _yMax:Number = 0 ;
		private var _index:int = 0 ;
		private var _newPane:Boolean = true ;
		private var _name:String = "Volume";
		public var chartData:ArrayCollection = new ArrayCollection();
		private var _allBaseChartData:Array = [];
		private var _leftBoundary:Number = 0 ;
		private var _rightBoundary:Number = 0;
		private var _parametrs:Array = null ;
		
		
		
		public function Volume()
		{}
		
		public function contructing( value:Object ,  duration:String , container:UIComponent ):void
		{
			_duration = duration ;
			_value = value ;
			_value.Volume = new Object();				
			_value.Volume['bg_colour'] = "#ffffff";
			_value.Volume['elements'] = [];
			_value.Volume['elements'][0] = [];
			_value.Volume['elements'][0]['colour'] = "#736AFF";
			_value.Volume['elements'][0]['text'] = _name ;
			_value.Volume['elements'][0]['font-size'] = 10 ;
			_value.Volume['elements'][0]['type']="bar";
			_value.Volume['elements'][0]['fill']="#343399";
			_value.Volume['elements'][0]['fill-alpha']= 0.5;
			//_value['elements'][0]['negative-colour']= "#d04040";
			//_value.Volume['elements'][0]['tip']= "Volume:<br>#val#<br>Key: #key#<br>Label:#x_label#<br>Legend:#x_legend#";
			_value.Volume['elements'][0].values = [];
			_value.Volume['title'] = [];
			_value.Volume['title'].style = ["text-align: left"];
			//_value.Volume['title'].text = " Volume CHART ";
			_value.Volume['y_axis'] = [];
			_value.Volume['y_axis']['stroke'] = 1;
			_value.Volume['y_axis']['grid-colour'] = "#dddddd";
			_value.Volume['y_axis']['colour'] = "#c6d9fd";				
			_value.Volume['x_axis'] = [];
			_value.Volume['x_axis']['steps'] = 30 ;				
			_value.Volume['x_axis']['offset'] = true ;
			_value.Volume['x_axis']['stroke'] = 1;
			_value.Volume['x_axis']['colour'] = "#c6d9fd";
			_value.Volume['x_axis']['grid-colour'] = '#dddddd';
			_value.Volume['x_axis'].labels = [];
			//_value['x_axis'].min = "10:30";
			//_value['x_axis'].max = "14:30";
			_value.Volume['x_axis']['labels']['visible-steps'] = 50 ;
			_value.Volume['x_axis']['labels'].labels = [];
			
			values = _value.Volume ;
			width = 950 ;
			height = 100 ;
			container.addChild(this);
		}
		
		public function sendMouseXY(x:Number , y:Number ):void
		{
			sendMouseXYToPane(x , y);
		}
		
		public function init():void
		{
			_index = 0 ;
			_yMax = 0;
			_yMin = 0;
			_allBaseChartData = [];
			
			chartData = new ArrayCollection();
			_value.Volume['elements'][0].values = [];
			_value.Volume['x_axis']['labels'].labels = [];
		}
		
		public function buildChart(allData:Array , leftBoundary:Number , rightBoundary:Number , labels:Array):void
		{
			
			_allBaseChartData = allData ;
			_leftBoundary = leftBoundary ;
			_rightBoundary = rightBoundary ;
			
			for(var i:int = 0 ; i< _allBaseChartData.length ; i++)
			{
				//var val:Object = allData[i];
				addData(_allBaseChartData , i );				
				
			}
			
			applyScroling(leftBoundary , rightBoundary );
			xAxisLabels = labels ;					
			
		}
		
		public function drawChart():void
		{
			setYaxisRange();			
			build_chart(_value.Volume);
		}
		
		public function addData(allData:Array , index:int):void
		{
			_index = index ;
			_allBaseChartData = allData ;
			
			/*_value.Volume['elements'][0].values.push(_allBaseChartData[index].volume );
			_value.Volume['x_axis'].labels.labels.push(Functions.returnLabel(timeStamp,_duration));*/
			chartData.addItem(_allBaseChartData[index].volume);	
			
			if( _index == 0 )
			{
				_yMin = Number(_allBaseChartData[index].volume );
				_yMax = Number(_allBaseChartData[index].volume );
			}else{
				
				if(_index < _rightBoundary && _index > _leftBoundary )
				{
					_yMax = (_yMax < Number(_allBaseChartData[index].volume ))?Number(_allBaseChartData[index].volume ):_yMax  ;
					_yMin = (_yMin > Number(_allBaseChartData[index].volume ))?Number(_allBaseChartData[index].volume ):_yMin  ;
				}
				
										
				
			}
					
			
		}		
		
		
		public function updateDataAt(allData:Array , index:int):void
		{
			_allBaseChartData = allData ;
			/*_value.Volume['elements'][0].values[index] = Number(data['Volume1']) ;
			_value.Volume['x_axis'].labels.labels[index] = data['TimeStamp1'] ;*/
			chartData.setItemAt(Number(_allBaseChartData[index].volume),index);
		}
		
		public function applyScroling(start:Number , end:Number):void
		{
			_value['Volume']['elements'][0].values = chartData.source.slice(start , end );
		}
		
		public function setYaxisRange():void
		{
			_value.Volume['y_axis'].min = _yMin ;
			_value.Volume['y_axis'].max = _yMax ;
			_value.Volume['y_axis'].steps = Functions.get_steps(_yMin,_yMax,100); 
		}
		
		public function get chartObject():Object
		{
			return _value.Volume ;
		}
		
		public function getMaxValueAt(index:int):Number
		{
			return ( _value.Volume['elements'][0].values[index] == null )? 0 : _value.Volume['elements'][0].values[index] ;
		}
		
		public function getMinValueAt(index:int):Number
		{
			return ( _value.Volume['elements'][0].values[index] == null )? 0 : _value.Volume['elements'][0].values[index] ;
		}
		
		public function set xAxisLabels(val:Array):void
		{
			_value.Volume['x_axis'].labels.labels = val ; 
			drawChart(); 
		}
		
		public function get drawInNewPane():Boolean{return true}
		public function get staticYAxis():Boolean {return false}
		public function set data(val:Object):void	{	_value = val ;	}
		public function get data():Object{	return _value ;	}
		public function set yMin(val:Number):void	{	_yMin = val ;	}
		public function get yMin():Number{	return _yMin ;	}
		public function set yMax(val:Number):void	{	_yMax = val ;	}
		public function get yMax():Number{	return _yMax ;	}
		public function get dataLength():int{ return chartData.length - 1}
		public function set studyName(val:String):void	{	_name = val ;	}
		public function get studyName():String{	return _name ;	}
		public function set newPane(val:Boolean):void	{	_newPane = val ;	}
		public function get newPane():Boolean{	return _newPane ;	}
		public function get lastIndex():int{ return _index }
		public function set lastIndex(val:int):void{ _index = val }
		public function set leftBoundary(val:Number):void{_leftBoundary = val}
		public function set rightBoundary(val:Number):void{_rightBoundary = val}
		public function get studyParametrs():Array
		{
			return _parametrs ;
		}
		
		public function set studyParametrs(val:Array):void
		{
			//_parametrs = val ;
			
			var index:int = 0 ;
			
			for each ( var item:Object in val )
			{
				if ( item.label == _parametrs[index].label )
				{
					_parametrs[index].value = item.value ;
					this[_parametrs[index].funcName] = item.value ;
					index++ ;
				}
			}
		}
	}
}