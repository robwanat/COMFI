Code used to analyze the experimental data and produce the plots in the paper.

Folder contents:

SharedFunctions - Various functions used for calculations, color space conversions and plotting.
Add this folder to the path before running the code in any other subfolders of this folder.

Answers - Analyze the observer answers and pre-compute the AnswerData.mat file
used for plotting. Also contains the information about the experiment participants
and functions for plotting additional information about the experimental answers.

DisplayMeasurements - A local copy of the display measured spectra, identical
to the one in the ../Experiment_Data/Spectra folder.

OMFI - Functions for calculating the OMFI predicted data based on simulated
observers. Pre-computes OMFIData.mat file used for plotting and the *_POMIMap.mat
files used for rendering COMFI maps. 

PreparePlots - Functions used to generate the Figures in the paper and supplementary
materials.

Toolbox_IndivObs - Functions provided by RIT that generate the 518 individual observer
CMFs used to calculate COMFI.

GeneratedCMFs - File containing the 518 generated CMFs used to calculate COMFI.