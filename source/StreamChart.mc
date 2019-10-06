 module StreamChart {
   using Toybox.Graphics;  
   using Toybox.Math;
   using Geometry;
   using Axes;
 
   class Chart {
     hidden var options;
     
     // device dimensions
     hidden var devHeight;
     hidden var devWidth;
     
     // colors 
     hidden var backgroundColor = Graphics.COLOR_WHITE;     
     hidden var contentColor = Graphics.COLOR_BLACK;
                
     // axis                         
     hidden var xAxis;
     hidden var yAxis;     
     
     // chart corners for axis creation
     hidden var bottomLeftCorner;
     hidden var topLeftCorner;
     hidden var bottomRightCorner;
     
     function initialize(dc, options) {         
       self.options = options;
       self.devWidth = dc.getWidth();
       self.devHeight = dc.getHeight();
       calcChartOutline(dc);
       createAxis();
     }
     
     hidden function calcChartOutline(dc) {     
     	var devMidpoint = new Geometry.Point(devWidth/2, devHeight/2);
     	var radiusWithMargin = devWidth / 2 - devWidth / 20;     	
     	var widthToHeightRad = Math.atan(0.75);
          	     	
     	var leftX = Math.cos(Math.PI - widthToHeightRad) * radiusWithMargin + devMidpoint.x; 
     	var rightX = Math.cos(2 * Math.PI - widthToHeightRad) * radiusWithMargin + devMidpoint.x;
     	var topY = Math.sin(2 * Math.PI - widthToHeightRad) * radiusWithMargin + devMidpoint.y;          	
     	topLeftCorner = new Geometry.Point(leftX, topY);
     	     	
        var bottomY = Math.sin(2 * Math.PI + widthToHeightRad) * radiusWithMargin + devMidpoint.y;
      	bottomLeftCorner = new Geometry.Point(leftX, bottomY);    
      	bottomRightCorner = new Geometry.Point(rightX, bottomY);               	     	         
     } 
     
     function createAxis() {
     	xAxis = new Axes.XAxis(bottomLeftCorner, bottomRightCorner);
     	yAxis = new Axes.YAxis(bottomLeftCorner, topLeftCorner);    
     }
     
     function draw(dc) {
        drawBackground(dc);
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
     	xAxis.draw(dc);
     	yAxis.draw(dc);
     }
     

     function drawBackground(dc)  {
       dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
       dc.fillRectangle(0, 0, dc.getWidth(), dc.getHeight());
     }
       
   }
 }