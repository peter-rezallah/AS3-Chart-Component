package sigma.studies
{
	import mx.collections.ArrayCollection;
	import mx.core.FlexGlobals;

	public class ExponentialMovingAverage
	{
		private var _value:Object = new Object();
		private var _chartIndex:int = 0 ;
		private var _period:int = 14 ;
		private var _index:int = 0 ;
		private var _duration:String ;	
		private var _yMin:Number = 0 ;
		private var _yMax:Number = 0 ;
		private var _yMinC:Number = 0 ;
		private var _yMaxC:Number = 0 ;
		private var _name:String = "EMA";
		private var _leftBoundary:Number = 0 ;
		private var _rightBoundary:Number = 0;
		private var _allBaseChartData:Array = [];
		public var chartData:ArrayCollection = new ArrayCollection() ;
		private var _parametrs:Array = [{"label":"Period","value":_period ,"funcName":"period"}] ;
		private var _isCompareOn:Boolean = false ;
		
		public function ExponentialMovingAverage()
		{}
		
		public function contructing( value:Object , duration:String ):void
		{
			_isCompareOn = FlexGlobals.topLevelApplication.isCompare ;
			_duration = duration ;			
			_value = value ;
			_chartIndex = _value.main.elements.length ;
			
			_value.main['elements'][_chartIndex] = [];
			_value.main['elements'][_chartIndex]['colour'] = "#568800";
			_value.main['elements'][_chartIndex]['text'] = _name + "(" + _period + ")";			
			_value.main['elements'][_chartIndex]['font-size'] = 10 ;
			if(!_isCompareOn)_value.main['elements'][_chartIndex]['type']="line";
			else _value.main['elements'][_chartIndex]['type']="line-compare";
			//_value['elements'][0]['negative-colour']= "#d04040";
			/* _value.main['elements'][_chartIndex]['tip']= "#value#"; */
			_value.main['elements'][_chartIndex].values = [];
		}
		
		public function init():void
		{
			_index = 0 ;
			chartData = new ArrayCollection([new ArrayCollection(),new ArrayCollection(),new ArrayCollection()]) ;
			_allBaseChartData = [];			
			_value.main['elements'][_chartIndex].values = [];
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
			
			if(_isCompareOn)
			{
				_value.main['y_axis'].min = ( _yMinC < _value.main['y_axis'].min )? _yMinC : _value.main['y_axis'].min ;
				_value.main['y_axis'].max = ( _yMaxC > _value.main['y_axis'].max )? _yMaxC : _value.main['y_axis'].max ;
				
			}else{
				
				_value.main['y_axis'].min = ( _yMin < _value.main['y_axis'].min )? _yMin : _value.main['y_axis'].min ;
				_value.main['y_axis'].max = ( _yMax > _value.main['y_axis'].max )? _yMax : _value.main['y_axis'].max ;
			}
			
			applyScroling(leftBoundary , rightBoundary );
			//xAxisLabels = labels ;
			//trace(_value);
			
		}
		
		public function addData(allData:Array , index:int):void
		{
			_index = index ;
			_allBaseChartData = allData ;
			var timeStamp:String = _allBaseChartData[index].timeStamp ;
			
			if(_index >= _period - 1 )
			{
				var val:Number = 0;
				var val_p:Number = 0 ;
				
				if( _index == _period - 1)
				{
					val = Functions.getSmaValue(index - (_period-1), _allBaseChartData ,  _period);
					val_p = Functions.getSmaValue(index - (_period-1), _allBaseChartData ,  _period , "percentage" );
				}else{					
					val = Functions.getEmaValue(index , _allBaseChartData , chartData.source , _period );
					val_p = Functions.getEmaValue(index , _allBaseChartData , chartData.source , _period ,"percentage" );
					
				}
				/*_value.main['elements'][_chartIndex].values.push({"timeStamp":timeStamp,"value":val});*/
				chartData.addItem({"timeStamp":timeStamp,"value":val,"percentage":val_p});
				
				if( _index == _period - 1 )
				{
					_yMax = _yMin = val ;
					_yMaxC = _yMinC = val_p ;
					
				}else{
					
					_yMax = ( _yMax > val ) ? _yMax : val ;
					_yMin = ( _yMin < val ) ? _yMin : val ;	
					
					_yMaxC = ( _yMaxC > val_p ) ? _yMaxC : val_p ;
					_yMinC = ( _yMinC < val_p ) ? _yMinC : val_p ;	
				}
				
			}else{				
				/*_value.main['elements'][_chartIndex].values.push(null);*/
				chartData.addItem(null);
			}
		}
		
		public function updateDataAt(allData:Array , index:int):void
		{
			_allBaseChartData = allData ;
			var timeStamp:String = _allBaseChartData[index].timeStamp ;
			
			if(_index >= _period - 1 )
			{	
				var val:Number = 0;
				var val_p:Number = 0 ;
				if( _index == _period - 1)
				{
					val = Functions.getSmaValue((index) - (_period-1), _allBaseChartData , _period);
					val_p = Functions.getSmaValue(index - (_period-1), _allBaseChartData ,  _period , "percentage" );
					 
				}else{
					
					val = Functions.getEmaValue((index) , _allBaseChartData , chartData.source , _period );
					val_p = Functions.getEmaValue(index , _allBaseChartData , chartData.source , _period ,"percentage" );
					
					
				}
				/*_value.main['elements'][_chartIndex].values[index] = {"timeStamp":data['TimeStamp1'],"value":val} ;*/
				chartData.setItemAt({"timeStamp":data['TimeStamp1'],"value":val,"percentage":val_p} , index );
				
				if( _index == _period - 1 )
				{
					_yMax = _yMin = val ;
					_yMaxC = _yMinC = val_p ;
					
				}else{
					
					_yMax = ( _yMax > val ) ? _yMax : val ;
					_yMin = ( _yMin < val ) ? _yMin : val ;
					
					_yMaxC = ( _yMaxC > val_p ) ? _yMaxC : val_p ;
					_yMinC = ( _yMinC < val_p ) ? _yMinC : val_p ;
					
					
				}
				
			}else{
				
				/*_value.main['elements'][_chartIndex].values.push(null);*/
				chartData.setItemAt(null , index );
			}
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
		public function set period(val:int):void	{	_period = val ;	}
		public function get period():int{	return _period ;	}
		public function get lastIndex():int{ return _index }
		public function set lastIndex(val:int):void{ _index = val }
		public function get chartIndex():int{ return _chartIndex }
		public function set chartIndex(val:int):void{_chartIndex = val ;}
		public function get yMax():Number{ return _yMax }
		public function set yMax(val:Number):void{ _yMax = val }
		public function get yMin():Number{ return _yMin }
		public function set yMin(val:Number):void{ _yMin = val }
		public function get yMaxC():Number{ return _yMaxC }
		public function set yMaxC(val:Number):void{ _yMaxC = val }
		public function get yMinC():Number{ return _yMinC }
		public function set yMinC(val:Number):void{ _yMinC = val }		
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