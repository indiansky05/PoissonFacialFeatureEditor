function [ r, g, b ] = decomposeRGB( croppedImg )
% Code adapted from the Computer Graphics Group at Technische Universität
% Berlin and Merza Klaghstan
%------------------------------------
% source image - croppedImg
% [r,g,b] returned -- separate color channels for source image
%------------------------------------

%------------------------------------
% Decomposition of source image into three color channels
%------------------------------------
r = croppedImg(:, :, 1);
g = croppedImg(:, :, 2);
b = croppedImg(:, :, 3);
end