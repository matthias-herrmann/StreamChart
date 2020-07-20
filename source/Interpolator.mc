module ChartInterpolation {
  class Interpolator {
  	
  	private var xs;
  	private var ys;
  	private var dys;
  	private var dxs;
  	private var ms;
  	private var xsLength;
  	private var c1s;
  	
  	// requires 3 points to start with
  	function initialize(xs, ys) {
  		self.xs = xs;
  		self.ys = ys;
  		self.dys = [];
  		self.dxs = [];
  		self.ms = [];
  		self.c1s = [];
  		
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
  	}
  }
}