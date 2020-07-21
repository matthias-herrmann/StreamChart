module ChartInterpolation {
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
  		for(var i=0; i < self.xsLength; ++i) {
  		  var dx = self.xs[i + 1] - self.xs[i];
  		  var dy = self.ys[i + 1] - self.ys[i];
  		  self.dxs.add(dx);
  		  self.dys.add(dy);
  		  self.ms.add(dy/dx);
  		}
  		
  		// get degree-1 coefficients
  		self.c1s = [self.ms[0]];
  		var dxsLength = self.dxs.size();
  		
  		for(var i=0; i < dxsLength; ++i) {
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
  		self.c1s.add(self.ms[-1]);
  		
  		var c1sLength = self.c1s.size();
  		for(var i=0; i < c1sLength; ++i) {
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