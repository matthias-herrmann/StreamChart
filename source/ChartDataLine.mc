module StreamChart{ 

 using Toybox.Graphics; 
 using MathHelpers as Mh;
 using Geometry as Geo;
 
 class ChartDataLine {
  
  var yRelativePixels = new [50];
  var allObservedValues = new [50];
  var minObservedValue;
  var maxObservedValue;
  var maxY;
  var minY;
  var minX;
  var xAxis;
  var yAxis;
   
  function initialize(allObservedValues, corners, xAxis, yAxis) {
    maxY = corners["topLeftCorner"].y.toDouble();
    minY = corners["bottomLeftCorner"].y.toDouble();
    minX = corners["bottomLeftCorner"].x.toDouble();
    
    self.xAxis = xAxis;
    self.yAxis = yAxis;
  
    self.allObservedValues = allObservedValues;
    calcObservedValuesMinMax();
    calcYRelativePixels(); 
  }
  
  function calcObservedValuesMinMax() {
  	maxObservedValue = Mh.getMaxValueInArray(allObservedValues).toDouble();
    minObservedValue = Mh.getMinValueInArray(allObservedValues).toDouble();
  }
  
  function calcYRelativePixels() {
  	 for(var i=0; i < 50; ++i) {
     	var observedValue = allObservedValues[i];          
        // coordinate system starts with 0, 0 in the upper left corner of the device screen => min and max swapped for y                             
        yRelativePixels[i] = Mh.scaleValIntoRange(observedValue, minObservedValue, maxObservedValue, maxY+(yAxis.getLengthInPixels()/4), minY);                                
     }  
  }
  
  function draw(dc) {
    dc.setColor(Graphics.COLOR_GREEN, Graphics.COLOR_GREEN);
     // construct and draw lines
        for(var i=1; i < 50; ++i) {
          var x1 = minX + xAxis.getLengthInPixels() * ((i - 1) / 50.0d);                  
          var x2 = minX + xAxis.getLengthInPixels() * (i / 50.0d);
            
          var y1 = yRelativePixels[i-1];
          var y2 = yRelativePixels[i];
                             
          var point1 = new Geo.Point(x1, y1);
          var point2 = new Geo.Point(x2, y2);
          var line = new Geo.Line(point1, point2);    
          line.draw(dc);   
        }   
  }
  
 }
}