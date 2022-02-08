package sigma.studies
{
	import mx.formatters.DateFormatter;
	import mx.messaging.messages.ErrorMessage;

	public class Functions
	{
		
		public static function getSmaValue(startIndex:int,arr:Array, period:int , property:String="value" ):Number
		{
			var smaValue:Number = 0 ;
			var mk:int = 0 ;
			/* trace("***************************************************************"); */
			/* trace("starting from ="+startIndex+" to " + period + startIndex ) ; */
			
			for ( var i:int=startIndex ; i < period + startIndex ; i++)
			{
				/* trace("piont("+i+") time = " + smaValue + value.main['elements'][0].values[i].timeStamp); */	
				if(arr[i] != null ){	smaValue = smaValue + arr[i][property] ; mk ++ ;}
				else continue ;
				
			}
			/* trace("***************************************************************"); */
			smaValue = smaValue / mk ; 
			//smaIndex = startIndex ;
			//macdIndex = startIndex ;
			//macdFIndex = startIndex;
			//fastostSmaIndex = startIndex ;
			//slowostSmaIndex = startIndex ;
			//slowostSma2Index = startIndex ;
			
			
			return smaValue;
			
		}
		
		public static function getEmaValue(startIndex:int , priceArray:Array , lookArray:Array , period:int , property:String = "value"):Number
		{				
			var emaValue:Number = 0 ;
			var multiple:Number = 2/(period + 1) ;
			
			
			emaValue = ( multiple * ( priceArray[startIndex][property] - lookArray[startIndex-1][property]))+ lookArray[startIndex-1][property] ;
			/* trace("*** emaValue = " + value.main['elements'][0].values[startIndex].value ) ; */
			
			
			//macdIndex = startIndex ;
			//macdFIndex = startIndex;
			
			return emaValue ;
			
		}
		
		
		public static function returnDateDay(s:String):String
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
				var h:String = timeStr[0];
				var mn:String = timeStr[1];
				var se:String = timeStr[2];
			}
			catch(e:ErrorMessage)
			{
				h ="00";
				mn="00";
				se="00";
			}
			var cDate:Date = new Date(y,m-1,d,h,mn,se,0);
			return m-1+"/"+d+"/"+y ;
		}
		
		public static function returnLabel(s:String,duration:String):String
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
				var h:String = timeStr[0];
				var mn:String = timeStr[1];
				var se:String = timeStr[2];
			}
			catch(e:ErrorMessage)
			{
				h ="00";
				mn="00";
				se="00";
			}
			
			var cDate:Date = new Date(y,m-1,d,h,mn,se,0);
			var dateFormatter:DateFormatter = new DateFormatter();
			dateFormatter.formatString = "MM//YY" ;
			dateFormatter.format(cDate);
			
			switch(duration)
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
		
		
		
		public static function get_steps(min:Number, max:Number, height:Number):Number {
			// try to avoid infinite loops...			
			
			
			// how many steps (grid lines) do we have?
			var steps:Number = 0.00;
			
			/* if( max - min > 0.00 && max - min < 0.05 ) steps = 0.01 ;  
			if( max - min >= 0.05 && max - min < 0.09 ) steps = 0.02 ;
			if( max - min > 0.00 && max - min < 0.05 ) steps = 0.01 ; */ 
			if(min < 0 )
			{
				if( min - max >= -0.009 && min - max < -0.0099  ) steps = 0.000099 ;
				if( min - max >= -0.009 && min - max < -.09 ) steps = 0.00099 ;  
				if( min - max >= -0.09 && min - max < 0.00 ) steps = 0.0099 ;
			}else{
				
				if( max - min > 0.00 && max - min < 0.05 ) steps = 0.01 ;  
				if( max - min >= 0.05 && max - min < 0.09 ) steps = 0.02 ;
				if( max - min >= 0.09 && max - min < 9.99 ) steps = (max - min) / 5;
				if( max - min >= 9.99 && max - min < 19.99 ) steps = 1 ;
				if( max - min >= 19.99 && max - min < 29.99 ) steps = 2 ;
				if( max - min >= 29.99 && max - min < 49.99 ) steps = 5 ;
				if( max - min >= 49.99 && max - min < 99.99 ) steps = 10 ;
				if( max - min >= 99.99 && max - min < 999.99 ) steps = 20 ;
				if( max - min >= 999.99 && max - min < 9999.99) steps = 30 ;
				if( max - min >= 9999.99 && max - min < 99999.99) steps = 10000 ;
				if( max - min >= 99999.99 && max - min < 999999.99) steps = 100000 ;
				if( max - min >= 999999.99 && max - min < 9999999.99) steps = 1000000 ;
				
			}
			
			var s:Number = (max - min) / steps;
			
			if ( s > (height/2) ) {
				// either no steps are set, or they are wrong and
				// we have more grid lines than pixels to show them.
				// E.g: 
				//      max = 1,001,000
				//      min =     1,000
				//      s   =   200,000
				return (max - min) / 5;
			}			
			return steps;
		}
	}
}