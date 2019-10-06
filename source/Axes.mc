module Axes {
  using Geometry;
 
  class Axis {
    // axis is defined by a line in between two poitns
	protected var line;
		
    function draw(dc) {
      dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
      line.draw(dc);
    }	
    
    function getLengthInPixel() {
       return line.getLengthInPixels();   
    }	
		
    function initialize(p1, p2) {
      line = new Geometry.Line(p1, p2);
    }
		
  }
		
   // classes for strong typing
  class XAxis extends Axis {
     
    function initialize(p1, p2) {
	  Axis.initialize(p1, p2);
     }
   }
		
		
  class YAxis extends Axis {
    
    function initialize(p1, p2) {
      Axis.initialize(p1, p2);
	}
   }	
	
}