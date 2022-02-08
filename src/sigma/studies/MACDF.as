package sigma.studies
{
	import mx.collections.ArrayCollection;
	import mx.core.UIComponent;

	public class MACDF extends Pane
	{
		private var _value:Object = new Object();
		private var valueForMacdFShort:Array = [] ;
		private var valueForMacdFlong:Array = [] ;
		private var mcadArrayValuesForMACDF:Array = [];
		private var signalArrayValuesForMACDF:Array = [];			
		private var _short:int = 12 ;
		private var _long:int = 26 ;
		private var _signal:int = 9 ;
		private var _index:int = 0 ;
		private var _duration:String ;
		private var _yMin:Number = 0 ;
		private var _yMax:Number = 0 ;
		public var chartData:ArrayCollection = new ArrayCollection([new ArrayCollection(),
			new ArrayCollection(),new ArrayCollection(),new ArrayCollection()]) ;
		private var _name:String = "MACDF";
		private var _allBaseChartData:Array = [];
		private var _leftBoundary:Number = 0 ;
		private var _rightBoundary:Number = 0;
		private var _parametrs:Array = [{"label":"long","value":_long ,"funcName":"long"},
			{"label":"short","value":_short,"funcName":"short"}, 
			{"label":"signal","value":_signal,"funcName":"signal"}] ;
		
		public function MACDF()
		{}
		
		public function contructing( value:Object ,  duration:String , container:UIComponent ):void
		{
			valueForMacdFShort = [];
			valueForMacdFlong = [];
			mcadArrayValuesForMACDF = [];
			signalArrayValuesForMACDF = [];
			
			_duration = duration ;			
			_value = value ;
			_value.MACDF = new Object();
			_value.MACDF['title'] = [];	
			_value.MACDF['title'].style = "text-align: left";
			_value.MACDF['bg_colour'] = "#ffffff";
			_value.MACDF['elements'] = [];
			_value.MACDF['elements'][0] = [];
			_value.MACDF['elements'][0]['colour'] = "#ffcc00";
			_value.MACDF['elements'][0]['text'] = _name + "(" + _long + ")" ;
			_value.MACDF['elements'][0]['font-size'] = 10 ;
			_value.MACDF['elements'][0]['type']="line";
			_value.MACDF['elements'][0]['fill']="#117054";
			_value.MACDF['elements'][0]['fill-alpha']= 0.5;
			//_value['elements'][0]['negative-colour']= "#d04040";
			_value.MACDF['elements'][0]['tip']= "volume:<br>#val#<br>Key: #key#<br>Label:#x_label#<br>Legend:#x_legend#";
			_value.MACDF['elements'][0].values = [];
			
			_value.MACDF['y_axis'] = [];
			_value.MACDF['y_axis']['stroke'] = 1;
			_value.MACDF['y_axis']['grid-colour'] = "#dddddd";
			_value.MACDF['y_axis']['colour'] = "#c6d9fd";
			
			
			_value.MACDF['x_axis'] = [];
			_value.MACDF['x_axis']['steps'] = 30 ;
			
			_value.MACDF['x_axis']['offset'] = true ;
			_value.MACDF['x_axis']['stroke'] = 1;
			_value.MACDF['x_axis']['colour'] = "#c6d9fd";
			_value.MACDF['x_axis']['grid-colour'] = '#dddddd';
			_value.MACDF['x_axis'].labels = [];
			//_value['x_axis'].min = "10:30";
			//_value['x_axis'].max = "14:30";
			_value.MACDF['x_axis']['labels']['visible-steps'] = 50 ;
			_value.MACDF['x_axis']['labels'].labels = [];
			
			
			/* _value.MACDF['elements'][2].values = [{'timeStamp':'10:30','value':0},{'timeStamp':'14:30','value':0}]; */
			
			_value.MACDF['elements'][1] = [];
			_value.MACDF['elements'][1]['colour'] = "#CC0000"; 
			/*_value.MACDF['elements'][1]['text'] = "EMA(" + _short + ")";*/ 
			_value.MACDF['elements'][1]['font-size'] = 10 ;
			_value.MACDF['elements'][1]['type']="bar_glass";
			_value.MACDF['elements'][1]['fill']="#CC0000";
			/* _value.MACDF['elements'][1]['width']=1; */ 
			_value.MACDF['elements'][1].values = [];
			
			_value.MACDF['elements'][2] = [];
			_value.MACDF['elements'][2]['colour'] = "#00CC00"; 
			/*_value.MACDF['elements'][2]['text'] = "EMA(" + _signal + ")";*/ 
			_value.MACDF['elements'][2]['font-size'] = 10 ;
			_value.MACDF['elements'][2]['type']="bar_glass";
			_value.MACDF['elements'][2]['fill']="#00CC00";
			/* _value.MACDF['elements'][2]['width']=1; */				
			/* _value.MACDF['elements'][2]['tip']= "#value#"; */
			_value.MACDF['elements'][2].values = [];
			
			_value.MACDF['elements'][3] = [];
			_value.MACDF['elements'][3]['colour'] = "#ffcc00";
			_value.MACDF['elements'][3]['text'] = "Dive."; 
			_value.MACDF['elements'][3]['font-size'] = 10 ;
			_value.MACDF['elements'][3]['type']="line";
			_value.MACDF['elements'][3]['width']=1;
			//_value['elements'][0]['negative-colour']= "#d04040";
			/* _value.MACDF['elements'][2]['tip']= "#value#"; */
			_value.MACDF['elements'][3].values = [];
			
			values = _value.MACDF ;
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
			_yMax = 0 ;
			_yMin = 0;
			chartData = new ArrayCollection([new ArrayCollection(),
				new ArrayCollection(),new ArrayCollection(),new ArrayCollection()]) ;			
			_allBaseChartData = [];
			
			_value.MACDF['elements'][0].values = [];
			_value.MACDF['elements'][1].values = [];
			_value.MACDF['elements'][2].values = [];
			_value.MACDF['elements'][3].values = [];
			
			_value.MACDF['x_axis']['labels'].labels = [];
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
		
		public function drawChart():void
		{			
			setYaxisRange();			
			build_chart(_value.MACDF);
		}
		
		
		public function removedStudyFrom(container:UIComponent):void
		{
			this.die() ;
			container.removeChild(this);
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
					valueForMacdFShort.push({"value":Functions.getSmaValue(index - (_short -1 ) , _allBaseChartData , _short )}) ;
					
				}else{
					
					valueForMacdFShort.push({"value":Functions.getEmaValue(index , _allBaseChartData ,valueForMacdFShort , _short )});
					
				}
				/* trace(" EMA --- ( point)=" + i + " ***** value = " + valueForMacdShort[i].value ) */	
			}else{
				
				valueForMacdFShort.push(null) ;
				
			}				
			
			
			if( _index >= _long - 1 )
			{
				if( _index == _long - 1 )
				{
					valueForMacdFlong.push({"value":Functions.getSmaValue(index - (_long -1 ) , _allBaseChartData , _long )});							
					
					
				}else{
					
					valueForMacdFlong.push({"value":Functions.getEmaValue(index , _allBaseChartData , valueForMacdFlong , _long )});							
					
				}	
				
				mcadArrayValuesForMACDF.push({"timeStamp":timeStamp,"value":valueForMacdFShort[index].value - valueForMacdFlong[index].value });
							
				if( _index >= ( _long - 1 )+( _signal - 1 ) )
				{
					var _val:Number ; ;
					
					if( _index == ( _long - 1) + ( _signal - 1 ) )
					{
						signalArrayValuesForMACDF.push({"timeStamp":timeStamp,"value":Functions.getSmaValue(index - ( _signal - 1 ) , mcadArrayValuesForMACDF , _signal ) });
						_val = mcadArrayValuesForMACDF[index].value - signalArrayValuesForMACDF[index].value ;						
						_yMin = _val;
						_yMax = _val;				
						
					}else{
						
						signalArrayValuesForMACDF.push({"timeStamp":timeStamp,"value":Functions.getEmaValue(index , mcadArrayValuesForMACDF ,signalArrayValuesForMACDF , _signal ) });						
						_val = mcadArrayValuesForMACDF[index].value - signalArrayValuesForMACDF[index].value ;	
						
						if(_index < _rightBoundary && _index > _leftBoundary )
						{
							if(_yMax < _val)_yMax = _val ;
							if(_yMin > _val)_yMin = _val ;
						}
						
					}					
					
					/*_value.MACDF['elements'][0].values.push({"timeStamp":timeStamp,"value":_val });*/
					chartData[0].addItem({"timeStamp":timeStamp,"value":_val });		
					
					if( _val < 0)
					{
						/*_value.MACDF['elements'][1].values.push(_val);
						_value.MACDF['elements'][2].values.push(null);*/
						chartData[1].addItem(_val);
						chartData[2].addItem(null);
						
						
					}else if ( _val > 0) {
						/*_value.MACDF['elements'][1].values.push(null);
						_value.MACDF['elements'][2].values.push(_val);*/
						chartData[1].addItem(null);
						chartData[2].addItem(_val);
						
					}
					
					
					
				}else{
					
					signalArrayValuesForMACDF.push(null);
					/*_value.MACDF['elements'][0].values.push(null);
					_value.MACDF['elements'][1].values.push(null);
					_value.MACDF['elements'][2].values.push(null);*/
					chartData[0].addItem(null);
					chartData[1].addItem(null);
					chartData[2].addItem(null);
					
					
				}
				
				
			}else{
				
				valueForMacdFlong.push(null)
				mcadArrayValuesForMACDF.push(null);
				signalArrayValuesForMACDF.push(null);
				/*_value.MACDF['elements'][0].values.push(null);
				_value.MACDF['elements'][1].values.push(null);
				_value.MACDF['elements'][2].values.push(null);*/
				chartData[0].addItem(null);
				chartData[1].addItem(null);
				chartData[2].addItem(null);
				
			}										
			
			/*_value.MACDF['elements'][3].values.push({"timeStamp":timeStamp,'value':0});*/	
			chartData[3].addItem({"timeStamp":timeStamp,'value':0});
			/*_value.MACDF['x_axis'].labels.labels.push(Functions.returnLabel(timeStamp,_duration));*/			
		}
		
		public function updateDataAt(allData:Array , index:int):void
		{	
			_allBaseChartData = allData ;
			var timeStamp:String = _allBaseChartData[index].timeStamp ;
			
			if( _index >= _short - 1 )
			{
				if( _index == _short - 1)
				{
					valueForMacdFShort[index] = {"value":Functions.getSmaValue((index)  - (_short -1 ) , _allBaseChartData , _short )} ;
					
				}else{					
					valueForMacdFShort[index] = {"value":Functions.getEmaValue((index) , _allBaseChartData ,valueForMacdFShort , _short )};
					}
				
			}else{				
				valueForMacdFShort[(index)] = null ;				
			}				
			
			
			if(_index >= _long - 1 )
			{
				if( _index == _long - 1)
				{
					valueForMacdFlong[(index)] = {"value":Functions.getSmaValue((index) - (_long -1 ) , _allBaseChartData , _long)};							
					
					
				}else{
					
					valueForMacdFlong[(index)] = {"value":Functions.getEmaValue((index) , _allBaseChartData , valueForMacdFlong , _long )};							
					
				}	
				
				mcadArrayValuesForMACDF[(index)] = {"timeStamp":timeStamp,"value":valueForMacdFShort[(index)].value - valueForMacdFlong[(index)].value };
								
				if(_index >= ( _long-1 )+( _signal-1 ) )
				{
					var _val:Number ;
					
					if( _index == ( _long - 1) + ( _signal-1 ) )
					{						
						signalArrayValuesForMACDF[(index)] = {"timeStamp":timeStamp,"value":Functions.getSmaValue((index) - ( _signal-1 ) , mcadArrayValuesForMACDF, _signal ) };						
						_val = mcadArrayValuesForMACDF[(index)].value - signalArrayValuesForMACDF[(index)].value ;					
						
						_yMin = _val;
						_yMax = _val;
						
						
						
					}else{
						
						signalArrayValuesForMACDF[(index)] = {"timeStamp":timeStamp,"value":Functions.getEmaValue((index) , mcadArrayValuesForMACDF ,signalArrayValuesForMACDF , _signal ) };						
						_val = mcadArrayValuesForMACDF[(index)].value - signalArrayValuesForMACDF[(index)].value ;
						
						if(_index < _rightBoundary && _index > _leftBoundary )
						{
							if(_yMax < _val)_yMax = _val ;
							if(_yMin > _val)_yMin = _val ;
						}
						
					}
					
					
					/*_value.MACDF['elements'][0].values[(index)] = {"timeStamp":timeStamp,"value":_val};*/
					chartData[0].setItemAt({"timeStamp":timeStamp,"value":_val},index);
					
					if( _val < 0)
					{
						/*_value.MACDF['elements'][1].values[index] = _val ;
						_value.MACDF['elements'][2].values[index] = null;*/
						chartData[1].setItemAt( _val , index );
						chartData[2].setItemAt( null , index );
						
					}else if ( _val > 0) {
						/*_value.MACDF['elements'][1].values[index] = null;
						_value.MACDF['elements'][2].values[index] = _val ;*/
						chartData[1].setItemAt( null , index );
						chartData[2].setItemAt( _val , index );						
					}
					
					
				}else{
					
					signalArrayValuesForMACDF[(index)] = null;
					/*_value.MACDF['elements'][0].values[(index)] = null;
					_value.MACDF['elements'][1].values[(index)] = null;
					_value.MACDF['elements'][2].values[(index)] = null;*/
					chartData[0].setItemAt( null , index );
					chartData[1].setItemAt( null , index );
					chartData[2].setItemAt( null , index );		
					
				}
				
				
			}else{
				
				valueForMacdFlong[(index)] = null;
				mcadArrayValuesForMACDF[(index)] = null;
				signalArrayValuesForMACDF[(index)] = null;
				/*_value.MACDF['elements'][0].values[(index)] = null;
				_value.MACDF['elements'][1].values[(index)] = null;
				_value.MACDF['elements'][2].values[(index)] = null;*/
				chartData[0].setItemAt( null , index );
				chartData[1].setItemAt( null , index );
				chartData[2].setItemAt( null , index );
				
			}										
			
			/*_value.MACDF['elements'][3].values[(index)] = {"timeStamp":timeStamp,'value':0};*/
			chartData[3].setItemAt( {"timeStamp":timeStamp,'value':0} , index );
			/*_value.MACDF['x_axis'].labels.labels[(index)] = (Functions.returnLabel(timeStamp,_duration));*/			
		}
		
		public function applyScroling(start:Number , end:Number):void
		{
			_value['MACDF']['elements'][3].values = chartData[3].source.slice(start , end );
			_value['MACDF']['elements'][2].values = chartData[2].source.slice(start , end );
			_value['MACDF']['elements'][1].values = chartData[1].source.slice(start , end );
			_value['MACDF']['elements'][0].values = chartData[0].source.slice(start , end );
		}
		
		public function setYaxisRange():void
		{
			_value.MACDF['y_axis'].min = _yMin ;
			_value.MACDF['y_axis'].max = _yMax ;			
			_value.MACDF['y_axis'].steps = Functions.get_steps(_yMin,_yMax,-100); 
		}
		
		public function set xAxisLabels(val:Array):void
		{
			_value.MACDF['x_axis'].labels.labels = val ; 
			drawChart(); 
		}
		
		public function get chartObject():Object
		{
			return _value.MACDF ;
		}
		
		public function getValueAt(index:int):Number
		{
			return (_value.MACDF['elements'][0].values[index] == null )? 0 : _value.MACDF[''][0].values[index].value ;
		}
		
		public function getMaxValueAt(index:int):Number
		{
			//var val_1:Number = ( _value.MACDF['elements'][1].values[index] == null )? 0 : _value.MACDF['elements'][1].values[index] ;
			var val_2:Number = ( _value.MACDF['elements'][0].values[index] == null )? 0 : _value.MACDF['elements'][0].values[index].value ;
			var val_3:Number = ( _value.MACDF['elements'][2].values[index] == null )? 0 : _value.MACDF['elements'][2].values[index] ;
			//var val_4:Number = ( _value.MACDF['elements'][3].values[index] == null )? 0 : _value.MACDF['elements'][3].values[index] ;
			
			return Math.max(  val_2 , val_3  );
		}
		
		public function getMinValueAt(index:int):Number
		{
			var val_1:Number = ( _value.MACDF['elements'][1].values[index] == null )? 0 : _value.MACDF['elements'][1].values[index] ;
			var val_2:Number = ( _value.MACDF['elements'][0].values[index] == null )? 0 : _value.MACDF['elements'][0].values[index].value ;
			//var val_3:Number = ( _value.MACDF['elements'][2].values[index] == null )? 0 : _value.MACDF['elements'][2].values[index] ;
			//var val_4:Number = ( _value.MACDF['elements'][3].values[index] == null )? 0 : _value.MACDF['elements'][3].values[index] ;
			
			return Math.min( val_1 , val_2  );
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