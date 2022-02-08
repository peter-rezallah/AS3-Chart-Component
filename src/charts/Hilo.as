package charts
{
	import charts.series.Element;
	import charts.series.bars.Ehilo;
	
	public class Hilo extends BarBase
	{
		private var negative_colour:Number;
		
		public function Hilo(json:Object, group:Number)
		{
			super(json, group);
			tr.aces('---');
			tr.ace_json(json);
			tr.aces( 'neg', props.has('negative-colour'), props.get_colour('negative-colour'));
		}
		
		protected override function get_element( index:Number, value:Object ): Element {
			
			var default_style:Properties = this.get_element_helper_prop( value );	
			if(this.props.has('negative-colour'))
				default_style.set('negative-colour', this.props.get('negative-colour'));
			
			return new Ehilo( index, default_style, this.group );
		}
	}
}