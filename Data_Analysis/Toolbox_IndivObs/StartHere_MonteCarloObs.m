%% Edited script from Individual Colorimetric Observer Model that generates the simulated observers used in the data analysis
% Code and description: https://www.rit.edu/science/sites/rit.edu.science/files/2019-01/MCSL-Observer_Function_Database.pdf

clear all; 
rng(0); % For repeatability
load ../Answers/ObserverData.mat;
fs = 2; % field size (visual angle in degree)
CountsPerAgeGroup = 14;
list_Age = [ones([1 AgeCounts(1)*CountsPerAgeGroup]) * mean(AgeRanges(1,:)) ones([1 AgeCounts(2)*CountsPerAgeGroup]) * mean(AgeRanges(2,:))...
            ones([1 AgeCounts(3)*CountsPerAgeGroup]) * mean(AgeRanges(3,:)) ones([1 AgeCounts(4)*CountsPerAgeGroup]) * mean(AgeRanges(4,:))...
            ones([1 AgeCounts(5)*CountsPerAgeGroup]) * mean(AgeRanges(5,:)) ]; % age distribution
n_population = length(list_Age);

[LMS_All, var_age, vAll ] = fnc_genMonteCarloObs( n_population, list_Age, fs); 





%% Plot data and store as XYZ
figure; hold on; grid on; 
k = 1; plot(390:5:780, squeeze(LMS_All(:,k,:)), 'Color', 'r', 'LineWidth', 0.001); 
k = 2; plot(390:5:780, squeeze(LMS_All(:,k,:)), 'Color', 'g', 'LineWidth', 0.001); 
k = 3; plot(390:5:780, squeeze(LMS_All(:,k,:)), 'Color', 'b', 'LineWidth', 0.001); 

% LMS to XYZ matrix derived for the 
MatrixRIT = [0.4151 -0.2424 0.0425;
            0.1355 0.0833 -0.0043;
            -0.0093 0.0125 0.2136];

for i = 1:n_population
    Individual_CMFs(:,:,i) = (MatrixRIT * LMS_All(:,:,i)')';
end

save GeneratedCMFs.mat Individual_CMFs;