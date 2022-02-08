package sigma.studies
{
	import mx.collections.ArrayCollection;
	
	public class Volum
	{
		private var _value:Object = new Object();
		private var _duration:String ;
		private var _yMin:Number = 0 ;
		private var _yMax:Number = 0 ;
		private var _index:int = 0 ;
		private var _newPane:Boolean = true ;
		private var _name:String = "Volume";
		public var chartData:ArrayCollection = new ArrayCollection();
		
		public function Volum()
		{
			_duration = duration ;
			_value = value ;
			_value.Volume = new Object();				
			_value.Volume['bg_colour'] = "#ffffff";
			_value.Volume['elements'] = [];
			_value.Volume['elements'][0] = [];
			_value.Volume['elements'][0]['colour'] = "#736AFF";
			/*_value.Volume['elements'][0]['text'] = CODE;*/
			_value.Volume['elements'][0]['font-size'] = 10 ;
			_value.Volume['elements'][0]['type']="bar";
			_value.Volume['elements'][0]['fill']="#343399";
			_value.Volume['elements'][0]['fill-alpha']= 0.5;
			//_value['elements'][0]['negative-colour']= "#d04040";
			_value.Volume['elements'][0]['tip']= "Volume:<br>#val#<br>Key: #key#<br>Label:#x_label#<br>Legend:#x_legend#";
			_value.Volume['elements'][0].values = [];
			_value.Volume['title'] = [];
			//_value.Volume['title'].text = " Volume CHART ";
			_value.Volume['y_axis'] = [];
			_value.Volume['y_axis']['stroke'] = 1;
			_value.Volume['y_axis']['grid-colour'] = "#dddddd";
			_value.Volume['y_axis']['colour'] = "#c6d9fd";				
			_value.Volume['x_axis'] = [];
			_value.Volume['x_axis']['steps'] = 30 ;				
			_value.Volume['x_axis']['offset'] = true ;
			_value.Volume['x_axis']['stroke'] = 1;
			_value.Volume['x_axis']['colour'] = "#c6d9fd";
			_value.Volume['x_axis']['grid-colour'] = '#dddddd';
			_value.Volume['x_axis'].labels = [];
			//_value['x_axis'].min = "10:30";
			//_value['x_axis'].max = "14:30";
			_value.Volume['x_axis']['labels']['visible-steps'] = 50 ;
			_value.Volume['x_axis']['labels'].labels = [];
		}
		
		public function addData(timeStamp:String , index:int):void
		{
			_index = index ;
			
			_value.Volume['elements'][0].values.push(_value.main['elements'][0].values[index].volume );
			_value.Volume['x_axis'].labels.labels.push(Functions.returnLabel(timeStamp,_duration));
			chartData.addItem(_value.main['elements'][0].values[index].volume);
			
			if( _index == 0 )
			{
				_yMin = Number(_value.main['elements'][0].values[index].volume );
				_yMax = Number(_value.main['elements'][0].values[index].volume );
			}else{			
				
				_yMax = (_yMax < Number(_value.main['elements'][0].values[index].volume ))?_yMax :Number(_value.main['elements'][0].values[index].volume ) ;
				_yMin = (_yMin > Number(_value.main['elements'][0].values[index].volume ))?_yMin :Number(_value.main['elements'][0].values[index].volume ) ;						
				
			}
			
		}
		
		public function updateDataAt(data:Object , index:int):void
		{			
			_value.Volume['elements'][0].values[index] = Number(data['Volume1']) ;
			_value.Volume['x_axis'].labels.labels[index] = data['TimeStamp1'] ;
			chartData.setItemAt(Number(data['Volume1']),index);
		}
		
		public function applyScroling(start:Number , end:Number):void
		{
			_value['Volume']['elements'][0].values = chartData.source.slice(start , end );
		}
		
		public function setYaxisRange():void
		{
			_value.Volume['y_axis'].min = _yMin ;
			_value.Volume['y_axis'].max = _yMax ;
			_value.Volume['y_axis'].steps = Functions.get_steps(_yMin,_yMax,100); 
		}
		
		public function set data(val:Object):void	{	_value = val ;	}
		public function get data():Object{	return _value ;	}
		public function set yMin(val:Number):void	{	_yMin = val ;	}
		public function get yMin():Number{	return _yMin ;	}
		public function set yMax(val:Number):void	{	_yMax = val ;	}
		public function get yMax():Number{	return _yMax ;	}
		public function get dataLength():int{ return chartData.length - 1}
		public function set name(val:String):void	{	_name = val ;	}
		public function get name():String{	return _name ;	}
		public function set newPane(val:Boolean):void	{	_newPane = val ;	}
		public function get newPane():Boolean{	return _newPane ;	}
		public function get lastIndex():int{ return _index }
		public function set lastIndex(val:int):void{ _index = val }
	}
}