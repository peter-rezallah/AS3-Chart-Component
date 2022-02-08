package sigma.studies
{
	import mx.collections.ArrayCollection;
	import mx.core.FlexGlobals;

	public class BollingerBands
	{
		private var _value:Object = new Object();
		private var _chartIndex:int = 0 ;
		private var _period:int = 20 ;
		private var _deviations:int = 2 ;
		private var _yMin:Number = 0 ;
		private var _yMax:Number = 0 ;
		private var _yMinC:Number = 0 ;
		private var _yMaxC:Number = 0 ;
		private var _index:int = 0 ;
		private var _duration:String ;	
		private var _name:String = "BB";
		private var _leftBoundary:Number = 0 ;
		private var _rightBoundary:Number = 0;
		private var _allBaseChartData:Array = [];
		public var chartData:ArrayCollection = new ArrayCollection([new ArrayCollection(),new ArrayCollection(),new ArrayCollection()]) ;
		private var _parametrs:Array = [{"label":"Period","value":_period ,"funcName":"period"},
			{"label":"Deviations","value":_deviations ,"funcName":"deviations"}] ;
		private var _isCompareOn:Boolean = false ;
		
		public function BollingerBands()
		{}
		
		public function contructing( value:Object , duration:String ):void
		{
			_isCompareOn = FlexGlobals.topLevelApplication.isCompare ;
			_duration = duration ;			
			_value = value ;
			_chartIndex = _value.main.elements.length ;
			
			_value.main['elements'][_chartIndex] = [];
			_value.main['elements'][_chartIndex]['colour'] = "#562096";
			_value.main['elements'][_chartIndex]['text'] = _name + "U";
			/*_value.main['elements'][1]['text'] = CODE+"-Bollinger Band Up";*/
			_value.main['elements'][_chartIndex]['font-size'] = 10 ;
			if(!_isCompareOn)_value.main['elements'][_chartIndex]['type']="line";
			else _value.main['elements'][_chartIndex]['type']="line-compare";
			//_value['elements'][0]['negative-colour']= "#d04040";
			/* _value.main['elements'][2]['tip']= "#value#"; */
			_value.main['elements'][_chartIndex].values = [];
			
			_value.main['elements'][_chartIndex + 1] = [];
			_value.main['elements'][_chartIndex + 1]['colour'] = "#60ff96";
			_value.main['elements'][_chartIndex + 1]['text'] = _name + "SMA";
			/*_value.main['elements'][2]['text'] = CODE+"-Bollinger Band SMA";*/
			_value.main['elements'][_chartIndex + 1]['font-size'] = 10 ;
			if(!_isCompareOn)_value.main['elements'][_chartIndex + 1]['type']="line";	
			else _value.main['elements'][_chartIndex + 1]['type']="line-compare";
			//_value['elements'][0]['negative-colour']= "#d04040";
			/* _value.main['elements'][2]['tip']= "#value#"; */
			_value.main['elements'][_chartIndex + 1].values = [];
			
			
			_value.main['elements'][_chartIndex + 2] = [];
			_value.main['elements'][_chartIndex + 2]['colour'] = "#562096";
			_value.main['elements'][_chartIndex + 2]['text'] = _name + "L";
			/*_value.main['elements'][3]['text'] = CODE+"-Bollinger Band Low";*/
			_value.main['elements'][_chartIndex + 2]['font-size'] = 10 ;
			if(!_isCompareOn)_value.main['elements'][_chartIndex + 2]['type']="line";
			else _value.main['elements'][_chartIndex + 2]['type']="line-compare";
			//_value['elements'][0]['negative-colour']= "#d04040";
			/* _value.main['elements'][2]['tip']= "#value#"; */
			_value.main['elements'][_chartIndex + 2].values = [];
		}
		
		public function init():void
		{
			_index = 0 ;
			chartData = new ArrayCollection([new ArrayCollection(),new ArrayCollection(),new ArrayCollection()]) ;
			_allBaseChartData = [];			
			_value.main['elements'][_chartIndex].values = [];
			_value.main['elements'][_chartIndex + 1].values = [];
			_value.main['elements'][_chartIndex + 2].values = [];
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
			
			if( _index >= _period - 1 )
			{
				var periodStandardDeviation:Number = getStandarDeviation(index - (_period - 1) , _allBaseChartData );
				var periodStandardDeviation_p:Number = getStandarDeviation(index - (_period - 1) , _allBaseChartData , "percentage" );
				var val_sma:Number = Functions.getSmaValue(index - (_period - 1), _allBaseChartData ,  _period ) ;
				var val_sma_p:Number = Functions.getSmaValue(index - (_period - 1), _allBaseChartData ,  _period , "percentage" ) ;
				var val_up:Number = Functions.getSmaValue(index - (_period - 1), _allBaseChartData ,  _period ) + (_deviations * periodStandardDeviation);
				var val_up_p:Number = Functions.getSmaValue(index - (_period - 1), _allBaseChartData ,  _period , "percentage" ) + (_deviations * periodStandardDeviation_p);
				var val_low:Number = Functions.getSmaValue(index - (_period - 1), _allBaseChartData ,  _period ) - (_deviations * periodStandardDeviation);
				var val_low_p:Number = Functions.getSmaValue(index - (_period - 1), _allBaseChartData ,  _period ,"percentage" ) - (_deviations * periodStandardDeviation_p);
				
				/*_value.main['elements'][_chartIndex + 1].values.push({"timeStamp":timeStamp,"value":val_sma});
				_value.main['elements'][_chartIndex].values.push({"timeStamp":timeStamp,"value":val_up});
				_value.main['elements'][_chartIndex + 2].values.push({"timeStamp":timeStamp,"value":val_low});*/
				
				chartData[1].addItem({"timeStamp":timeStamp,"value":val_sma,"percentage":val_sma_p});
				chartData[0].addItem({"timeStamp":timeStamp,"value":val_up,"percentage":val_up_p});
				chartData[2].addItem({"timeStamp":timeStamp,"value":val_low,"percentage":val_low_p});
				
				if( _index == _period - 1 )
				{
					_yMin = val_low ;
					_yMax = val_up ;
					
					_yMinC = val_low_p ;
					_yMaxC = val_up_p ;
					
				}else{
					
					_yMin = (val_low < _yMin )? val_low : _yMin ;
					_yMax = (val_up > _yMax )? val_up : _yMax ;
					
					_yMinC = (val_low_p < _yMinC )? val_low_p : _yMinC ;
					_yMaxC = (val_up_p > _yMaxC )? val_up_p : _yMaxC
						
						
				}
				
			}else{
				
				/*_value.main['elements'][_chartIndex].values.push(null);
				_value.main['elements'][_chartIndex + 1].values.push(null);
				_value.main['elements'][_chartIndex + 2].values.push(null);*/
				
				chartData[1].addItem(null);
				chartData[0].addItem(null);
				chartData[2].addItem(null);
			}
		}
		
		public function updateDataAt(allData:Array , index:int):void
		{
			_allBaseChartData = allData ;
			var timeStamp:String = _allBaseChartData[index].timeStamp ;
			
			if(_index >= _period - 1 )
			{
				var periodStandardDeviation:Number = getStandarDeviation((index) - (_period - 1),_allBaseChartData);
				var val_sma:Number = Functions.getSmaValue((index) - (_period - 1) , _allBaseChartData , _period );
				var val_up:Number = Functions.getSmaValue((index) - (_period - 1), _allBaseChartData , _period ) + (_deviations * periodStandardDeviation);
				var val_low:Number = Functions.getSmaValue((index) - (_period - 1), _allBaseChartData , _period ) - (_deviations * periodStandardDeviation);
				
				var periodStandardDeviation_p:Number = getStandarDeviation((index) - (_period - 1),_allBaseChartData , "percentage");
				var val_sma_p:Number = Functions.getSmaValue((index) - (_period - 1) , _allBaseChartData , _period , "percentage" );
				var val_up_p:Number = Functions.getSmaValue((index) - (_period - 1), _allBaseChartData , _period , "percentage" ) + (_deviations * periodStandardDeviation_p);
				var val_low_p:Number = Functions.getSmaValue((index) - (_period - 1), _allBaseChartData , _period , "percentage" ) - (_deviations * periodStandardDeviation_p);
				
				
				/*_value.main['elements'][_chartIndex + 1].values[index] = {"timeStamp":data['TimeStamp1'],"value":val_sma};
				_value.main['elements'][_chartIndex].values[index] = {"timeStamp":data['TimeStamp1'],"value":val_up};
				_value.main['elements'][_chartIndex + 2].values[index] = {"timeStamp":data['TimeStamp1'],"value":val_low};*/
				
				chartData[1].setItemAt({"timeStamp":data['TimeStamp1'],"value":val_sma , "percentage":val_sma_p} , index);
				chartData[0].setItemAt({"timeStamp":data['TimeStamp1'],"value":val_up , "percentage":val_up_p} , index);
				chartData[2].setItemAt({"timeStamp":data['TimeStamp1'],"value":val_low , "percentage":val_low_p} , index);
				
				if( _index == _period - 1 )
				{
					_yMin = val_low ;
					_yMax = val_up ;
					
					_yMinC = val_low_p ;
					_yMaxC = val_up_p ;
					
				}else{
					
					_yMin = (val_low < _yMin )? val_low : _yMin ;
					_yMax = (val_up > _yMax )? val_up : _yMax ;
					
					_yMinC = (val_low_p < _yMinC )? val_low_p : _yMinC ;
					_yMaxC = (val_up_p > _yMaxC )? val_up_p : _yMaxC ;
				}
				
			}else{
				
				/*_value.main['elements'][_chartIndex].values.push(null);
				_value.main['elements'][_chartIndex + 1].values.push(null);
				_value.main['elements'][_chartIndex + 2].values.push(null);*/
				
				chartData[1].setItemAt( null , index);
				chartData[0].setItemAt( null , index);
				chartData[2].setItemAt( null , index);
			}
		}
		
		public function applyScroling(start:Number , end:Number):void
		{
			_value.main['elements'][_chartIndex].values = chartData[0].source.slice( start , end ) ;
			_value.main['elements'][_chartIndex + 1].values = chartData[1].source.slice( start , end ) ;
			_value.main['elements'][_chartIndex + 2].values = chartData[2].source.slice( start , end )  ;
		}
		
		private function getStandarDeviation(startIndex:int , allData:Array , property:String = "value"):Number
		{
			var standardDev:Number = 0;
			var sum:Number = 0 ;
			var mean:Number = 0;
			
			for ( var i:int=startIndex ; i < _period + startIndex ; i++)
			{
				sum = sum + allData[i][property] ;
			}
			
			mean = sum / _period ;
			
			sum = 0 ;
			
			for ( var j:int=startIndex ; j < _period + startIndex ; j++)
			{
				sum = sum + ((allData[j][property] - mean) * (allData[j][property] - mean));
			}
			
			standardDev = Math.sqrt(sum / _period ) ;
			
			return standardDev ;
		}
		
		public function getMaxValueAt(index:int):Number
		{
			var val1:Number = (_value.main['elements'][_chartIndex].values[index] == null )? 0 : _value.main['elements'][_chartIndex].values[index].value ;
			var val2:Number = (_value.main['elements'][_chartIndex+1].values[index] == null )? 0 : _value.main['elements'][_chartIndex+1].values[index].value ;
			var val3:Number = (_value.main['elements'][_chartIndex+2].values[index] == null )? 0 : _value.main['elements'][_chartIndex+2].values[index].value ;
			
			return Math.max(val1,val2,val3) ;
			
		}
		
		public function getMinValueAt(index:int):Number
		{
			var val1:Number = (_value.main['elements'][_chartIndex].values[index] == null )? 0 : _value.main['elements'][_chartIndex].values[index].value ;
			var val2:Number = (_value.main['elements'][_chartIndex+1].values[index] == null )? 0 : _value.main['elements'][_chartIndex+1].values[index].value ;
			var val3:Number = (_value.main['elements'][_chartIndex+2].values[index] == null )? 0 : _value.main['elements'][_chartIndex+2].values[index].value ;
			
			return Math.min(val1,val2,val3) ;		
		}
		
		public function get drawInNewPane():Boolean{return false}
		public function get staticYAxis():Boolean {return false}
		public function set data(val:Object):void	{	_value = val ;	}
		public function get data():Object{	return _value ;	}		
		public function set period(val:int):void	{	_period = val ;	}
		public function get period():int{	return _period ;	}
		public function set deviations(val:int):void	{	_deviations = val ;	}
		public function get deviations():int{	return _deviations ;	}
		public function get lastIndex():int{ return _index }
		public function set lastIndex(val:int):void{ _index = val }
		public function get yMax():Number{ return _yMax }
		public function set yMax(val:Number):void{ _yMax = val }
		public function get yMin():Number{ return _yMin }
		public function set yMin(val:Number):void{ _yMin = val }
		public function get yMaxC():Number{ return _yMaxC }
		public function set yMaxC(val:Number):void{ _yMaxC = val }
		public function get yMinC():Number{ return _yMinC }
		public function set yMinC(val:Number):void{ _yMinC = val }		
		public function get chartIndex():*{ 			
			return [_chartIndex,_chartIndex+1,_chartIndex+2 ];			
		}
		public function set chartIndex(val:int):void
		{
			_chartIndex = val ;
		}
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