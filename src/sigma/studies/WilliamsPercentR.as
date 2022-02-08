package sigma.studies
{
	import mx.collections.ArrayCollection;
	import mx.core.UIComponent;
	import mx.formatters.DateFormatter;
	import mx.messaging.messages.ErrorMessage;

	public class WilliamsPercentR extends Pane
	{		
		private var _value:Object = new Object();
		private var _period:int = 10 ;
		private var _index:int = 0 ;
		private var _duration:String ;
		public var chartData:ArrayCollection = new ArrayCollection([new ArrayCollection(),
																	new ArrayCollection(),
																	new ArrayCollection()]) ;
		private var _name:String = "WilliamsPercentR";
		private var _allBaseChartData:Array = [];
		private var _leftBoundary:Number = 0 ;
		private var _rightBoundary:Number = 0;
		private var _parametrs:Array = [{"label":"Period","value":_period ,"funcName":"period"}] ;
		
		public function WilliamsPercentR()
		{}
		
		public function contructing( value:Object ,  duration:String , container:UIComponent ):void
		{
			// WPR chart ...
			_duration = duration ;
			_value = value ;
			_value.WilliamsPercentR = new Object();	
			_value.WilliamsPercentR['title'] = [];
			_value.WilliamsPercentR['title'].style = "text-align: left";
			_value.WilliamsPercentR['bg_colour'] = "#ffffff";
			_value.WilliamsPercentR['elements'] = [];
			
			_value.WilliamsPercentR['elements'][0] = [];
			_value.WilliamsPercentR['elements'][0]['colour'] = "#ee0000";
			_value.WilliamsPercentR['elements'][0]['text'] = "WPR"+"("+_period+")";
			_value.WilliamsPercentR['elements'][0]['font-size'] = 10 ;
			/*_value.WilliamsPercentR['elements'][0]['width'] = 0.5 ;*/
			_value.WilliamsPercentR['elements'][0]['type']="line";
			_value.WilliamsPercentR['elements'][0]['fill']="#343399";
			_value.WilliamsPercentR['elements'][0]['fill-alpha']= 0.5;			
			_value.WilliamsPercentR['elements'][0].values = [];
			
			_value.WilliamsPercentR['elements'][1] = [];
			_value.WilliamsPercentR['elements'][1]['colour'] = "#ffcc00";				
			_value.WilliamsPercentR['elements'][1]['font-size'] = 10 ;
			_value.WilliamsPercentR['elements'][1]['width'] = 0.5 ;
			_value.WilliamsPercentR['elements'][1]['type']="line";
			_value.WilliamsPercentR['elements'][1]['fill']="#117054";
			_value.WilliamsPercentR['elements'][1]['fill-alpha']= 0.5;
			//_value.WilliamsPercentR['elements'][0]['negative-colour']= "#d04040";		
			_value.WilliamsPercentR['elements'][1].values = [];
			
			_value.WilliamsPercentR['elements'][2] = [];
			_value.WilliamsPercentR['elements'][2]['colour'] = "#ffcc00";				
			_value.WilliamsPercentR['elements'][2]['font-size'] = 10 ;
			_value.WilliamsPercentR['elements'][2]['type']="line";
			_value.WilliamsPercentR['elements'][2]['width'] = 0.5 ;
			_value.WilliamsPercentR['elements'][2]['fill']="#117054";
			_value.WilliamsPercentR['elements'][2]['fill-alpha']= 0.5;
			//_value.WilliamsPercentR['elements'][2]['negative-colour']= "#d04040";				
			_value.WilliamsPercentR['elements'][2].values = [];
			
			
			
			//_value.WilliamsPercentR['title'].text = " VOLUME CHART ";
			_value.WilliamsPercentR['y_axis'] = [];
			_value.WilliamsPercentR['y_axis']['stroke'] = 1;
			_value.WilliamsPercentR['y_axis']['grid-colour'] = "#dddddd";
			_value.WilliamsPercentR['y_axis']['colour'] = "#c6d9fd";				
			_value.WilliamsPercentR['x_axis'] = [];
			_value.WilliamsPercentR['x_axis']['steps'] = 30 ;				
			_value.WilliamsPercentR['x_axis']['offset'] = true ;
			_value.WilliamsPercentR['x_axis']['stroke'] = 1;
			_value.WilliamsPercentR['x_axis']['colour'] = "#c6d9fd";
			_value.WilliamsPercentR['x_axis']['grid-colour'] = '#dddddd';
			_value.WilliamsPercentR['x_axis'].labels = [];
			//_value.WilliamsPercentR['x_axis'].min = "10:30";
			//_value.WilliamsPercentR['x_axis'].max = "14:30";
			_value.WilliamsPercentR['x_axis']['labels']['visible-steps'] = 50 ;
			_value.WilliamsPercentR['x_axis']['labels'].labels = [];
			
			_value.WilliamsPercentR['y_axis'].min = -100 ;
			_value.WilliamsPercentR['y_axis'].max = 0 ;			
			_value.WilliamsPercentR['y_axis'].steps = 10;	
			
			values = _value.WilliamsPercentR ;
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
			_allBaseChartData = [];			
			chartData = new ArrayCollection([new ArrayCollection(),
				new ArrayCollection(),
				new ArrayCollection()]);
			_value.WilliamsPercentR['elements'][0].values = [];
			_value.WilliamsPercentR['elements'][1].values = [];
			_value.WilliamsPercentR['elements'][2].values = [];
			_value.WilliamsPercentR['x_axis']['labels'].labels = [];
		}
		
		public function buildChart(allData:Array , leftBoundary:Number , rightBoundary:Number , labels:Array):void
		{
			_allBaseChartData = allData ;
			_leftBoundary = leftBoundary ;
			_rightBoundary = rightBoundary ;
			
			for(var i:int = 0 ; i< _allBaseChartData.length ; i++)
			{
				addData(_allBaseChartData , i );
			}
			
			applyScroling(leftBoundary , rightBoundary );
			xAxisLabels = labels ;		
			
		}	
		
		public function removedStudyFrom(container:UIComponent):void
		{
			this.die() ;
			container.removeChild(this);
		}
		
		public function drawChart():void
		{
									
			build_chart(_value.WilliamsPercentR);
		}
		
		
		public function addData(allData:Array , index:int):void
		{
			//_allBaseChartData = allData ;
			var timeStamp:String = allData[index].timeStamp ;
			var val:* ;
			
			if( index >= _period - 1 )
			{
				/*trace("timeStamp=" + returnLabel(timeStamp) , " value = " +  getWprValue(index - (_period - 1)) + " index="+index+" , _index= " + _index );*/
				val = getWprValue(index - (_period - 1) , allData) ;
				chartData[0].addItem({"timeStamp":timeStamp,"value":val});
				
			}else{
				
				val = null ;
				chartData[0].addItem(val);
				
			}
			
			/*_value.WilliamsPercentR['elements'][0].values.push({"timeStamp":timeStamp,"value":val});
			_value.WilliamsPercentR['elements'][1].values.push({"timeStamp":timeStamp,'value':-20});
			_value.WilliamsPercentR['elements'][2].values.push({"timeStamp":timeStamp,'value':-80});
			_value.WilliamsPercentR['x_axis'].labels.labels.push(returnLabel(timeStamp));*/
			
			
			chartData[1].addItem({"timeStamp":timeStamp,'value':-80});
			chartData[2].addItem({"timeStamp":timeStamp,'value':-20});
			
		}
		
		public function updateDataAt(allData:Array , index:int):void
		{
			var val:* ;
			var timeStamp:String = allData[index].timeStamp ;
			
			if( _index >= _period - 1 )
			{
				val = getWprValue((index) - (_period -1) , allData );
			}else{
			
				val = null;
			
			}
			/*_value.WilliamsPercentR['elements'][0].values[index] = {"timeStamp":data["TimeStamp1"],"value":val};
			_value.WilliamsPercentR['elements'][1].values[index] = {"timeStamp":data["TimeStamp1"],'value':-20};
			_value.WilliamsPercentR['elements'][2].values[index] ={"timeStamp":data["TimeStamp1"],'value':-80};
			_value.WilliamsPercentR['x_axis'].labels.labels[index] = returnLabel(data["TimeStamp1"]);*/
			
			chartData[0].setItemAt({"timeStamp":timeStamp,"value":val},index);			
			chartData[1].setItemAt({"timeStamp":timeStamp,'value':-80},index);
			chartData[2].setItemAt({"timeStamp":timeStamp,'value':-20},index);
			
		}
		
		public function getWprValue(startIndex:int , allData:Array ):Number
		{
			_allBaseChartData = allData ;
			
			var highestHigh:Number = _allBaseChartData[startIndex].high ;
			var lowestLow:Number = _allBaseChartData[startIndex].low ;
			var wprValue:Number = 0 ;
			
			_index = startIndex + ( _period - 1 ) ;
			
			for ( var i:int= startIndex+1 ; i < _period + startIndex ; i++)
			{
				if( highestHigh < _allBaseChartData[i].high ) highestHigh = _allBaseChartData[i].high ;
				if( lowestLow > _allBaseChartData[i].low ) lowestLow = _allBaseChartData[i].low ;
			}
			
			
			if(highestHigh - lowestLow == 0 )
			{
				wprValue = -50 ;
			}else{
				
				wprValue = ((highestHigh - _allBaseChartData[startIndex + ( _period - 1 )].value ) / (highestHigh - lowestLow )) * -100 ;
			}
			
			
			/* trace("wprValue="+wprValue); */
			/* if(!wprValue )wprValue = -50 ; */
			return wprValue ;
		}
		
		public function applyScroling(start:Number , end:Number):void
		{
			_value['WilliamsPercentR']['elements'][2].values = chartData[2].source.slice(start , end );
			_value['WilliamsPercentR']['elements'][1].values = chartData[1].source.slice(start , end );
			_value['WilliamsPercentR']['elements'][0].values = chartData[0].source.slice(start , end );
		}		
		
		public function set xAxisLabels(val:Array):void
		{
			_value.WilliamsPercentR['x_axis'].labels.labels = val ; 
			drawChart(); 
		}
		
		public function getMaxValueAt(index:int):Number
		{
			return (_value.WilliamsPercentR['elements'][0].values[index] == null )? 0 : _value.WilliamsPercentR['elements'][0].values[index].value ;
		}
		
		public function getMinValueAt(index:int):Number
		{
			return (_value.WilliamsPercentR['elements'][0].values[index] == null )? 0 : _value.WilliamsPercentR['elements'][0].values[index].value ;
		}
		
		public function get drawInNewPane():Boolean{return true}
		public function get staticYAxis():Boolean {return true}
		public function set data(val:Object):void	{	_value = val ;	}
		public function get data():Object{	return _value ;	}		
		public function set period(val:int):void	{	_period = val ;	}
		public function get period():int{	return _period ;	}
		public function get lastIndex():int{ return _index }
		public function set lastIndex(val:int):void{ _index = val }
		public function set studyName(val:String):void	{	_name = val ;	}
		public function get studyName():String{	return _name ;	}
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