module ChartInitialization {
   using Toybox.Math;

   function createDeviceScreenInfo(dc) {     
     var devHeight = dc.getHeight();
     var devWidth = dc.getWidth();
     var devMidpoint = new Geometry.Point(devWidth/2, devHeight/2);
     
     return { "devMidpoint" => devMidpoint,
              "devWidth" => devWidth, 
              "devHeight" => devHeight };
   }

   // calculating outer points of chart
   function createCorners(deviceScreenInfo) {
     var devWidth = deviceScreenInfo["devWidth"];
     var devHeight = deviceScreenInfo["devHeight"];
     
     var devMidpoint = new Geometry.Point(devWidth/2, devHeight/2);
     var radiusWithMargin = devWidth / 2 - devWidth / 20;     	
     var widthToHeightRad = Math.atan(0.75);
          	     	
     var leftX = Math.cos(Math.PI - widthToHeightRad) * radiusWithMargin + devMidpoint.x; 
     var rightX = Math.cos(2 * Math.PI - widthToHeightRad) * radiusWithMargin + devMidpoint.x;
     var topY = Math.sin(2 * Math.PI - widthToHeightRad) * radiusWithMargin + devMidpoint.y;          	
     var topLeftCorner = new Geometry.Point(leftX, topY);
     	     	
     var bottomY = Math.sin(2 * Math.PI + widthToHeightRad) * radiusWithMargin + devMidpoint.y;
     var bottomLeftCorner = new Geometry.Point(leftX, bottomY);    
     var bottomRightCorner = new Geometry.Point(rightX, bottomY);      
     
     return { "bottomLeftCorner" => bottomLeftCorner, 
              "bottomRightCorner" => bottomRightCorner, 
              "topLeftCorner" => topLeftCorner };         	     	   
   }
}