package sigma.studies
{
	import mx.collections.ArrayCollection;
	import mx.core.UIComponent;

	public class SlowSTO extends Pane
	{
		private var _value:Object = new Object();
		private var _period1:int = 5 ;
		private var _period2:int = 3 ;
		private var _period3:int = 3 ;
		/*private var fastostIndex:int = 0 ;
		private var fastostSmaIndex:int = 0 ;*/
		private var _index:int = 0 ;
		private var _duration:String ;
		private var slowKarray:Array = [];
		public var chartData:ArrayCollection = new ArrayCollection([new ArrayCollection(),
			new ArrayCollection(),new ArrayCollection(),new ArrayCollection()]) ;
		private var _name:String = "SlowSTO";
		private var _allBaseChartData:Array = [];
		private var _leftBoundary:Number = 0 ;
		private var _rightBoundary:Number = 0;
		private var _parametrs:Array = [{"label":"Period1","value":_period1 ,"funcName":"period1"},
			{"label":"Period2","value":_period2,"funcName":"period2"}, 
			{"label":"Period3","value":_period3,"funcName":"period3"}] ;
		
		public function SlowSTO()
		{}
		
		public function contructing( value:Object ,  duration:String , container:UIComponent ):void
		{
			slowKarray = [];
			
			_duration = duration ;
			_value = value ;
			
			_value.SlowSTO = new Object();
			_value.SlowSTO['title'] = [];
			_value.SlowSTO['title'].style = "text-align: left";
			_value.SlowSTO['bg_colour'] = "#ffffff";
			
			_value.SlowSTO['elements'] = [];			
			_value.SlowSTO['elements'][0] = [];
			_value.SlowSTO['elements'][0]['text'] = "SlowK"+"("+_period1+")";
			_value.SlowSTO['elements'][0]['colour'] = "#ee0000";			
			_value.SlowSTO['elements'][0]['font-size'] = 10 ;
			_value.SlowSTO['elements'][0]['type']="line";
			_value.SlowSTO['elements'][0]['fill']="#343399";
			_value.SlowSTO['elements'][0]['fill-alpha']= 0.5;
			//_value['elements'][0]['negative-colour']= "#d04040";
			//_value.SlowSTO['elements'][0]['tip']= "volume:<br>#val#<br>Key: #key#<br>Label:#x_label#<br>Legend:#x_legend#";
			_value.SlowSTO['elements'][0].values = [];
			
			_value.SlowSTO['elements'][1] = [];
			_value.SlowSTO['elements'][1]['text'] = "SlowD"+"("+_period3+")";
			_value.SlowSTO['elements'][1]['colour'] = "#00ee00";			
			_value.SlowSTO['elements'][1]['font-size'] = 10 ;
			_value.SlowSTO['elements'][1]['type']="line";
			_value.SlowSTO['elements'][1]['fill']="#343399";
			_value.SlowSTO['elements'][1]['fill-alpha']= 0.5;
			//_value['elements'][0]['negative-colour']= "#d04040";
			//_value.SlowSTO['elements'][0]['tip']= "volume:<br>#val#<br>Key: #key#<br>Label:#x_label#<br>Legend:#x_legend#";
			_value.SlowSTO['elements'][1].values = [];
			
			
			_value.SlowSTO['elements'][2] = [];
			
			_value.SlowSTO['elements'][2]['colour'] = "#ffcc00";				
			_value.SlowSTO['elements'][2]['font-size'] = 10 ;
			_value.SlowSTO['elements'][2]['type']="line";
			_value.SlowSTO['elements'][2]['fill']="#117054";
			_value.SlowSTO['elements'][2]['fill-alpha']= 0.5;
			//_value['elements'][0]['negative-colour']= "#d04040";		
			_value.SlowSTO['elements'][2].values = [];
			
			_value.SlowSTO['elements'][3] = [];
			
			_value.SlowSTO['elements'][3]['colour'] = "#ffcc00";				
			_value.SlowSTO['elements'][3]['font-size'] = 10 ;
			_value.SlowSTO['elements'][3]['type']="line";
			_value.SlowSTO['elements'][3]['fill']="#117054";
			_value.SlowSTO['elements'][3]['fill-alpha']= 0.5;
			//_value['elements'][0]['negative-colour']= "#d04040";				
			_value.SlowSTO['elements'][3].values = [];
			
			_value.SlowSTO['y_axis'] = [];
			_value.SlowSTO['y_axis']['stroke'] = 1;
			_value.SlowSTO['y_axis']['grid-colour'] = "#dddddd";
			_value.SlowSTO['y_axis']['colour'] = "#c6d9fd";				
			_value.SlowSTO['x_axis'] = [];
			_value.SlowSTO['x_axis']['steps'] = 30 ;				
			_value.SlowSTO['x_axis']['offset'] = true ;
			_value.SlowSTO['x_axis']['stroke'] = 1;
			_value.SlowSTO['x_axis']['colour'] = "#c6d9fd";
			_value.SlowSTO['x_axis']['grid-colour'] = '#dddddd';
			_value.SlowSTO['x_axis'].labels = [];
			_value.SlowSTO['y_axis'].min = 0 ;
			_value.SlowSTO['y_axis'].max = 100 ;			
			_value.SlowSTO['y_axis'].steps = 10;				
			_value.SlowSTO['x_axis']['labels']['visible-steps'] = 50 ;
			_value.SlowSTO['x_axis']['labels'].labels = [];
			
			values = _value.SlowSTO ;
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
			chartData = new ArrayCollection([new ArrayCollection(),
				new ArrayCollection(),new ArrayCollection(),new ArrayCollection()]) ;
			
			_allBaseChartData = [];
			
			_value.SlowSTO['elements'][0].values = [];
			_value.SlowSTO['elements'][1].values = [];
			_value.SlowSTO['elements'][2].values = [];
			_value.SlowSTO['elements'][3].values = [];
			_value.SlowSTO['x_axis']['labels'].labels = [];
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
			
			//setYaxisRange();			
			build_chart(_value.SlowSTO);
		}
		
		public function addData(allData:Array , index:int):void
		{
			_index = index ;
			//_allBaseChartData = allData ;
			var timeStamp:String = allData[index].timeStamp ;
			
			if( _index >= _period1 - 1 )
			{
				var valueSlowSTO:* = getFastSTOValue(index - (_period1 - 1),_period1 , allData ) ;
				var val:Number = 0 ;
				switch(valueSlowSTO)
				{
					case null:
						slowKarray.push({"timeStamp":timeStamp,"value":slowKarray[slowKarray.length - 1].value});						
						if(_index >= (_period1 - 1) + ( _period2 - 1) )
						{
							val = chartData[0][chartData[0].length - 1].value ;							
						}
						break;
					default:
						slowKarray.push({"timeStamp":timeStamp,"value":valueSlowSTO});
						if(_index >= (_period1 - 1) + ( _period2 - 1) )
						{
							val = Functions.getSmaValue(index - (_period2 - 1),slowKarray,_period2);							
						}
						break
				}
				
				if(_index >= (_period1 - 1) + ( _period2 - 1) )
				{
					/*_value.SlowSTO['elements'][0].values.push({"timeStamp":timeStamp,"value":val});*/
					chartData[0].addItem({"timeStamp":timeStamp,"value":val});
						
					if(_index >= (_period1 - 1) + ( _period2 - 1) + (_period3 - 1 ))
					{
						var _val2:Number = Functions.getSmaValue(index - (_period3 - 1), chartData[0].source ,_period3) ;
						/*_value.SlowSTO['elements'][1].values.push({"timeStamp":timeStamp,"value":_val2});*/
						chartData[1].addItem({"timeStamp":timeStamp,"value":_val2});
					}else{
						
						/*_value.SlowSTO['elements'][1].values.push(null);*/
						chartData[1].addItem(null);
					}
				}else{
					
					/*_value.SlowSTO['elements'][0].values.push(null);
					_value.SlowSTO['elements'][1].values.push(null);*/
					chartData[0].addItem(null);
					chartData[1].addItem(null);
				}
				
			}else{
				
				slowKarray.push(null);
				/*_value.SlowSTO['elements'][0].values.push(null);
				_value.SlowSTO['elements'][1].values.push(null);*/
				chartData[0].addItem(null);
				chartData[1].addItem(null);
				
			}
			
			/*_value.SlowSTO['elements'][2].values.push({"timeStamp":timeStamp,'value':20});
			_value.SlowSTO['elements'][3].values.push({"timeStamp":timeStamp,'value':80});*/
			chartData[2].addItem({"timeStamp":timeStamp,'value':20});
			chartData[3].addItem({"timeStamp":timeStamp,'value':80});
			/*_value.SlowSTO['x_axis'].labels.labels.push(Functions.returnLabel(timeStamp , _duration));*/
			
			
		}
		
		public function updateDataAt(allData:Array , index:int):void
		{
			var timeStamp:String = allData[index].timeStamp ;
			
			if( _index >= _period1 - 1 )
			{
				var valueSlowSTO:* = getFastSTOValue((index) - (_period1 - 1),_period1 , allData ) ;
				switch(valueSlowSTO)
				{
					case null:
						slowKarray[index] = {"timeStamp":timeStamp,"value":slowKarray[slowKarray.length - 2].value};										
						break;
					default:
						slowKarray[index] = {"timeStamp":timeStamp,"value":valueSlowSTO};										
						break
				}
				
				if(_index >= (_period1 - 1) + ( _period2 - 1) )
				{
					var _val2:Number = Functions.getSmaValue((index) - (_period2 - 1),slowKarray,_period2) ;
					/*_value.SlowSTO['elements'][0].values[index] = {"timeStamp":timeStamp,"value":_val2};*/
					chartData[0].setItemAt({"timeStamp":timeStamp,"value":_val2} , index );
					
					if(_index >= (_period1 - 1) + ( _period2 - 1) + (_period3 - 1 ))
					{
						_val2 = Functions.getSmaValue((index) - (_period3 - 1), chartData[2].source ,_period3) ;
						/*_value.SlowSTO['elements'][1].values[index ] = {"timeStamp":timeStamp,"value":_val2};*/
						chartData[1].setItemAt( {"timeStamp":timeStamp,"value":_val2} , index );
						
					}else{
						
						/*_value.SlowSTO['elements'][1].values[index] = null;*/
						chartData[1].setItemAt( null , index );
					}
					
				}else{
					
					/*_value.SlowSTO['elements'][0].values[index] = null;
					_value.SlowSTO['elements'][1].values[index] = null;*/
					chartData[0].setItemAt( null , index );
					chartData[1].setItemAt( null , index );
				}
				
				
			}else{
				
				slowKarray[index] = null;
				/*_value.SlowSTO['elements'][0].values[index] = null;
				_value.SlowSTO['elements'][1].values[index] = null;*/
				chartData[0].setItemAt( null , index );
				chartData[1].setItemAt( null , index );
				
			}
			
			/*_value.SlowSTO['elements'][2].values[index] = {"timeStamp":timeStamp,'value':20};
			_value.SlowSTO['elements'][3].values[index] = {"timeStamp":timeStamp,'value':80};*/
			chartData[2].setItemAt( {"timeStamp":timeStamp,'value':20} , index );
			chartData[3].setItemAt( {"timeStamp":timeStamp,'value':80} , index );
			/*_value.SlowSTO['x_axis'].labels.labels[index] = Functions.returnLabel(timeStamp,_duration );*/
			
		}
		
		private function getFastSTOValue(startIndex:int,period:int,allData:Array):*
		{
			_allBaseChartData = allData ;
			
			var highestHigh:Number = _allBaseChartData[startIndex].high ;
			var lowestLow:Number = _allBaseChartData[startIndex].low ;
			var FastSTOValue:* = 0 ;
			
			//FastSTOIndex = startIndex + ( period - 1 ) ;
			//slowostIndex = startIndex + ( period - 1 ) ;
			
			for ( var i:int=startIndex+1 ; i < period + startIndex ; i++)
			{
				if( highestHigh < _allBaseChartData[i].high ) highestHigh = _allBaseChartData[i].high ;
				if( lowestLow > _allBaseChartData[i].low ) lowestLow = _allBaseChartData[i].low ;
			}
			
			
			if(highestHigh - lowestLow == 0 )
			{
				FastSTOValue = null ;
			}else{
				
				FastSTOValue = (_allBaseChartData[startIndex + ( period - 1 )].value -  lowestLow  ) / (highestHigh -  lowestLow) * 100 ;
			}
			
			
			/* trace("wprValue="+wprValue); */
			/* if(!wprValue )wprValue = -50 ; */
			return FastSTOValue ;
		}
		
		public function applyScroling(start:Number , end:Number):void
		{
			_value['SlowSTO']['elements'][3].values = chartData[3].source.slice(start , end );
			_value['SlowSTO']['elements'][2].values = chartData[2].source.slice(start , end );
			_value['SlowSTO']['elements'][1].values = chartData[1].source.slice(start , end );
			_value['SlowSTO']['elements'][0].values = chartData[0].source.slice(start , end );
			
		}
		
		public function set xAxisLabels(val:Array):void
		{
			_value.SlowSTO['x_axis'].labels.labels = val ; 
			drawChart(); 
		}
		
		public function get chartObject():Object
		{
			return _value.SlowSTO ;
		}
		
		public function getValueAt(index:int):Number
		{
			return (_value.SlowSTO['elements'][0].values[index] == null )? 0 : _value.SlowSTO['elements'][0].values[index].value ;
		}
		
		public function get drawInNewPane():Boolean{return true}
		public function get staticYAxis():Boolean {return true}
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