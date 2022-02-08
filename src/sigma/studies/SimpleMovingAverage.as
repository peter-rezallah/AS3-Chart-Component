package sigma.studies
{
	import mx.collections.ArrayCollection;
	import mx.core.FlexGlobals;

	public class SimpleMovingAverage
	{
		private var _value:Object = new Object();
		private var _chartIndex:int = 0 ;
		private var _period1:int = 14 ;
		private var _period2:int ;
		private var _period3:int ;
		private var _index:int = 0 ;
		private var _duration:String ;	
		private var _yMin:Number = 0 ;
		private var _yMax:Number = 0 ;
		private var _yMinC:Number = 0 ;
		private var _yMaxC:Number = 0 ;
		public var chartData:ArrayCollection = new ArrayCollection([new ArrayCollection(),new ArrayCollection(),new ArrayCollection()]) ;
		private var _allBaseChartData:Array = [];
		private var _leftBoundary:Number = 0 ;
		private var _rightBoundary:Number = 0;
		private var _name:String = "SMA";
		private var _parametrs:Array = [{"label":"Period1","value":_period1 ,"funcName":"period1"},
			{"label":"Period2","value":_period2 ,"funcName":"period2"},
			{"label":"Period3","value":_period3 ,"funcName":"period3"}] ;
		private var _isCompareOn:Boolean = false ;
		
		
		
		public function SimpleMovingAverage()
		{	
		}
		
		public function contructing( value:Object , duration:String ):void
		{
			_isCompareOn = FlexGlobals.topLevelApplication.isCompare ;
			_duration = duration ;			
			_value = value ;			
			
			_chartIndex = _value.main.elements.length ;
			_value.main['elements'][_chartIndex] = [];
			_value.main['elements'][_chartIndex]['colour'] = "#cc0000";
			_value.main['elements'][_chartIndex]['text'] = _name + "(" + _period1 + ")"; 
			_value.main['elements'][_chartIndex]['font-size'] = 10 ;
			
			if(!_isCompareOn)_value.main['elements'][_chartIndex]['type']="line";
			else _value.main['elements'][_chartIndex]['type']="line-compare";
				
								
			//value['elements'][0]['negative-colour']= "#d04040";
			/* value.main['elements'][1]['tip']= "#value#"; */
			_value.main['elements'][_chartIndex].values = [];
						
			
			if(_period2 != 0 )
			{				
				_value.main['elements'][_chartIndex + 1] = [];
				_value.main['elements'][_chartIndex + 1]['colour'] = "#cc5600";
				_value.main['elements'][_chartIndex + 1]['text'] = _name + "(" + _period2 + ")"; 
				_value.main['elements'][_chartIndex + 1]['font-size'] = 10 ;
				if(!_isCompareOn)_value.main['elements'][_chartIndex + 1]['type']="line";
				else _value.main['elements'][_chartIndex + 1]['type']="line-compare";
				//value['elements'][0]['negative-colour']= "#d04040";
				/* value.main['elements'][1]['tip']= "#value#"; */
				_value.main['elements'][_chartIndex + 1].values = [];
			}
			
			if(_period3 != 0 )
			{				
				_value.main['elements'][_chartIndex + 2] = [];
				_value.main['elements'][_chartIndex + 2]['colour'] = "#cc09f0";
				_value.main['elements'][_chartIndex + 2]['text'] = _name + "(" + _period3 + ")"; 
				_value.main['elements'][_chartIndex + 2]['font-size'] = 10 ;
				if(!_isCompareOn)_value.main['elements'][_chartIndex + 2]['type']="line";
				else _value.main['elements'][_chartIndex + 2]['type']="line-compare";
				//value['elements'][0]['negative-colour']= "#d04040";
				/* value.main['elements'][1]['tip']= "#value#"; */
				_value.main['elements'][_chartIndex].values = [];
			}
		}
		
		public function init():void
		{
			_index = 0 ;
			chartData = new ArrayCollection() ;			
			_allBaseChartData = [];			
			_value.main['elements'][_chartIndex].values = [];
			if(_period2 != 0 )
			{
				_value.main['elements'][_chartIndex + 1].values = [];
			}			
			if(_period3 != 0 )
			{
				_value.main['elements'][_chartIndex + 2].values = [];
			}
			
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
			
			if( _index >= _period1 - 1 )
			{
				var val:Number ;
				var val_p:Number ;
				
				
				val_p = Functions.getSmaValue( index - (_period1-1), _allBaseChartData ,  _period1 , "percentage" ) ;
				val = Functions.getSmaValue( index - (_period1-1), _allBaseChartData ,  _period1 ) ;
				
				//_value.main['elements'][_chartIndex].values.push({"timeStamp":timeStamp,"value":val });
				chartData[0].addItem({"timeStamp":timeStamp,"value":val , "percentage":val_p });		
				
				
				//_value.main['elements'][_chartIndex].values.push({"timeStamp":timeStamp,"value":val });				
				if( _index == _period1 - 1 )
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
				
				//_value.main['elements'][_chartIndex].values.push(null);
				chartData[0].addItem(null);
			}
			
			if(_period2 != 0 )
			{
				if( _index >= _period2 - 1 )
				{					
					
					var val2:Number ;
					var val2_p:Number ;
					
					val2_p = Functions.getSmaValue( index - (_period2-1), _allBaseChartData ,  _period2, "percentage") ;
					val2 = Functions.getSmaValue( index - (_period2-1), _allBaseChartData ,  _period2 ) ;
					//_value.main['elements'][_chartIndex+1].values.push({"timeStamp":timeStamp,"value":val2 });
					chartData[1].addItem({"timeStamp":timeStamp,"value":val2 , "percentage": val2_p });
					
					_yMax = ( _yMax > val2 ) ? _yMax : val2 ;
					_yMin = ( _yMin < val2 ) ? _yMin : val2 ;
					
					_yMaxC = ( _yMaxC > val2_p ) ? _yMaxC : val2_p ;
					_yMinC = ( _yMinC < val2_p ) ? _yMinC : val2_p ;
					
				}else{
					
					//_value.main['elements'][_chartIndex+1].values.push(null);
					chartData[1].addItem(null);
				}
			}
			
			if(_period3 != 0 )
			{
				if( _index >= _period3 - 1 )
				{
					var val3:Number ;
					var val3_p:Number ;
					val3_p = Functions.getSmaValue( index - (_period3-1), _allBaseChartData ,  _period3, "percentage") ;
					val3 = Functions.getSmaValue( index - (_period3-1), _allBaseChartData ,  _period3 ) ;
					//_value.main['elements'][_chartIndex+2].values.push({"timeStamp":timeStamp,"value":val3 });
					chartData[2].addItem({"timeStamp":timeStamp,"value":val3 , "percentage":val3_p });
					
					_yMaxC = ( _yMaxC > val3_p ) ? _yMaxC : val3_p ;
					_yMinC = ( _yMinC < val3_p ) ? _yMinC : val3_p ;
					
				}else{
					
					//_value.main['elements'][_chartIndex+2].values.push(null);
					chartData[2].addItem(null);
				}
			}
			
			
		}
		
		public function updateDataAt(allData:Array , index:int):void
		{
			_allBaseChartData = allData ;
			var timeStamp:String = _allBaseChartData[index].timeStamp ;
			
			if(_index >= _period1 - 1  )
			{
				var val:Number ;
				if(_isCompareOn) val = Functions.getSmaValue(index - (_period1 - 1) , _allBaseChartData , _period1 , "percentage") ;
				else val = Functions.getSmaValue(index - (_period1 - 1) , _allBaseChartData , _period1 ) ;
				//_value.main['elements'][_chartIndex].values[index] = {"timeStamp":data['TimeStamp1'],"value":val};
				chartData[0].setItemAt({"timeStamp":data['TimeStamp1'],"value":val} , index ); 
				
				if( _index == _period1 - 1 )
				{
					_yMax = _yMin = val ;
					
				}else{
					
					_yMax = ( _yMax > val ) ? _yMax : val ;
					_yMin = ( _yMin < val ) ? _yMin : val ;
					
					
				}
				
			}else{
				
				//_value.main['elements'][_chartIndex].values.push(null);
				chartData[0].setItemAt(null , index ) ;
			}
			
			if(_period2 != 0 )
			{
				if(_index >= _period2 - 1  )
				{
					var val2:Number ;
					if(_isCompareOn) val2 = Functions.getSmaValue(index - (_period2 - 1) , _allBaseChartData , _period2 , "percentage") ;
					else val2 = Functions.getSmaValue(index - (_period2 - 1) , _allBaseChartData , _period2 ) ;
					//_value.main['elements'][_chartIndex+1].values[index] = {"timeStamp":data['TimeStamp1'],"value":val2};
					chartData[1].setItemAt({"timeStamp":data['TimeStamp1'],"value":val2} , index ); 
					
					_yMax = ( _yMax > val2 ) ? _yMax : val2 ;
					_yMin = ( _yMin < val2 ) ? _yMin : val2 ;
					
				}else{
					
					//_value.main['elements'][_chartIndex+1].values.push(null);
					chartData[1].setItemAt(null , index ) ;
				}
			}
			
			if(_period3 != 0 )
			{
				if(_index >= _period3 - 1  )
				{
					var val3:Number ;
					if(_isCompareOn) val3 = Functions.getSmaValue(index - (_period3 - 1) , _allBaseChartData , _period3 , "percentage") ;
					else val3 = Functions.getSmaValue(index - (_period3 - 1) , _allBaseChartData , _period3 ) ;
					//_value.main['elements'][_chartIndex+2].values[index] = {"timeStamp":data['TimeStamp1'],"value":val3};
					chartData[2].setItemAt({"timeStamp":data['TimeStamp1'],"value":val3} , index ); 
					
					_yMax = ( _yMax > val3 ) ? _yMax : val3 ;
					_yMin = ( _yMin < val3 ) ? _yMin : val3 ;
					
				}else{
					
					//_value.main['elements'][_chartIndex+2].values.push(null);
					chartData[2].setItemAt(null , index ) ;
				}
			}
			
			
		}
		
		public function applyScroling(start:Number , end:Number):void
		{
			_value['main']['elements'][_chartIndex].values = chartData[0].source.slice(start , end );
			
			if(_period2 != 0 )
			{
				_value['main']['elements'][_chartIndex+1].values = chartData[1].source.slice(start , end );
			}
			
			if(_period3 != 0 )
			{
				_value['main']['elements'][_chartIndex+2].values = chartData[2].source.slice(start , end );
			}
		}
		
		public function reAdjustMainYaxis(index:int):void
		{
			if( _value.main['y_axis'].min > _value.main['elements'][_chartIndex].values[index].value ) _value.main['y_axis'].min = _value.main['elements'][_chartIndex].values[index].value ;
			if( _value.main['y_axis'].max > _value.main['elements'][_chartIndex].values[index].value ) _value.main['y_axis'].max = _value.main['elements'][_chartIndex].values[index].value ;
		}
		
		public function getMaxValueAt(index:int):Number
		{
			var val1:Number = (_value.main['elements'][_chartIndex].values[index] == null )? 0 : _value.main['elements'][_chartIndex].values[index].value ;
			if(_period2 != 0 )var val2:Number = (_value.main['elements'][_chartIndex+1].values[index] == null )? 0 : _value.main['elements'][_chartIndex+1].values[index].value ;
			if(_period3 != 0 )var val3:Number = (_value.main['elements'][_chartIndex+2].values[index] == null )? 0 : _value.main['elements'][_chartIndex+2].values[index].value ;
			
			if(val1 && val2 && val3)return Math.max(val1,val2,val3) ;
			else if(val1 && val2)return Math.max(val1,val2) ;
			else return Math.max(val1) ;
			
			
		}
		
		public function getMinValueAt(index:int):Number
		{
			var val1:Number = (_value.main['elements'][_chartIndex].values[index] == null )? 0 : _value.main['elements'][_chartIndex].values[index].value ;
			if(_period2 != 0 )var val2:Number = (_value.main['elements'][_chartIndex+1].values[index] == null )? 0 : _value.main['elements'][_chartIndex+1].values[index].value ;
			if(_period3 != 0 )var val3:Number = (_value.main['elements'][_chartIndex+2].values[index] == null )? 0 : _value.main['elements'][_chartIndex+2].values[index].value ;
			
			if(val1 && val2 && val3)return Math.min(val1,val2,val3) ;
			else if(val1 && val2)return Math.min(val1,val2) ;
			else return Math.min(val1) ;
		}
		
		public function get drawInNewPane():Boolean{return false}
		public function get staticYAxis():Boolean {return false}
		public function set data(val:Object):void	{	_value = val ;	}
		public function get data():Object{	return _value ;	}		
		public function set period1(val:int):void	{	_period1 = val ;	}
		public function get period1():int{	return _period1 ;	}
		public function set period2(val:int):void	{	_period2 = val ;	}
		public function get period2():int{	return _period2 ;	}
		public function set period3(val:int):void	{	_period3 = val ;	}
		public function get period3():int{	return _period3 ;	}
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
			
			if( _period1 !=0 && _period2 != 0 && _period3 != 0 )return [_chartIndex,_chartIndex+1,_chartIndex+2 ];
			else if ( _period1 !=0 && _period2 ) return [_chartIndex,_chartIndex+1];
			else return [_chartIndex ] ;
		
		}
		public function set chartIndex(val:int):void	
		{
			_chartIndex = val ;
			/*if( _period1 !=0 && _period2 != 0 && _period3 != 0 )return [_chartIndex,_chartIndex+1,_chartIndex+2 ];
			else if ( _period1 !=0 && _period2 ) return [_chartIndex,_chartIndex+1];
			else return [_chartIndex ] ;*/
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