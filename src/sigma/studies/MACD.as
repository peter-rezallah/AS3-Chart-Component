package sigma.studies
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	import mx.core.UIComponent;
	import mx.formatters.DateFormatter;
	import mx.messaging.messages.ErrorMessage;

	public class MACD extends Pane
	{
		private var _value:Object = new Object();
		private var _short:int = 12 ;
		private var _long:int = 26 ;
		private var _signal:int = 9 ;
		private var _index:int = 0 ;
		private var _duration:String ;
		private var _yMin:Number = 0 ;
		private var _yMax:Number = 0 ;
		private var valueForMacdShort:Array = [] ;
		private var valueForMacdlong:Array = [] ;
		public var chartData:ArrayCollection = new ArrayCollection([new ArrayCollection(),
			new ArrayCollection(),
			new ArrayCollection()]) ;
		private var _name:String = "MACD";
		private var _allBaseChartData:Array = [];
		private var _leftBoundary:Number = 0 ;
		private var _rightBoundary:Number = 0;
		private var _parametrs:Array = [{"label":"long","value":_long ,"funcName":"long"},
										{"label":"short","value":_short,"funcName":"short"}, 
										{"label":"signal","value":_signal,"funcName":"signal"}] ;
		
		public function MACD()
		{}
		
		public function contructing( value:Object ,  duration:String , container:UIComponent ):void
		{
			valueForMacdShort = [];
			valueForMacdlong = [];
			
			_duration = duration ;			
			_value = value ;
			
			_value.MACD = new Object();			
			_value.MACD['bg_colour'] = "#ffffff";
			_value.MACD['elements'] = [];
			_value.MACD['elements'][0] = [];
			_value.MACD['elements'][0]['colour'] = "#87421F";
			_value.MACD['elements'][0]['text'] = _name + "(" + _long + ")" ;
			_value.MACD['elements'][0]['font-size'] = 10 ;
			_value.MACD['elements'][0]['type']="line";
			_value.MACD['elements'][0]['fill']="#117054";
			_value.MACD['elements'][0]['fill-alpha']= 0.5;
			//_value['elements'][0]['negative-colour']= "#d04040";
			_value.MACD['elements'][0]['tip']= "volume:<br>#val#<br>Key: #key#<br>Label:#x_label#<br>Legend:#x_legend#";
			_value.MACD['elements'][0].values = [];
			_value.MACD['title'] = [];
			//_value.MACD['title'].text = _name;
			_value.MACD['title'].style = "text-align: left";
			_value.MACD['y_axis'] = [];
			_value.MACD['y_axis']['stroke'] = 1;
			_value.MACD['y_axis']['grid-colour'] = "#dddddd";
			_value.MACD['y_axis']['colour'] = "#c6d9fd";
			
			
			_value.MACD['x_axis'] = [];
			_value.MACD['x_axis']['steps'] = 30 ;
			
			_value.MACD['x_axis']['offset'] = true ;
			_value.MACD['x_axis']['stroke'] = 1;
			_value.MACD['x_axis']['colour'] = "#c6d9fd";
			_value.MACD['x_axis']['grid-colour'] = '#dddddd';
			_value.MACD['x_axis'].labels = [];
			//_value['x_axis'].min = "10:30";
			//_value['x_axis'].max = "14:30";
			_value.MACD['x_axis']['labels']['visible-steps'] = 50 ;
			_value.MACD['x_axis']['labels'].labels = [];
			
			
			/* _value.MACD['elements'][2].values = [{'timeStamp':'10:30','value':0},{'timeStamp':'14:30','value':0}]; */
			
			_value.MACD['elements'][1] = [];
			_value.MACD['elements'][1]['colour'] = "#CC2300";
			_value.MACD['elements'][1]['text'] = "EMA(" + _signal + ")";
			_value.MACD['elements'][1]['font-size'] = 10 ;
			_value.MACD['elements'][1]['type']="line";
			_value.MACD['elements'][1]["line-style"]= {"style":"dash","on":10,"off":5};
			_value.MACD['elements'][1]['width']=1;
			//_value['elements'][0]['negative-colour']= "#d04040";
			/* _value.MACD['elements'][2]['tip']= "#value#"; */
			_value.MACD['elements'][1].values = [];
			
			_value.MACD['elements'][2] = [];
			_value.MACD['elements'][2]['colour'] = "#ffcc00";
			_value.MACD['elements'][2]['text'] = "Dive.";
			_value.MACD['elements'][2]['font-size'] = 10 ;
			_value.MACD['elements'][2]['type']="line";
			_value.MACD['elements'][2]['width']=1;
			//_value['elements'][0]['negative-colour']= "#d04040";
			/* _value.MACD['elements'][2]['tip']= "#value#"; */
			_value.MACD['elements'][2].values = [];
			
			values = _value.MACD ;
			width = 950 ;
			height = 100 ;			
			container.addChild(this);
		}
		
		/*private function assignListeners(e:Event):void
		{
			paneCloseBtn.addEventListener(MouseEvent.CLICK , die ) ;
		}*/
		
		public function sendMouseXY(x:Number , y:Number ):void
		{
			sendMouseXYToPane(x , y);
		}	
		
		public function init():void
		{
			_index = 0 ;
			_yMax = 0 ;
			_yMin = 0;
			chartData = new ArrayCollection([new ArrayCollection(),new ArrayCollection(),new ArrayCollection()]) ;			
			_allBaseChartData = [];
			
			_value.MACD['elements'][0].values = [];
			_value.MACD['elements'][1].values = [];
			_value.MACD['elements'][2].values = [];			
			
			_value.MACD['x_axis']['labels'].labels = [];
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
			
			setYaxisRange();			
			build_chart(_value.MACD);
		}
		
		public function addData(allData:Array , index:int):void
		{
			_index = index ;
			_allBaseChartData = allData ;
			var timeStamp:String = _allBaseChartData[index].timeStamp ;
			
			if( _index >= _short - 1 )
			{
				if( _index == _short - 1)
				{
					valueForMacdShort.push({"value":Functions.getSmaValue(index - (_short -1 ) , _allBaseChartData , _short )}) ;
				}else{
					
					valueForMacdShort.push({"value":Functions.getEmaValue(index , _allBaseChartData ,valueForMacdShort , _short )});
					
				}
				/* trace(" EMA --- ( point)=" + i + " ***** value = " + valueForMacdShort[i].value ) */	
			}else{
				
				valueForMacdShort.push(null) ;
				
			}					
			
			if(_index >= _long - 1 )
			{
				if( _index == _long - 1)
				{
					valueForMacdlong.push({"value":Functions.getSmaValue(index - (_long - 1) , _allBaseChartData , _long)});							
					
				}else{							
					valueForMacdlong.push({"value":Functions.getEmaValue(index , _allBaseChartData , valueForMacdlong , _long )});							
					
				}	
				
				var val:Number = valueForMacdShort[index].value - valueForMacdlong[index].value ;
				
				/*_value.MACD['elements'][0].values.push({"timeStamp":timeStamp,"value":val });*/
				chartData[0].addItem({"timeStamp":timeStamp,"value":val });
				
				if( _index == _long - 1)
				{
					
					_yMin = chartData[0][index].value;
					_yMax = chartData[0][index].value;
					
				}else if(_index > _long - 1){
					
					if(_index < _rightBoundary && _index > _leftBoundary )
					{
						if(_yMax < chartData[0][index].value)_yMax = chartData[0][index].value ;
						if(_yMin > chartData[0][index].value)_yMin = chartData[0][index].value ;
					}
					
				}						
				
				
				if( _index >= ( _long - 1 )+( _signal - 1 ) )
				{
					if( _index == ( _long - 1) + ( _signal - 1 ) )
					{
						val = Functions.getSmaValue(index - ( _signal - 1 ) , chartData[0].source , _signal ) ;						
					}else{	
						val = Functions.getEmaValue(index , chartData[0].source ,chartData[1].source , _signal );
					}	
					
					/*_value.MACD['elements'][1].values.push({"timeStamp":timeStamp,"value": val });*/
					chartData[1].addItem({"timeStamp":timeStamp,"value": val });
					/*trace("MACD=" + chartData[0][index].value + " , signal = " + chartData[1][index].value );*/
					
				}else{							
					/*_value.MACD['elements'][1].values.push(null);*/
					chartData[1].addItem(null);
				}						
				
			}else{						
				valueForMacdlong.push(null);
				/*_value.MACD['elements'][0].values.push(null);*/				
				/*_value.MACD['elements'][1].values.push(null);*/
				chartData[0].addItem(null);
				chartData[1].addItem(null);
				
			}
			
			/*_value.MACD['elements'][2].values.push({"timeStamp":timeStamp,'value':0});*/	
			chartData[2].addItem({"timeStamp":timeStamp,'value':0});
			/*_value.MACD['x_axis'].labels.labels.push(Functions.returnLabel(timeStamp,_duration));*/
			
			
		}
		
		public function updateDataAt(allData:Array , index:int):void
		{
			_allBaseChartData = allData ;
			var timeStamp:String = _allBaseChartData[index].timeStamp ;
			
			
			if( _index >= _short - 1 )
			{
				if( _index == _short - 1)
				{
					valueForMacdShort[index] = {"value":Functions.getSmaValue((index) - (_short -1 ) , _allBaseChartData , _short )} ;
				}else{
					
					valueForMacdShort[index] = {"value":Functions.getEmaValue((index) , _allBaseChartData ,valueForMacdShort , _short )};
					
				}
				/* trace(" EMA --- ( point)=" + i + " ***** value = " + valueForMacdShort[i].value ) */	
			}else{
				
				valueForMacdShort[index] = null ;
				
			}			
			
			
			if(_index >= _long - 1 )
			{
				if( _index == _long - 1)
				{
					valueForMacdlong[index] = {"value":Functions.getSmaValue((index) - (_long - 1) , _allBaseChartData , _long)};							
					
					
				}else{
					
					valueForMacdlong[index] = {"value":Functions.getEmaValue(index , _allBaseChartData , valueForMacdlong , _long )};							
					
					
				}	
				
				var val:Number = valueForMacdShort[index].value - valueForMacdlong[index].value ;
				
				/*_value.MACD['elements'][0].values[index] = {"timeStamp":data['TimeStamp1'],"value":val };*/
				chartData[0].setItemAt( {"timeStamp":timeStamp,"value":val } , index );
				
				if( _index == _long - 1)
				{
					
					_yMin = chartData[0][index].value;
					_yMax = chartData[0][index].value;
					
				}else if(_index > _long - 1){
					
					if(_index < _rightBoundary && _index > _leftBoundary )
					{
						if(_yMax < chartData[0][index].value)_yMax = chartData[0][index].value ;
						if(_yMin > chartData[0][index].value)_yMin = chartData[0][index].value ;
					}	
					
				}				
				
				if( _index >= ( _long - 1 )+( _signal - 1 ) )
				{
					if( _index == ( _long - 1) + ( _signal - 1 ) )
					{
						val = Functions.getSmaValue((index) - ( _signal - 1 ) , chartData[0].source , _signal ) ;						
						
					}else{						
						val = Functions.getEmaValue((index) , chartData[0].source , chartData[1].source , _signal ) ;
												
					}
					/*_value.MACD['elements'][1].values[index] = {"timeStamp":timeStamp,"value": val };*/
					chartData[1].setItemAt( {"timeStamp":timeStamp,"value": val } , index );
					
				}else{
					
					/*_value.MACD['elements'][1].values[index] = null;*/
					chartData[1].setItemAt( null , index );
					
				}
				
				
			}else{
				
				valueForMacdlong[index] = null ;
				/*chartData[0][index] = (null);
				chartData[1][index] = (null);*/
				chartData[0].setItemAt( null , index );
				chartData[1].setItemAt( null , index );
				
			}					
			
			/*_value.MACD['elements'][2].values[index] = {"timeStamp":timeStamp,'value':0};*/
			chartData[2].setItemAt( {"timeStamp":timeStamp,'value':0} , index );
			/*_value.MACD['x_axis'].labels.labels[index] = Functions.returnLabel(timeStamp ,_duration );*/
			
		}			
		
		
		public function applyScroling(start:Number , end:Number):void
		{
			_value['MACD']['elements'][2].values = chartData[2].source.slice(start , end );
			_value['MACD']['elements'][1].values = chartData[1].source.slice(start , end );
			_value['MACD']['elements'][0].values = chartData[0].source.slice(start , end );
		}
		
		public function setYaxisRange():void
		{
			_value.MACD['y_axis'].min = _yMin ;
			_value.MACD['y_axis'].max = _yMax ;
			_value.MACD['y_axis'].steps = Functions.get_steps(_yMin,_yMax,-0.002); 
		}
		
		public function get chartObject():Object
		{
			return _value.MACD ;
		}
		
		public function set xAxisLabels(val:Array):void
		{
			_value.MACD['x_axis'].labels.labels = val ; 
			drawChart(); 
		}
		
		public function getMaxValueAt(index:int):Number
		{
			var val_1:Number = ( _value.MACD['elements'][1].values[index] == null )? 0 : _value.MACD['elements'][1].values[index].value ;
			var val_2:Number = ( _value.MACD['elements'][0].values[index] == null )? 0 : _value.MACD['elements'][0].values[index].value ;
			var val_3:Number = ( _value.MACD['elements'][2].values[index] == null )? 0 : _value.MACD['elements'][2].values[index].value ;
			
			return Math.max( val_1 , val_2 , val_3 );
		}
		
		public function getMinValueAt(index:int):Number
		{
			var val_1:Number = ( _value.MACD['elements'][1].values[index] == null )? 0 : _value.MACD['elements'][1].values[index].value ;
			var val_2:Number = ( _value.MACD['elements'][0].values[index] == null )? 0 : _value.MACD['elements'][0].values[index].value ;
			var val_3:Number = ( _value.MACD['elements'][2].values[index] == null )? 0 : _value.MACD['elements'][2].values[index].value ;
			
			return Math.min( val_1 , val_2 , val_3 );
		}
		
		public function get drawInNewPane():Boolean{return true}
		public function get staticYAxis():Boolean {return false}
		public function set data(val:Object):void	{	_value = val ;	}
		public function get data():Object{	return _value ;	}		
		public function set short(val:int):void	{	_short = val ;	}
		public function get short():int{	return _short ;	}
		public function set long(val:int):void	{	_long = val ;	}
		public function get long():int{	return _long ;	}
		public function set signal(val:int):void	{	_signal = val ;	}
		public function get signal():int{	return _signal ;	}
		public function get lastIndex():int{ return _index }
		public function set lastIndex(val:int):void{ _index = val }
		public function set yMin(val:Number):void	{	_yMin = val ;	}
		public function get yMin():Number{	return _yMin ;	}
		public function set yMax(val:Number):void	{	_yMax = val ;	}
		public function get yMax():Number{	return _yMax ;	}
		public function set studyName(val:String):void	{	_name = val ;	}
		public function get studyName():String{	return _name ;	}
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