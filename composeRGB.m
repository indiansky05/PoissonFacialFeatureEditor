function [ image ] = composeRGB( r, g, b )
% Code adapted from the Computer Graphics Group at Technische Universitšt
% Berlin and Merza Klaghstan
%------------------------------------
%red channel   - r
%green channel - g
%blue channel  - b
%[image] -- image of all three color channels returned
%------------------------------------

%------------------------------------
%Composing image from three separate channels 
%------------------------------------
image(:, :, 1) = r;
image(:, :, 2) = g;
image(:, :, 3) = b;
end