package sigma.studies
{
	import mx.collections.ArrayCollection;

	public class CompareStudy
	{
		private var _value:Object = new Object();
		private var _chartIndex:int = 0 ;
		public var chartData:ArrayCollection = new ArrayCollection() ;
		private var _allBaseChartData:Array = [];
		private var _leftBoundary:Number = 0 ;
		private var _rightBoundary:Number = 0;
		private var _index:int = 0 ;
		private var _duration:String ;	
		private var _name:String ;
		private var _yMin:Number = 0 ;
		private var _yMax:Number = 0 ;
		private var xmlChart:XML;
		private var _sc:ScreenCoords ;
		
		public function CompareStudy()
		{}
		
		public function contructing(value:Object , summary:String , sc:ScreenCoords):void
		{
			_duration = summary ;			
			_value = value ;	
			_sc = sc ;
			
			_chartIndex = value.main['elements'].length ;
			value.main['elements'][_chartIndex] = [];				
			value.main['elements'][_chartIndex]['colour'] = "#" + randomColour();
			value.main['elements'][_chartIndex]['text'] = _name + "(" + _duration + ")" ;
			value.main['elements'][_chartIndex]['font-size'] = 10 ;
			value.main['elements'][_chartIndex]['type']="line-compare";
			value.main['elements'][_chartIndex]['fill']="#343399";
			value.main['elements'][_chartIndex]['fill-alpha']= 0.5;				
			value.main['elements'][_chartIndex].values = [];
		}
		
		public static function randomColour() : String {
			return (Math.random() * uint.MAX_VALUE).toString(16);
		}
		
		
		
		public function init():void
		{
			_index = 0 ;
			chartData = new ArrayCollection() ;			
						
			_value.main['elements'][_chartIndex].values = [];
		}
		
		public function buildChart(allData:String , leftBoundary:Number , rightBoundary:Number , labels:Array):void
		{
			xmlChart = new XML(allData);			
			var valuesList:XMLList = xmlChart.value ;
			
			
			_leftBoundary = leftBoundary ;
			_rightBoundary = rightBoundary ;
			
			for(var i:int = 0 ; i< labels.length ; i++)
			{
				chartData.addItem(null);
			}
			
			var startIndex:int = 0 ;		
			
			for each( var item:XML in valuesList )
			{
				var _percentage:Number ;
				
				for ( var k:int = startIndex ; k < labels.length ; k ++ )
				{
					if( k == 0)
					{
						_percentage = 0 ;
						_yMin = _percentage ;
						_yMax = _percentage ;
						chartData.setItemAt({"timeStamp":item.attribute("TimeStamp"),"value":Number(item.attribute("Close").toString())
							,"percentage":_percentage} , k ) ;
						
					}else{						
						
						_percentage = (( Number(item.attribute("Close").toString()) - chartData[0].value ) 
							/ chartData[0].value );
						
						if(_yMax < _percentage )_yMax = _percentage ;
						if(_yMin > _percentage )_yMin = _percentage ;	
						
						if( Functions.returnLabel( item.attribute("TimeStamp"),_duration) == labels[k] ) 
						{
							chartData.setItemAt({"timeStamp":item.attribute("TimeStamp"),"value":Number(item.attribute("Close").toString()),"percentage":_percentage} , k ) ;
							startIndex = k ;
							break ;
						}					
					
					}					
				}
			}
			
			
			applyScroling(leftBoundary , rightBoundary );
			
			
		}
		
		public function addData(allData:Array , index:int):void
		{
			
		}
		
		public function applyScroling(start:Number , end:Number):void
		{
			_value['main']['elements'][_chartIndex].values = chartData.source.slice(start , end );
		}
		
		public function getMaxValueAt(index:int):Number
		{
			return (_value.main['elements'][_chartIndex].values[index] == null )? 0 : _value.main['elements'][_chartIndex].values[index].percentage ;
		}
		
		public function getMinValueAt(index:int):Number
		{
			return (_value.main['elements'][_chartIndex].values[index] == null )? 0 : _value.main['elements'][_chartIndex].values[index].percentage ;
		}
		
		public function get drawInNewPane():Boolean{return false}
		public function get staticYAxis():Boolean {return false}
		public function set data(val:Object):void	{	_value = val ;	}
		public function get data():Object{	return _value ;	}
		public function get lastIndex():int{ return _index }
		public function set lastIndex(val:int):void{ _index = val }
		public function set studyName(val:String):void	{	_name = val ;	}
		public function get studyName():String{	return _name ;	}
		public function get yMax():Number{ return _yMax }
		public function set yMax(val:Number):void{ _yMax = val }
		public function get yMin():Number{ return _yMin }
		public function set yMin(val:Number):void{ _yMin = val }
		public function get chartIndex():int{return _chartIndex}
		public function set chartIndex(val:int):void{_chartIndex = val}
	}
}