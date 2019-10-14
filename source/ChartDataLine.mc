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
  var maxX;
  var xAxis;
  var yAxis;
   
  function initialize(allObservedValues, corners, xAxis, yAxis) {
    maxY = corners["topLeftCorner"].y.toDouble();
    minY = corners["bottomLeftCorner"].y.toDouble();
    minX = corners["bottomLeftCorner"].x.toDouble();
    maxX = corners["bottomRightCorner"].x.toDouble();
    
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
    dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);

     // construct and draw lines
    for(var i=0; i < 49; ++i) {
      // for the first point the x coordinate is in the origin
      var x1 = minX + xAxis.getLengthInPixels() * (i / 49.0d);                                   
      var y1 = yRelativePixels[i];
      var x2 = minX + xAxis.getLengthInPixels() * ((i+1) / 49.0d);    
      var y2 = yRelativePixels[i+1];
      dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
      dc.drawLine(x1, y1, x2, y2);  
      dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_RED);  
      dc.fillPolygon([[x1, minY], [x1, y1], [x2, y2], [x2, minY]]);    
    }
  }  
 }
}