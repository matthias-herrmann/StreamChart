 module StreamChart {
   using Toybox.Graphics;  
   using Toybox.Math;
   using Axes;
   using ChartInitialization;
   using Toybox.System;
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
     	xAxis.draw(dc);
     	yAxis.draw(dc); 
     	
     	// coordinate system starts with 0, 0 in the upper left corner of the device screen
     	var minY = corners["topLeftCorner"];
     	var maxY = corners["bottomLeftCorner"];
     	
     	var allObservedValues = [];
     	var yPixelValues = [];
        
     	for(var i=0; i < 50; ++i) {     		
     		var rand = Math.rand() % 200 + 1;
     		allObservedValues.add(rand);     		     		
     	}      	     	
     	
     	var maxObservedValue = Mh.getMaxValueInArray(allObservedValues);
     	var minObservedValue = Mh.getMinValueInArray(allObservedValues);
        
        for(var i=0; i < 50; ++i) {
          // var yValScaled = Mh.scaleValIntoRange(allObservedValues[i], maxObservedValue, minObservedValue, 0, 200);
          // yPixelValues.add(yValScaled);
        }                   
     }
     
     function drawBackground(dc)  {
       dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
       dc.fillRectangle(0, 0, dc.getWidth(), dc.getHeight());
     }
       
   }
 }