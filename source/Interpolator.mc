module ChartInterpolation {
  using Toybox.Math; 
  using MathHelpers as Mh;
  
  class Interpolator {
  	
  	private var xs;
  	private var ys;
  	private var dys;
  	private var dxs;
  	private var ms;
  	private var xsLength;
  	private var c1s;
  	private var c2s;
  	private var c3s;
  	
  	function add(x, y) {
  	  var prevLastXIndex = self.xsLength - 1;
  	  self.xs.add(x);
  	  self.ys.add(y);
  	  
  	  self.xsLength += 1;
  	  var dx = x - self.xs[self.xsLength - 2];
  	  var dy = y - self.ys[self.xsLength - 2];
  	  self.dys.add(dy);
  	  self.dxs.add(dx);
  	  self.ms.add(dy/dx);
  	  var secondLastM = self.ms[prevLastXIndex - 1];
  	  var lastM = self.ms[prevLastXIndex];
  	  
  	  // coefficient 1
  	  if (secondLastM * lastM < 0) {
  	  	self.c1s.add(0);
  	  }
  	  else {
  	    var secondLastDx = self.dxs[prevLastXIndex];
  	    var lastDx = dx;
  	    var common = secondLastDx + lastDx;
  	    self.c1s.add(3*common/((common + dx)/secondLastM + (common + secondLastDx)/lastM)); 
  	  }
  	  
  	  // degree 2 and 3
  	  var secondLastC1 = self.c1s[prevLastXIndex];
  	  var lastC1 = self.c1s[prevLastXIndex+1];
  	  
  	  var invDx = 1/self.dxs[prevLastXIndex];
  	  // TODO: check if lastM - lastM is correct
  	  var common_ = secondLastC1 + lastC1 - lastM - lastM;
  	  self.c1s.add((lastM - secondLastC1 - common_)*invDx);
  	  self.c3s.add(common_*invDx*invDx);
  	}
  	
  	function interpolate(x) {
  	  var i = self.xsLength - 1;
  	  // the rightmost point in the database should give
  	  // an exact result
  	  if(x == self.xs[i]) {
  	    return self.ys[i];
  	  }
  	  
  	  // search for the interval x is in,
  	  // returning the correspoinding y if x is one of the
  	  // original xs
  	  var low = 0;
  	  var c3sLength = self.c3s.size();
  	  var mid = c3sLength - 1;
  	  var high = c3sLength - 1;
  	  while (low <= high) {
  	    var mid = Math.floor(0.5*(low + high));
  	    var xHere = self.xs[mid];
  	    if (xHere < x) {
  	      var low = mid + 1;
  	    } else if (xHere > x) {
  	      var high = mid - 1;
  	    } else {
  	       return self.ys[mid];
  	    }
  	  }
  	 
  	  i = Mh.max(0, high);
  	  
  	  // interpolate
  	  var diff = x - self.xs[i];
  	  var diffSq = diff * diff;
  	  
  	  return self.ys[i] + self.c1s[i]*diff + self.c2s[i]*diffSq\
  	      + self.c3s[i]*diff*diffSq;
  	} 
  	
  	// requires 3 points to start with
  	function initialize(xs, ys) {
  		self.xs = xs;
  		self.ys = ys;
  		self.dys = [];
  		self.dxs = [];
  		self.ms = [];
  		self.c1s = [];
  		self.c2s = [];
  		self.c3s = [];
  		
  		self.xsLength = xs.size();
  		
  		// consecutive differences and slopes
  		for(var i=0; i < self.xsLength - 1; ++i) {
  		  var dx = self.xs[i + 1] - self.xs[i];
  		  var dy = self.ys[i + 1] - self.ys[i];
  		  self.dxs.add(dx);
  		  self.dys.add(dy);
  		  self.ms.add(dy/dx);
  		}
  		
  		// get degree-1 coefficients
  		self.c1s = [self.ms[0]];
  		var dxsLength = self.dxs.size();
  		
  		for(var i=0; i < dxsLength - 1; ++i) {
  			var m = self.ms[i];
  			var mNext = self.ms[i + 1];
  			if(m*mNext <= 0) {
  			  self.c1s.add(0);
  			} else {
  			  var dx_ = self.dxs[i];
  			  var dxNext = self.dxs[i + 1];
  			  var common = dx_ + dxNext;
  			  self.c1s.add(3*common/((common + dxNext)/m + (common + dx_)/mNext));
  			}
  		}
  		
  		// TODO: Check if -1 works as expected
  		var lastM = self.ms[ms.size() - 1];
  		self.c1s.add(lastM);
  		
  		var c1sLength = self.c1s.size();
  		for(var i=0; i < c1sLength - 1; ++i) {
  		  var c1 = self.c1s[i];
  		  var m_ = self.ms[i];
  		  var invDx = 1/self.dxs[i];
  		  var common_ = c1 + self.c1s[i + 1] - m_ - m_;
  		  self.c2s.add((m_ - c1 - common_)*invDx);
  		  self.c3s.add(common_*invDx*invDx);
  		}
  	}
  }
}