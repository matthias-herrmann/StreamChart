module Axes {
  using Geometry;
  using Toybox.System;
 
  class Axis {
    // axis is defined by a line in between two poitns
	protected var line;
	protected var subdivisionLines=[]; 
			
    function draw(dc) {
      dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
      line.draw(dc);
      drawSubDivisionLines(dc);
    }	
    
    function getLengthInPixels() {
       return line.getLengthInPixels();   
    }	
		
    function initialize(p1, p2) {
      line = new Geometry.Line(p1, p2);
    }
    
    function drawSubDivisionLines(dc) {
      for(var i=0; i < subdivisionLines.size(); ++i) {
        subdivisionLines[i].draw(dc);
      }
    }
  }
		
   // classes for strong typing
  class XAxis extends Axis {
  
     function genSubDivsionLines() {
       var originX = line.getStartPoint().x;
       var bottomY = line.getStartPoint().y; 
       
       for(var i=1; i < 4; ++i) {
         var xPointOfLine = originX + (i/4.0d) * getLengthInPixels();
         var subdivisionLine = new Geometry.Line(
         						   new Geometry.Point(xPointOfLine, bottomY),
         						   new Geometry.Point(xPointOfLine, bottomY - 10)
         						   );
         subdivisionLines.add(subdivisionLine);
       }
     }
    
       
    function initialize(p1, p2) {
	  Axis.initialize(p1, p2);
	  self.genSubDivisionLines();
     }
         
   }
		
		
  class YAxis extends Axis {
    
    function initialize(p1, p2) {
      Axis.initialize(p1, p2);
	}
	
	function genSubDivisionLines() {
	
	}
   }	
	
}