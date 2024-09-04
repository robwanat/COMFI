function [ICTCP] = XYZ2ICtCp(XYZ)
%XYZ is nx3
%taken from dolby white paper code appendix https://www.dolby.com/us/en/technologies/dolby-vision/measuring-perceptual-color-volume.pdf

invEOTF = @(Lin) (((3424/4096)+(2413/128)*(max(0,Lin)/10000).^(2610/16384)) ./ ...
 (1+(2392/128)*(max(0,Lin)/10000).^(2610/16384))).^(2523/32);

XYZ2LMSmat = [0.3593 -0.1921 0.0071; 0.6976 1.1005 0.0748; -0.0359 0.0754 0.8433];
LMS2ICTCPmat = [2048 2048 0; 6610 -13613 7003; 17933 -17390 -543]'/4096;
ICTCP = invEOTF(XYZ*XYZ2LMSmat)*LMS2ICTCPmat;
end