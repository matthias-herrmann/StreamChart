module StreamChart {
  module Geometry {
  class Point {
     var x;
     var y; 
      
     function initialize(x, y) {
       self.x = x;
       self.y = y;
     }
   }
   
   class Line {
     var startPoint;
     var endPoint;
     
     function initialize(startPoint, endPoint) {
       self.startPoint = startPoint;
       self.endPoint = endPoint;
     }
     
     function draw(dc) {
       dc.drawLine(startPoint.x, startPoint.y, endPoint.x, endPoint.y);
     }
   }
   }
}