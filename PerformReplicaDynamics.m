function [x,xHistory] = PerformReplicaDynamics(data,sigma,rep,stepSize,clusteringType,blurring,dataInitialPosition,normalizeGradient,howOftenToTestStop)
% performs gradient descent on data using parzen estimator or shape or weight.
% data - double 2d matrix with data. each row corresponds to one data point.
% sigma - double scalar, the parameter that appears in the Parzen estimator.
% rep - integer scalar, maximal number of steps of gradient descent. default: 1000
% stepSize - double scalar,  gradient will be multiplied by this number to perform each gradient descent step. default: 'sigma/7'
% clusteringType - string, either 'MSC','MWC' or 'MPC'. default: 'MSC'
% blurring - boolen scalar. Whether to perform blurring. If true, The gradient on each step will be derived using the current replica points (not initial data points). default: false
% dataInitialPosition - double matrix with same column number as 'data'. Each row is a point to be moved by the gradients. If empty, 'data' will be used. default: 'data'
% normalizeGradient - boolean scalar. The gradient is normalized to unit norm before multiplied by 'stepSize'. default: false
% howOftenToTestStop - integer scalar. once every how many steps to check stopping condition. default: 10
% out:
% x - the replica points after gradient descent evolution.
% optional output: xHistory - a 3d matrix with size [size(x,1),size(x,2),rep]. xHistory(:,:,ii) contains the points after the (ii-1)'th step of gradient descent.


	if ~exist('stepSize','var') || isempty(stepSize)
		stepSize = sigma/7;
	end
	
	if ~exist('rep','var') || isempty(rep)
		rep = 1000;
	end
	
	if ~exist('clusteringType','var') || isempty(clusteringType)
		clusteringType = 'MSC';
	end
	
	if ~exist('blurring','var') || isempty(blurring)
		blurring = false;
	end
	
	if ~exist('dataInitialPosition','var') || isempty(dataInitialPosition)
		dataInitialPosition = data;
	end
	
	if ~exist('normalizeGradient','var') || isempty(normalizeGradient)
		normalizeGradient = true;		
	end
	
	if ~exist('howOftenToTestStop','var') || isempty(howOftenToTestStop)
		howOftenToTestStop = 10;
	end
	

	switch clusteringType
		case 'MSC'
			maximizeEntropy = false;
			maximizeWaveFunction = false;			
		case 'MWC'
			maximizeEntropy = true;
			maximizeWaveFunction = false;			
		case 'MPC'
			maximizeEntropy = false;
			maximizeWaveFunction = true;			
	end
	
	x = dataInitialPosition;
	if (nargout>=2)
		xHistory = zeros(size(x,1),size(x,2),rep+1);
		xHistory(:,:,1) = x;
	end
	
	prevLocation = inf(size(x));
	
	% these are the indices of replicas that are currently sill moving
	inds = 1:size(x,1);
	
	% master loop
	v = zeros(size(x));
	for ii=1:rep
		if blurring
			if maximizeEntropy
				[S,dx] = FindEntropy(x(inds,:),sigma,x(inds,:));
				if normalizeGradient
					dx = normr(dx);
				end
				x(inds,:) = x(inds,:) + stepSize*dx;
				V = -1*S;
			elseif maximizeWaveFunction
				[P,dx] = FindParzen(x(inds,:),sigma,x(inds,:));
				if normalizeGradient
					dx = normr(dx);
				end
				x(inds,:) = x(inds,:) + stepSize*dx;
				V = -1*P;
			else
				[V,dx] = FindAverageEnergy(x(inds,:),sigma,x(inds,:));	
				if normalizeGradient
					dx = normr(dx);
				end
				v = 0.0*v(inds,:)+stepSize*dx;
				x(inds,:) = x(inds,:) - v;
				V = V;
			end
		else
			if maximizeEntropy
				[S,dx] = FindEntropy(data,sigma,x(inds,:));
				if normalizeGradient
					dx = normr(dx);
				end
				v(inds,:) = 0.0*v(inds,:)+stepSize*dx;
				x(inds,:) = x(inds,:) + v(inds,:);
				V = -1*S;
			elseif maximizeWaveFunction
				[P,dx] = FindParzen(data,sigma,x(inds,:));
				if normalizeGradient
					dx = normr(dx);
				end
				x(inds,:) = x(inds,:) + stepSize*dx;
				V = -1*P;
			else
				[V,dx] = FindAverageEnergy(data,sigma,x(inds,:));
				if normalizeGradient
					dx = normr(dx);
				end
				x(inds,:) = x(inds,:) -  stepSize*dx;
				V = V;
			end
		end

		if (nargout>=2)
			xHistory(:,:,ii+1) = x;
		end	
		
		if (~blurring) && (mod(ii,howOftenToTestStop)==0)
			numel(inds)
			prevInds = inds;
			inds = inds(sum((x(inds,:)-prevLocation(inds,:)).^2,2)>0.001);
			if isempty(inds)
				break;
			end
			prevLocation(prevInds,:) = x(prevInds,:);
		end
	end
	if (nargout>=2)
		xHistory = xHistory(:,:,1:(ii+1));
	end
end