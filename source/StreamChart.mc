 module StreamChart {
   using Toybox.Graphics;  
   using Toybox.Math;
   using Axes;
   using ChartInitialization;
   using Toybox.System;
   using Geometry as Geo;
   using MathHelpers as Mh;
 
   class Chart {
     hidden var options;
             
     // axis                         
     hidden var xAxis;
     hidden var yAxis;
          
     // dimensions
     hidden var corners;
     hidden var deviceScreenInfo;
          
     function initialize(dc, options) {         
       self.options = options;       
       deviceScreenInfo = ChartInitialization.createDeviceScreenInfo(dc);
       corners = ChartInitialization.createCorners(deviceScreenInfo);
       createAxis();
     }
     
     function createAxis() {
     	xAxis = new Axes.XAxis(corners["bottomLeftCorner"], corners["bottomRightCorner"]);
     	yAxis = new Axes.YAxis(corners["bottomLeftCorner"], corners["topLeftCorner"]);    
     }
     
     
     function draw(dc) {            
        drawBackground(dc);        
     	     
     	var maxY = corners["topLeftCorner"].y.toDouble();
     	var minY = corners["bottomLeftCorner"].y.toDouble();
     	var minX = corners["bottomLeftCorner"].x.toDouble();     	    	
     	
     	var allObservedValues = new [50];
     	var yRelativePixels = new [50];
        
     	for(var i=0; i < 50; ++i) {     		
     		var rand = Math.rand() % 200 + 1;
     		allObservedValues[i] = rand.toDouble();     		     		
     	}      	     	
     	
     	var maxObservedValue = Mh.getMaxValueInArray(allObservedValues).toDouble();
     	var minObservedValue = Mh.getMinValueInArray(allObservedValues).toDouble();
                
        for(var i=0; i < 50; ++i) {
          var observedValue = allObservedValues[i];          
          // coordinate system starts with 0, 0 in the upper left corner of the device screen => min and max swapped for y                             
          yRelativePixels[i] = Mh.scaleValIntoRange(observedValue, minObservedValue, maxObservedValue, maxY, minY);                                
        }   
                
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
        xAxis.draw(dc);
     	yAxis.draw(dc);                                         
     }
     
     function drawBackground(dc)  {
       dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
       dc.fillRectangle(0, 0, dc.getWidth(), dc.getHeight());
     }
       
   }
 }