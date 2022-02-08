package sigma
{
	import flash.utils.getDefinitionByName;
	
	import mx.collections.ArrayCollection;
	import mx.core.FlexGlobals;
	import mx.core.UIComponent;
	
	import sigma.studies.CompareStudy;
	import sigma.studies.SimpleMovingAverage;
	import sigma.studies.StudyType;
	import sigma.studies.TrendLine;
	import sigma.studies.Volume;
		
		public class Organizer
		{
			
			private var _container:UIComponent = new UIComponent() ;
			private var _currentStudyList:ArrayCollection ;
			private var _value:Array = new Array();
			private var volume:Volume ;
			private var _allMainChartData:Array = [];
			private var _yMin:Number = 0 ;
			private var _yMax:Number = 0 ;
			private var _trendLine:TrendLine ;
			
			public function Organizer(con:UIComponent)
			{
				_container = con ;
				_currentStudyList = new ArrayCollection();
			}		
			
			public function addStudy(name:String):Object
			{
				var study:Object = createStudyInstance( name);				
				return study ;				
			}
			
			public function addTrendLine(name:String , value:Object , point1:Object ,  point2:Object , arrData:Array , allData:Array , left:Number , right:Number ,  duration:String  ):void
			{
				_allMainChartData = allData ;
				var study:Object = createStudyInstance(name);
				_currentStudyList.addItem(study);
				study.contructing( value , duration )
				study.buildChart( _allMainChartData , point1, point2 , arrData , left , right , value.main['x_axis'].labels.labels );
			}
			
			public function initStudy():void
			{
				for each(var study:Object in _currentStudyList )
				{
					if(study.drawInNewPane)
					study.init();
				}
				
			}
			
			public function addCogRecordAt(allData:Array , index:int ):void
			{
				_allMainChartData = allData ;
				for each(var study:Object in _currentStudyList )
				{
					study.addData(_allMainChartData , index );
					//if(study.drawInNewPane)	study.drawChart();
				}
			}
			
			public function updateCogRecordAt(allData:Array):void
			{
				_allMainChartData = allData ;
				
				for each(var study:Object in _currentStudyList )
				{					
					study.updateDataAt(_allMainChartData, study.lastIndex );
					if(study.drawInNewPane) study.drawChart();
				}
			}
			
			public function updateBoundaries(left:Number , right:Number ):void
			{
				for each(var study:Object in _currentStudyList )
				{
					study.applyScroling(left , right );
				}
			}
			
			
			public function setYaxisRange(index:int):void
			{
				for each(var study:Object in _currentStudyList )
				{
					if(!study.staticYAxis)
					{
						
						var recordMaxVal:Number = study.getMaxValueAt(index) ;
						var recordMinVal:Number = study.getMinValueAt(index) ;
						
						switch(study.drawInNewPane)
						{
							case(true):							
								
								if( index == 0 )
								{
									study.yMin = recordMinVal ;
									study.yMax = recordMaxVal ;
								}else{
									
									if(study.yMax < recordMaxVal )study.yMax = recordMaxVal ;
									if(study.yMin > recordMinVal )study.yMin = recordMinVal ; 
								}
								
								break;
							case(false):
								
								if( recordMaxVal != 0 ){ if(_yMax < recordMaxVal )_yMax = recordMaxVal ;}								
								if( recordMinVal != 0 ){ if(_yMin > recordMinVal )_yMin = recordMinVal ;}	
								
								
								break;
							
						}
						
					}				
					
				}			
				
			}
			
			public function updateBoundariesLabels(labels:Array = null ):void
			{
				var lab:Array = [];
				if(labels){
					lab = labels ;
				}
				
				for each(var study:Object in _currentStudyList )
				{
					if(study.drawInNewPane)
					study.xAxisLabels = lab ;
				}
			}
			
			public function syncorizeMouseMoveInAllStudies( x:Number , y:Number ):void
			{
				for each(var study:* in _currentStudyList )
				{
					if( study.drawInNewPane )
					{
						study.sendMouseXY(x , y ) ;
					}
				}
			}
			
			public function deleteStudyByName(name:String):void
			{
				var _chartIndex:int = 0 ;
				
				for each(var study:* in _currentStudyList )
				{
					if( study.studyName == name &&  study.drawInNewPane )
					{
						study.removedStudyFrom(_container);						
						_currentStudyList.removeItemAt(_chartIndex);
					}
					_chartIndex++ ;
				}
			}
			
			
			public function deleteUpperStudyBykey(index:int,value:Object):void
			{				
				var _chartIndex:int = 0 ;				
				
				for each(var study:* in _currentStudyList )
				{
					if(!study.drawInNewPane )
					{
						if( study.chartIndex is Array )
						{
							for(var p:int = 0 ; p <  study.chartIndex.length ; p++)
							{
								if( study.chartIndex[p] == index )
								{
									value.main['elements'].splice(study.chartIndex[0] , study.chartIndex.length );									
									_currentStudyList.removeItemAt(_chartIndex);
									
									for(var k:int = _chartIndex ; k < _currentStudyList.length ; k++)
									{
										if(!_currentStudyList[k].drawInNewPane)
										{											
											if(_currentStudyList[k].chartIndex is Array)
											{
												currentStudyList[k].chartIndex = currentStudyList[k].chartIndex[0] - study.chartIndex.length ;												
											
											}else{												
												_currentStudyList[k].chartIndex = _currentStudyList[k].chartIndex - study.chartIndex.length  ;
											}											
										}										
									}									
								}
							}							
							
						}else{
							
							if( study.chartIndex == index )
							{
								if( study is CompareStudy )
								{
									FlexGlobals.topLevelApplication.noCompareLines-- ;
									if ( FlexGlobals.topLevelApplication.noCompareLines == 0 ) 
									{
										for each(var o:Object in value.main['elements'])
										{
											o.type = "line";
										}
									}
										
								}
								value.main['elements'].splice( study.chartIndex , 1 );
								_currentStudyList.removeItemAt(_chartIndex);
								
								for(var i:int = _chartIndex ; i < _currentStudyList.length ; i++ )
								{
									if(!_currentStudyList[i].drawInNewPane)
									{
										if(_currentStudyList[i].chartIndex is Array)
										{
											_currentStudyList[i].chartIndex = _currentStudyList[i].chartIndex[0] - 1  ;
											
										}else{											
											_currentStudyList[i].chartIndex-- ;
										}																				
									}								
								}																
								break ;								
							}							
						}						
						_chartIndex++ ;
					}				
				}				
				
			}
			
			public function deleteAllTrendLines(value:Object):void
			{
				var _chartIndex:int = 0 ;				
				
				for each(var trend:* in _currentStudyList )
				{
					if (trend is TrendLine )
					{						
						value.main['elements'].splice(trend.chartIndex , 1 );
						
						for(var i:int = _chartIndex ; i < _currentStudyList.length ; i++ )
						{
							var study:* = _currentStudyList.getItemAt(i);
							if(!study.drawInNewPane )
							{
								if(study.chartIndex is Array)
								{
									study.chartIndex = study.chartIndex[0] - 1 ;
									
								}else{
									
									study.chartIndex-- ;
								}
								
							} 
						}						
						_currentStudyList.removeItemAt(_chartIndex);
						deleteAllTrendLines(value);
						break;
						
					}else{
						_chartIndex ++ ;
					}	
					
					
				}
			}		
			
			
			private function createStudyInstance(className:String):Object
			{
				var myClass:Class = getDefinitionByName("sigma.studies." + className) as Class ;
				var instance:Object = new myClass();								
				return instance;
			}
			
			public function get studyList():Boolean
			{ if(_currentStudyList.length > 0 )return true; 
			else return false }
			public function get studyListLength():int{ return _currentStudyList.length; }
			public function get currentStudyList():ArrayCollection{ return _currentStudyList }
			public function set dataBase(val:Array):void{ _allMainChartData = val; }
			public function get dataBase():Array{ return _allMainChartData ; }
			public function set yMin(val:Number):void	{	_yMin = val ;	}
			public function get yMin():Number{	return _yMin ;	}
			public function set yMax(val:Number):void	{	_yMax = val ;	}
			public function get yMax():Number{	return _yMax ;	}
				
			
		}
}