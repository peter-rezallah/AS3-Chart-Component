package sigma.studies
{
	import mx.collections.ArrayCollection;
	import mx.core.UIComponent;
	import mx.formatters.DateFormatter;
	import mx.messaging.messages.ErrorMessage;

	public class RelativeStrengthIndex extends Pane
	{
		private var _value:Object = new Object();
		private var _period:int = 10 ;
		private var _index:int = 0 ;
		private var _duration:String ;
		
		private var rsiGainArray:Array = [];
		private var rsiLoseArray:Array = [];
		private var avgGainArray:Array = [];
		private var avgLoseArray:Array = [];
		
		public var chartData:ArrayCollection = new ArrayCollection([new ArrayCollection(),
			new ArrayCollection(),
			new ArrayCollection()]) ;
		private var _name:String = "RelativeStrengthIndex";
		private var _allBaseChartData:Array = [];
		private var _leftBoundary:Number = 0 ;
		private var _rightBoundary:Number = 0;
		private var _parametrs:Array = [{"label":"Period","value":_period ,"funcName":"period"}] ;
		
		public function RelativeStrengthIndex()
		{}
		
		public function contructing( value:Object ,  duration:String , container:UIComponent ):void
		{
			rsiGainArray = [];
			rsiLoseArray = [];
			avgGainArray = [];
			avgLoseArray = [];
			_duration = duration ;
			
			_value = value ;
			_value.RSI = new Object();	
			_value.RSI['title'] = [];
			_value.RSI['title'].style = "text-align: left";
			_value.RSI['bg_colour'] = "#ffffff";
			_value.RSI['elements'] = [];
			
			_value.RSI['elements'][2] = [];
			_value.RSI['elements'][2]['colour'] = "#ffcc00";				
			_value.RSI['elements'][2]['font-size'] = 10 ;
			_value.RSI['elements'][2]['type']="line";
			_value.RSI['elements'][2]['width']= 0.1;
			_value.RSI['elements'][2]['fill']="#117054";
			_value.RSI['elements'][2]['fill-alpha']= 0.5;
			//_value['elements'][0]['negative-colour']= "#d04040";		
			_value.RSI['elements'][2].values = [];
			
			_value.RSI['elements'][1] = [];
			_value.RSI['elements'][1]['colour'] = "#ffcc00";				
			_value.RSI['elements'][1]['font-size'] = 10 ;
			_value.RSI['elements'][1]['type']="line";
			_value.RSI['elements'][1]['width']= 0.1;
			_value.RSI['elements'][1]['fill']="#117054";
			_value.RSI['elements'][1]['fill-alpha']= 0.5;
			//_value['elements'][0]['negative-colour']= "#d04040";				
			_value.RSI['elements'][1].values = [];
			
			
			_value.RSI['elements'][0] = [];
			_value.RSI['elements'][0]['colour'] = "#ee0000";
			_value.RSI['elements'][0]['text'] = "RSI"+"("+_period+")";
			_value.RSI['elements'][0]['font-size'] = 10 ;
			_value.RSI['elements'][0]['type']="line";
			_value.RSI['elements'][0]['fill']="#343399";
			_value.RSI['elements'][0]['fill-alpha']= 0.5;
			//_value['elements'][0]['negative-colour']= "#d04040";
			//_value.RSI['elements'][0]['tip']= "volume:<br>#val#<br>Key: #key#<br>Label:#x_label#<br>Legend:#x_legend#";
			_value.RSI['elements'][0].values = [];
			
			_value.RSI['y_axis'] = [];
			_value.RSI['y_axis']['stroke'] = 1;
			_value.RSI['y_axis']['grid-colour'] = "#dddddd";
			_value.RSI['y_axis']['colour'] = "#c6d9fd";				
			_value.RSI['x_axis'] = [];
			_value.RSI['x_axis']['steps'] = 30 ;				
			_value.RSI['x_axis']['offset'] = true ;
			_value.RSI['x_axis']['stroke'] = 1;
			_value.RSI['x_axis']['colour'] = "#c6d9fd";
			_value.RSI['x_axis']['grid-colour'] = '#dddddd';
			_value.RSI['x_axis'].labels = [];
			//_value['x_axis'].min = "10:30";
			//_value['x_axis'].max = "14:30";
			_value.RSI['x_axis']['labels']['visible-steps'] = 50 ;
			_value.RSI['x_axis']['labels'].labels = [];
			
			_value.RSI['y_axis'].min = 0 ;
			_value.RSI['y_axis'].max = 100 ;
			/* value.MACD['y_axis'].steps = get_steps(yMinMacd,yMaxMacd,100);  */
			_value.RSI['y_axis'].steps = 10;				
			/*  value['y_axis'].steps = 0.05; */ 
			
			values = _value.RSI ;
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
			chartData = new ArrayCollection([new ArrayCollection(),	new ArrayCollection(),new ArrayCollection()]) ;
			
			_allBaseChartData = [];
			
			_value.RSI['elements'][0].values = [];
			_value.RSI['elements'][1].values = [];
			_value.RSI['elements'][2].values = [];
			
			_value.RSI['x_axis']['labels'].labels = [];
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
			build_chart(_value.RSI);
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
			
			if(_index == 0 )
			{
				rsiGainArray.push(0);
				rsiLoseArray.push(0);
				/*_value.RSI['elements'][0].values.push(null);*/
				chartData[0].addItem(null);
				/* yMinRSI = Number(valueElement.attribute("Low"));
				yMaxRSI = Number(valueElement.attribute("High")); */
				
			}else{
				
				/* if(yMaxRSI < Number(valueElement.attribute("High")))yMaxRSI = Number(valueElement.attribute("High")) ;
				if(yMinRSI > Number(valueElement.attribute("Low")))yMinRSI = Number(valueElement.attribute("Low")) ; */
				
				if ( _allBaseChartData[index].value - _allBaseChartData[index - 1].value >= 0 )
				{
					rsiGainArray.push(_allBaseChartData[index].value - _allBaseChartData[index - 1].value);
					rsiLoseArray.push(0);
					
				}else{
					
					rsiLoseArray.push( Math.abs(_allBaseChartData[index].value - _allBaseChartData[index - 1].value) );
					rsiGainArray.push(0);
				}
				
				if( index > _period - 1 )
				{							
					var rsi:Number = getRSI(index - (_period - 1)) ;
					/*_value.RSI['elements'][0].values.push({"timeStamp":timeStamp,'value':rsi});*/
					/*trace("ADD , index = " + index + " , RSI = " + rsi + " , length=" +  _index + ", main length = " + _allBaseChartData.length );*/
					chartData[0].addItem({"timeStamp":timeStamp,'value':rsi});
					
				}else{
					
					/*_value.RSI['elements'][0].values.push(null);*/
					chartData[0].addItem(null);
				}				
				
				
			}
			
			/*_value.RSI['elements'][1].values.push({"timeStamp":timeStamp,'value':30});*/
			chartData[1].addItem({"timeStamp":timeStamp,'value':30});
			/*_value.RSI['elements'][2].values.push({"timeStamp":timeStamp,'value':70});*/
			chartData[2].addItem({"timeStamp":timeStamp,'value':70});
			/*_value.RSI['x_axis'].labels.labels.push(returnLabel(timeStamp));*/
			
		}
		
		public function updateDataAt(allData:Array , index:int):void
		{
			_allBaseChartData = allData ;
			var timeStamp:String = _allBaseChartData[index].timeStamp ;
			
			if(_index == 0 )
			{
				rsiGainArray.push(0);
				rsiLoseArray.push(0);
				/*_value.RSI['elements'][0].values[index] = null;*/
				chartData[0].setItemAt(null,index);
				
				/* yMinRSI = Number(valueElement.attribute("Low"));
				yMaxRSI = Number(valueElement.attribute("High")); */
				
			}else{
				
				/* if(yMaxRSI < Number(valueElement.attribute("High")))yMaxRSI = Number(valueElement.attribute("High")) ;
				if(yMinRSI > Number(valueElement.attribute("Low")))yMinRSI = Number(valueElement.attribute("Low")) ; */
				
				if ( _allBaseChartData[index].value - _allBaseChartData[index - 1].value >= 0 )
				{
					rsiGainArray[rsiGainArray.length - 1] = (_allBaseChartData[index].value - _allBaseChartData[index - 1].value);
					rsiLoseArray[rsiLoseArray.length - 1] = 0;
					
				}else{
					
					rsiLoseArray[rsiLoseArray.length - 1] =( Math.abs(_allBaseChartData[index].value - _allBaseChartData[index - 1].value) );
					rsiGainArray[rsiGainArray.length - 1] = 0;
				}
				
				if( _index >= _period - 1 )
				{							
					var rsi:Number = getRSI(index - (_period - 1)) ;
					/*_value.RSI['elements'][0].values[index] = {"timeStamp":timeStamp,'value':rsi};*/
					chartData[0].setItemAt(rsi,index);
					/*trace("Update , index = " + index + " , RSI = " + rsi + " , length=" +  _index + ", main length = " + _allBaseChartData.length );*/ 
					
				}else{
					
					/*_value.RSI['elements'][0].values[index] = null ;*/
					chartData[0].setItemAt(null,index);
				}
				
				
				
			}
			
			/*_value.RSI['elements'][1].values[index] = {"timeStamp":timeStamp,'value':30};*/
			chartData[1].setItemAt({"timeStamp":timeStamp,'value':30},index)
			/*_value.RSI['elements'][2].values[index] = {"timeStamp":timeStamp,'value':70};*/
			chartData[2].setItemAt({"timeStamp":timeStamp,'value':70},index)
			/*_value.RSI['x_axis'].labels.labels[index] = (returnLabel(timeStamp));*/
			
		}
		
		public function applyScroling(start:Number , end:Number):void
		{
			_value['RSI']['elements'][2].values = chartData[2].source.slice(start , end );
			_value['RSI']['elements'][1].values = chartData[1].source.slice(start , end );
			_value['RSI']['elements'][0].values = chartData[0].source.slice(start , end );
		}
		
		private function getRSI(startIndex:int ):Number
		{
			var result:Number  = 0;
			var sumGain:Number = 0;
			var sumLose:Number = 0;
			var avrLose:Number = 0;
			var avrGain:Number = 0;
			
			if(startIndex <= 1 )
			{
				for(var i:int=startIndex ; i < startIndex + _period ; i++)
				{
					sumGain = sumGain + rsiGainArray[i] ;
					sumLose = sumLose + rsiLoseArray[i] ;
				}
				
				avrGain = sumGain / _period ;					
				avrLose = sumLose / _period ;
				
				
				
			}else{
				
				avrGain = ((avgGainArray[startIndex - 2] * ( _period - 1 )) + rsiGainArray[_period - 1 + ( startIndex )]) / _period ;
				avrLose = ((avgLoseArray[startIndex - 2] * ( _period - 1 )) + rsiLoseArray[_period - 1 + ( startIndex )]) / _period ;
				
				
			}
			
			avgGainArray.push(avrGain);
			avgLoseArray.push(avrLose);
			
			var rs:Number = avgGainArray[startIndex-1] / avgLoseArray[startIndex-1] ;
			
			
			if(avgLoseArray[startIndex] == 0 ) result = 100 ;
			else result = 100 - (100 / ( 1 + rs) );
			
			/* trace(" rsiIndex = " + startIndex +" , avgGainArray = "+avgGainArray[startIndex-1]+" , avgLoseArray = "+avgLoseArray[startIndex-1]+" , RSI = " + result ); */ 
			
			//_index = startIndex ;
			
			return result ;
		}
		
		private function returnLabel(s:String):String
		{
			var parts:Array = s.split(" ");
			var date:String = parts[0];
			var time:String = parts[1];
			
			var dateStr:Array = date.split("/");
			var d:int = int(dateStr[0]);
			var m:Number = dateStr[1];
			var y:Number = dateStr[2];
			try
			{
				var timeStr:Array = time.split(":");
				var h:Number = timeStr[0];
				var mn:Number = timeStr[1];
				var se:Number = timeStr[2];
			}
			catch(e:ErrorMessage)
			{
				h =0;
				mn=0;
				se=0;
			}
			
			var cDate:Date = new Date(y,m-1,d,h,mn,se,0);
			var dateFormatter:DateFormatter = new DateFormatter();
			dateFormatter.formatString = "MM//YY" ;
			dateFormatter.format(cDate);
			
			switch(_duration)
			{
				case("1"):
					return h+":"+mn ;
					break;
				case("7"):						
				case("14"):
				case("21"):
					return d.toString(); 						
					break;
				case("30"):
				case("60"):
				case("90"):
					/* dateFormatter.formatString = "DD/MMM" ;
					return dateFormatter.format(cDate); */
					return d+"/"+m; 
					break;
				case("180"):
				case("270"):						
					return m.toString(); 
					/* dateFormatter.formatString = "MMM" ;
					return dateFormatter.format(cDate); */
					break;
				case("360"):
				case("720"):
				case("1080"):
				case("ytd"):	
					return m+"/"+y ; 
					/* dateFormatter.formatString = "MMM/YY" ;
					return dateFormatter.format(cDate); */
					break;
				default:
					return h+":"+mn ;
					break;
			}
			
		}
		
		public function get chartObject():Object
		{
			return _value.RSI ;
		}
		
		public function getMaxValueAt(index:int):Number
		{
			return (_value.RSI['elements'][0].values[index] == null )? 0 : _value.RSI['elements'][0].values[index].value ;
		}
		
		public function getMinValueAt(index:int):Number
		{
			return (_value.RSI['elements'][0].values[index] == null )? 0 : _value.RSI['elements'][0].values[index].value ;
		}
		
		public function set xAxisLabels(val:Array):void
		{
			_value.RSI['x_axis'].labels.labels = val ; 
			drawChart(); 
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