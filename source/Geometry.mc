module Geometry {
  using Toybox.Math;

  class Point {
     var x;
     var y; 
      
     function initialize(x, y) {
       self.x = x.toDouble();
       self.y = y.toDouble();
     }
     
     function distanceTo(otherPoint) {
        // formula for calculating distance between two points in 2D space
      	return Math.sqrt(Math.pow(x - otherPoint.x, 2) + Math.pow(y - otherPoint.y, 2));
     }
   }
   
   class Line {
     private var startPoint;
     private var endPoint;
     private var lengthInPixels;
          
     function initialize(startPoint, endPoint) {
       self.startPoint = startPoint;
       self.endPoint = endPoint;
       lengthInPixels = endPoint.distanceTo(startPoint);
     }
     
     function getLengthInPixels() {
       return lengthInPixels; 
     }
     
     function getStartPoint() {
       return startPoint;
     }
     
     function getEndPoint() {
       return endPoint;
     }
     
     function draw(dc) {
       dc.drawLine(startPoint.x, startPoint.y, endPoint.x, endPoint.y);
     }
   }
}
