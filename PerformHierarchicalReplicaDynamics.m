function allClusters=PerformHierarchicalReplicaDynamics(data,sigma,clusteringType,blurring)
% performs HMXC.
% data - double 2d matrix with data. each row corresponds to one data point.
% sigma - double vector, with increasing order. The sequence of values of sigma to be used.
% clusteringType - string, either 'MSC','MWC' or 'MPC'. default: 'MSC'
% blurring - boolen scalar. Whether to perform blurring. If true, The gradient on each step will be derived using the current replica points (not initial data points). default: false
% out:
% allClusters - an integer matrix with number of columns as the size of 'sigma', and number of rows as the number of data points. shows the cluster assignment after each full application of of HMXC.

	if ~exist('clusteringType','var') || isempty(clusteringType)
		clusteringType = 'MSC';
	end

	if ~exist('blurring','var') || isempty(blurring)
		blurring = false;
	end

	% additional parameters
	stepSize = 1;
	rep = 100;
	normalizeGradient = false;
	howOftenToTestStop = 11;
	th = 1;

	x = data;
	inds2 = 1:size(data,1);
	allClusters = zeros(size(data,1),0);
	for ii=1:numel(sigma)
		ii

		x = PerformReplicaDynamics(data,sigma(ii),uint16(rep),stepSize,clusteringType,blurring,x,normalizeGradient,howOftenToTestStop);

		clusters = PerformFinalClustering(x,sigma(ii),th);

		x = x(inds2,:);

		clusters = clusters(inds2);
		[~,inds] = sort(accumarray(clusters,1),'descend');
		[~,inds] = sort(inds);
		clusters = inds(clusters);
		[~,inds1,inds2] = unique(clusters);
		x = x(inds1,:);

		allClusters = cat(2,allClusters,clusters);
	end
end