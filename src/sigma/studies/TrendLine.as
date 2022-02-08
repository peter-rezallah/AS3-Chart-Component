package sigma.studies
{
	import mx.collections.ArrayCollection;

	public class TrendLine
	{
		private var _value:Object = new Object();
		private var _chartIndex:int = 0 ;		
		private var _index:int = 0 ;
		private var _duration:String ;		
		private var _name:String = "TrendLine";
		public var chartData:ArrayCollection = new ArrayCollection() ;
		private var _allBaseChartData:Array = [];
		private var _leftBoundary:Number = 0 ;
		private var _rightBoundary:Number = 0;
		
		public function TrendLine(){}
		
		public function contructing( value:Object , duration:String ):void
		{
			_duration = duration ;			
			_value = value ;
			_chartIndex = _value.main.elements.length ;
			
			
			_value.main['elements'][_chartIndex] = [];
			_value.main['elements'][_chartIndex]['colour'] = "#cc0000";
			_value.main['elements'][_chartIndex]['text'] = "Trend";
			_value.main['elements'][_chartIndex]['font-size'] = 10 ;
			_value.main['elements'][_chartIndex]['type']="line";
			_value.main['elements'][_chartIndex]['width'] = 2;			
			_value.main['elements'][_chartIndex].values = []
		}
		
		public function init():void
		{
			_index = 0 ;
			chartData = new ArrayCollection() ;			
			_allBaseChartData = [];			
			_value.main['elements'][_chartIndex].values = [];
			
		}
		
		public function buildChart(allData:Array , point1:Object , point2:Object , arr:Array , leftBoundary:Number , rightBoundary:Number , labels:Array):void
		{
			_allBaseChartData = allData ;
			_leftBoundary = leftBoundary ;
			_rightBoundary = rightBoundary ;
			
			for(var i:int = 0 ; i < _allBaseChartData.length ; i ++ )
			{
				chartData.addItem(null) ;
			}
			
			
			for( var k:int = 0 ; k < arr.length ; k++)
			{
				chartData.setItemAt({"timeStamp":arr[k].label,"value": arr[k].value} , arr[k].index + _leftBoundary );
			}
			
			//chartData.setItemAt({"timeStamp":point2.label,"value":point2.value},point2.index + _leftBoundary ); 
			
			applyScroling(leftBoundary , rightBoundary );
			//xAxisLabels = labels ;
			//trace(_value);
			
		}
		
		public function updateDataAt(allData:Array , index:int):void
		{
			_allBaseChartData = allData ;
			var timeStamp:String = _allBaseChartData[index].timeStamp ;
			chartData.setItemAt(null , index ) ;
			
		}
		
		public function addData(allData:Array , index:int):void
		{
			chartData.addItem(null);
		}
		
		public function applyScroling(start:Number , end:Number):void
		{
			_value['main']['elements'][_chartIndex].values = chartData.source.slice(start , end );
		}
		
		public function getMaxValueAt(index:int):Number
		{
			return (_value.main['elements'][_chartIndex].values[index] == null )? 0 : _value.main['elements'][_chartIndex].values[index].value ;
		}
		
		public function getMinValueAt(index:int):Number
		{
			return (_value.main['elements'][_chartIndex].values[index] == null )? 0 : _value.main['elements'][_chartIndex].values[index].value ;
		}		
		
		public function get drawInNewPane():Boolean{return false}
		public function get staticYAxis():Boolean {return false}
		public function set data(val:Object):void	{	_value = val ;	}
		public function get data():Object{	return _value ;	}	
		public function get lastIndex():int{ return _index }
		public function set lastIndex(val:int):void{ _index = val }
		public function get chartIndex():int{ return _chartIndex }
		public function set chartIndex(val:int):void	{	_chartIndex = val ;	}
		public function set studyName(val:String):void	{	_name = val ;	}
		public function get studyName():String{	return _name ;	}
	}
}