function [compImg] = createImage(croppedImg, tgt, croppedMask, position,clrchan)
% Code adapted from the Computer Graphics Group at Technische Universität Berlin
%------------------------------------
% source image   - croppedImg
% target image   - tgt
% mask           - croppedMask
% position       - position
% color channel  - clrchan (1, 2, or 3)
%[compImg] returned -- composed image 
%------------------------------------

%------------------------------------
% Extract target image behind source image
%------------------------------------
extractedTgt = imcrop(tgt, [position(1), position(2), size(croppedImg, 2) - 1, size(croppedImg, 1) - 1]);

%------------------------------------
% Delete all pixels from extracted target image that are covered by the
% cropped img
%------------------------------------
tmpImg = extractedTgt(:, :, clrchan); 
tmpImg(croppedMask) = 0; 
extractedTgt(:, :, clrchan) = tmpImg; 

%------------------------------------
% Mask cropped image
%------------------------------------
maskImg = croppedImg(:, :, clrchan);
maskImg(~croppedMask) = 0;
croppedImg(:, :, clrchan) = maskImg;

%------------------------------------
% Add masked cropped img to target image
%------------------------------------
extractedTgt = extractedTgt + croppedImg;

% Copy edited part of the target image back into the complete target image.
compImg = tgt;
compImg(position(2):position(2)+size(croppedImg, 1) - 1, position(1):position(1)+size(croppedImg, 2) - 1, :) = extractedTgt;
end

