package sigma.studies
{
	import mx.collections.ArrayCollection;
	import mx.core.UIComponent;

	public class Momentum extends Pane
	{
		private var _value:Object = new Object();
		private var _period:int = 14 ;
		private var _index:int = 0 ;
		private var _duration:String ;
		private var _yMin:Number = 0 ;
		private var _yMax:Number = 0 ;
		public var chartData:ArrayCollection = new ArrayCollection([new ArrayCollection(),new ArrayCollection()]);
		private var _name:String = "Momentum";
		private var _allBaseChartData:Array = [];
		private var _leftBoundary:Number = 0 ;
		private var _rightBoundary:Number = 0;
		private var _parametrs:Array = [{"label":"Period","value":_period ,"funcName":"period"}] ;
		
		public function Momentum()
		{}
		
		
		public function contructing( value:Object ,  duration:String , container:UIComponent ):void
		{
			_duration = duration ;
			_value = value ;
			
			_value.MOM = new Object();	
			_value.MOM['title'] = [];
			_value.MOM['title'].style = "text-align: left";
			
			_value.MOM['bg_colour'] = "#ffffff";
			_value.MOM['elements'] = [];
			
			_value.MOM['elements'][1] = [];
			_value.MOM['elements'][1]['colour'] = "#ffcc00";				
			_value.MOM['elements'][1]['font-size'] = 10 ;
			_value.MOM['elements'][1]['type']="line";
			_value.MOM['elements'][1]['width']= 0.5
			_value.MOM['elements'][1]['fill']="#117054";
			_value.MOM['elements'][1]['fill-alpha']= 0.5;
			//_value['elements'][0]['negative-colour']= "#d04040";		
			_value.MOM['elements'][1].values = [];
			
			_value.MOM['elements'][0] = [];
			_value.MOM['elements'][0]['colour'] = "#ff0000";				
			_value.MOM['elements'][0]['font-size'] = 10 ;
			_value.MOM['elements'][0]['type']="line";
			_value.MOM['elements'][0]['fill']="#117054";			
			_value.MOM['elements'][0]['fill-alpha']= 0.5;
			_value.MOM['elements'][0]['text']= "MOM"+"("+_period+")";				
			_value.MOM['elements'][0].values = [];
			
			//_value.MOM['title'].text = " VOLUME CHART ";
			_value.MOM['y_axis'] = [];
			_value.MOM['y_axis']['stroke'] = 1;
			_value.MOM['y_axis']['grid-colour'] = "#dddddd";
			_value.MOM['y_axis']['colour'] = "#c6d9fd";				
			_value.MOM['x_axis'] = [];
			_value.MOM['x_axis']['steps'] = 30 ;				
			_value.MOM['x_axis']['offset'] = true ;
			_value.MOM['x_axis']['stroke'] = 1;
			_value.MOM['x_axis']['colour'] = "#c6d9fd";
			_value.MOM['x_axis']['grid-colour'] = '#dddddd';
			_value.MOM['x_axis'].labels = [];
			//_value['x_axis'].min = "10:30";
			//_value['x_axis'].max = "14:30";
			_value.MOM['x_axis']['labels']['visible-steps'] = 50 ;
			_value.MOM['x_axis']['labels'].labels = [];
			
			
			values = _value.MOM ;
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
			chartData = new ArrayCollection([new ArrayCollection(),new ArrayCollection()]) ;			
			_allBaseChartData = [];
			
			_value.MOM['elements'][0].values = [];
			_value.MOM['elements'][1].values = [];
			
			_value.MOM['x_axis']['labels'].labels = [];
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
			build_chart(_value.MOM);
		}
		
		public function removedStudyFrom(container:UIComponent):void
		{
			this.die() ;
			container.removeChild(this);
		}
		
		public function addData(allData:Array , index:int):void
		{
			_index = index ;
			//_allBaseChartData = allData ;
			var timeStamp:String = allData[index].timeStamp ;
			
			if( _index > _period - 1 )
			{
				var valMom:Number = getMomValue(index - (_period),_period , allData ) ;
				/*trace(" Momentum value = " + valMom + " , index = " + index );*/
				
				/*_value.MOM['elements'][0].values.push({"timeStamp":timeStamp,"value":valMom});*/
				chartData[0].addItem({"timeStamp":timeStamp,"value":valMom});
				
				
				if(_yMax <= valMom ) _yMax = valMom ;
				if(_yMin > valMom ) _yMin = valMom ;
					
				
										
				
			}else{
				
				/*_value.MOM['elements'][1].values.push(null);*/
				chartData[0].addItem(null);
				
			}
			trace( _yMax , _yMin );
			/*_value.MOM['elements'][1].values.push({"timeStamp":timeStamp,'value':0});*/	
			chartData[1].addItem({"timeStamp":timeStamp,'value':0});
			/*_value.MOM['x_axis'].labels.labels.push(Functions.returnLabel(timeStamp , _duration));*/
			
		}
		
		public function updateDataAt(allData:Array , index:int):void
		{			
			var timeStamp:String = allData[index].timeStamp ;
			
			if( _index > _period - 1 )
			{
				var valMom:Number = getMomValue((index) - (_period) ,_period , allData ) ;
				
				/*_value.MOM['elements'][0].values[index] = {"timeStamp":data["TimeStamp1"],"value":valMom};*/
				chartData[0].setItemAt({"timeStamp":timeStamp,"value":valMom} , index );
				
				if(_yMax <= valMom ) _yMax = valMom ;
				if(_yMin> valMom ) _yMin = valMom ;						
				
			}else{
				
				/*_value.MOM['elements'][0].values[index] = null;*/
				chartData[1].setItemAt( null , index );
				
			}
			
			
			/*_value.MOM['elements'][1].values[index] = {"timeStamp":data["TimeStamp1"],'value':0};*/	
			chartData[1].setItemAt({"timeStamp":timeStamp,'value':0} , index );
			/*_value.MOM['x_axis'].labels.labels[index] = Functions.returnLabel(data["TimeStamp1"], _duration );*/
			
		}
		
		private function getMomValue(startIndex:int , period:int , allData:Array ):Number
		{
			_allBaseChartData = allData ;
			var valueMOM:Number = 0 ;				
			
			valueMOM = _allBaseChartData[ startIndex + period ].value - _allBaseChartData[ startIndex  ].value ;
			
			return valueMOM ;
			
		}
		
		public function setYaxisRange():void
		{
			_value.MOM['y_axis'].min = _yMin ;
			_value.MOM['y_axis'].max = _yMax ;
			_value.MOM['y_axis'].steps = Functions.get_steps(_yMin,_yMax,100);
		}
		
		public function applyScroling(start:Number , end:Number):void
		{
			_value['MOM']['elements'][0].values = chartData[0].source.slice(start , end );
			_value['MOM']['elements'][1].values = chartData[1].source.slice(start , end );
		}
		
		public function set xAxisLabels(val:Array):void
		{
			_value.MOM['x_axis'].labels.labels = val ; 
			drawChart(); 
		}
		
		public function get chartObject():Object
		{
			return _value.MOM ;
		}
		
		public function getMaxValueAt(index:int):Number
		{			
			var val_1:Number = ( _value.MOM['elements'][1].values[index] == null )? 0 : _value.MOM['elements'][1].values[index].value ;
			var val_2:Number = ( _value.MOM['elements'][0].values[index] == null )? 0 : _value.MOM['elements'][0].values[index].value ;
			
			return Math.max( val_1 , val_2 );
		}
		
		public function getMinValueAt(index:int):Number
		{
			var val_1:Number = ( _value.MOM['elements'][1].values[index] == null )? 0 : _value.MOM['elements'][1].values[index].value ;
			var val_2:Number = ( _value.MOM['elements'][0].values[index] == null )? 0 : _value.MOM['elements'][0].values[index].value ;
			
			return Math.min( val_1 , val_2 );
		}
		
		public function get drawInNewPane():Boolean{return true}
		public function get staticYAxis():Boolean {return false}
		public function set data(val:Object):void	{	_value = val ;	}
		public function get data():Object{	return _value ;	}		
		public function set period(val:int):void	{	_period = val ;	}
		public function get period():int{	return _period ;	}
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