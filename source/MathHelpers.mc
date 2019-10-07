module MathHelpers {

   function scaleValIntoRange(val, maxObserved, minObserved, lowerBoundary, upperBoundary) {
       return (upperBoundary - lowerBoundary) * ((val - minObserved) / (maxObserved - minObserved)) + lowerBoundary;
   }
     
   function getMaxValueInArray(array) {
     var maxSeen = null;
     
     for(var i=0; i < array.size(); ++i) {
        if(maxSeen == null) {
          maxSeen = array[i];                 
        }
        else {
          if( maxSeen < array[i]) {
            maxSeen = array[i];
          }
        }
        
      return maxSeen;                
     }    
   }  
   
   function getMinValueInArray(array) {
   	 var minSeen = null;
     
     for(var i=0; i < array.size(); ++i) {
        if(minSeen == null) {
          minSeen = array[i];                 
        }
        else {
          if( minSeen > array[i]) {
            minSeen = array[i];
          }
        }
        
      return minSeen;                
     }  
   
   }    
}
