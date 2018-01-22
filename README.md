This Matlab code can be used to reproduce experiments reported in the paper [The Weight-Shape Decomposition of Density Estimates: A Framework for Clustering and Image Analysis Algorithms](about:blank) (link will be provided shortly).



##### To Reproduce Figure 1:

Run `fig1.m`.  The first two lines can be used to control which of the graphs will be generated



##### To Reproduce Figure 2:

Run `fig2.m`



##### To Reproduce the Crabs Experiments:

Run `PerformReplicaDynamics.m`  on the data from the file `crabs.csv`, after projecting the data onto PC2 and PC3. 

To obtain the final cluster association, run `PerformFinalClustering.m`



##### To Reproduce the Asteroid Experiments

Two alternatives to obtain the data:

1. Download all spectra data from http://smass.mit.edu/catalog.php, and preprocess each spectrum using `PreprocessSpectrum.m`, which makes sure all spectra have a common sampling grid, and which performs some additional preprocessing steps.
2. Instead, you can use the matrix `data` in the file `asteroid_data.mat`.

Then, run `PerformHierarchicalReplicaDynamics.m`  on the data.



##### To Reproduce Figures 6 and 7:

Run `fig6.m` and `fig7.m`.