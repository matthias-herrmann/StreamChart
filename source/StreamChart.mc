 module StreamChart {
   using Toybox.Graphics;  
   using Toybox.Math;
   using Axes;
   using ChartInitialization;
 
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
     }
     
     function drawBackground(dc)  {
       dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
       dc.fillRectangle(0, 0, dc.getWidth(), dc.getHeight());
     }
       
   }
 }