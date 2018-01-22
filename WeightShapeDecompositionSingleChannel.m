function [p,w,s] = WeightShapeDecompositionSingleChannel(im,sigma,sz)
% im - a single channel image
% sigma - given in pixel units
% sz - size of filter, in units of sigma
% p,w,s - psi, weight and shape

	% convert sz to pixel units, and make maximum 10
	sz = ceil(sz*sigma);
	sz = max(sz,10);
	
	% create filter kernel
	x = [(-sz):sz]';
	y = x;
	r_squared = bsxfun(@plus,x.^2,(y.').^2);
	E = r_squared/(2*sigma^2);
	g = exp(-1*E);
	kernel = g;
	
	p = filter2(kernel,im,'same'); % 'full','same','valid'
	
	if nargout > 1

		kernel2 = kernel.*E;
				
		v = filter2(kernel2,im,'same')./p; % 'full','same','valid'

		h = v+log(p);

		w = exp(h);

		s = exp(-v);
	end
end
