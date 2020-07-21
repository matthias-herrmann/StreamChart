module MathHelpers {

   function slope(x1, y1, x2, y2) {
     return (y2 - y1) / (x2 - x1);
   }

   function normalizeValues(val, minObserved, maxObserved) {
       return (val - minObserved) / (maxObserved - minObserved);
   }
   
   function scaleValIntoRange(val, maxObserved, minObserved, lowerBoundary, upperBoundary) {
       return (upperBoundary - lowerBoundary) * ((val - minObserved) / (maxObserved - minObserved)) + lowerBoundary;
   }
   
   function max(val, otherVal) {
     if (otherVal > val) {
     	return otherVal;
     } 
     return val;
   }
     
   function getMaxValueInArray(array) {
     var maxSeen = null;
     
     for(var i=0; i < array.size(); ++i) {
        if(maxSeen == null) {
          maxSeen = array[i];                 
        }
        else if(maxSeen < array[i]) {
          maxSeen = array[i];          
        }                              
     }  
     return maxSeen;  
   }  
   
   function getMinValueInArray(array) {
   	 var minSeen = null;
     
     for(var i=0; i < array.size(); ++i) {
        if(minSeen == null) {
          minSeen = array[i];                 
        }
        else if (minSeen > array[i]) {          
          minSeen = array[i];          
        }                              
     }
     return minSeen;     
   }    
}
