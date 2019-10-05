 module StreamChart {
   using Toybox.Graphics;
   using StreamChart.Geometry;
 
   class Chart {
     hidden var options;
     hidden var devHeight;
     hidden var devWidth;
     // background of the chart 
     hidden var backgroundColor = Graphics.COLOR_WHITE;
     //content like text and axis
     hidden var contentColor = Graphics.COLOR_BLACK;
     hidden var yChartBottom;
     hidden var xChartLeftOffset;
     hidden var xChartRight;
     
     function initialize(dc, options) {
       self.options = options;
       self.devWidth = dc.getWidth();
       self.devHeight = dc.getHeight();
       calcChartOutline(dc);
     }
     
     hidden function calcChartOutline(dc) {
     	yChartBottom = dc.getHeight() - dc.getHeight() / 3;
     	xChartLeftOffset = dc.getWidth() / 10; 
     	xChartRight = dc.getWidth() - xChartLeftOffset; 
     } 
 
     
     function drawYAxis(dc) {
     
     } 
      
     function drawXAxis(dc) {
       dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
       dc.fillRectangle(0, 0, dc.getWidth(), dc.getHeight());
       var bottomLeft = new Geometry.Point(dc.getWidth()/8, dc.getHeight()/2);
       var bottomRight = new Geometry.Point(dc.getWidth()-dc.getWidth()/8, dc.getHeight()/2);
       var xLine = new Geometry.Line(bottomLeft, bottomRight);
       dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
       xLine.draw(dc);
     }
     
   }
 }