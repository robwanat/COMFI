function [ CMFs_LMS_CatObs, Age_CatObs, pFctr_CatObs ] = fnc_getCatObs( n_cat,fs )
% 

files.rmd = importdata('cie2006_RelativeMacularDensity.txt');
files.LMSa = importdata('cie2006_Alms.txt');
files.docul = importdata('cie2006_docul.txt');

% Use Iteratively Derived Cat.Obs.
t_data = csvread(sprintf('CatObsPfctr.csv')); 
Age_CatObs = t_data(1,1:n_cat); 
pFctr_CatObs = t_data(2:9,1:n_cat)'; 


CMFs_LMS_CatObs = nan(79,3,n_cat); 
for k = 1:n_cat
[ LMS, ~, ~, ~ ] = cie2006cmfsEx( Age_CatObs(k),fs, ...
    pFctr_CatObs(k,1), pFctr_CatObs(k,2), pFctr_CatObs(k,3), pFctr_CatObs(k,4), ...
    pFctr_CatObs(k,5), pFctr_CatObs(k,6), pFctr_CatObs(k,7), pFctr_CatObs(k,8), files ); 
    % LMS = interp1(390:5:780,LMS,380:1:780,'spline'); 
CMFs_LMS_CatObs(:,:,k) = LMS; 
end
CMFs_LMS_CatObs(CMFs_LMS_CatObs<0) = 0; 


end

