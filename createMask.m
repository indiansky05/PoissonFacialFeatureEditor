function [compMask] =createMask(croppedImg, tgt, croppedMask, position)
% Code adapted from the Computer Graphics Group at Technische Universität Berlin
%------------------------------------
% source image   - croppedImg
% target image   - tgt
% mask           - croppedMask
% position       - position
% color channel  - clrchan (1, 2, or 3)
%[compMask] returned -- binary mask with ones for every pixel that was
%                       copied from croppedImg
%------------------------------------

%------------------------------------
%Create zeroes matrix the size of the target image
%logical allows arrays to be indexed later
%------------------------------------
compMask = logical(zeros(size(tgt, 1), size(tgt, 2)));

%------------------------------------
%Copy cropped image selection onto the zeroes matrix
%------------------------------------
compMask(position(2):position(2)+size(croppedImg, 1) - 1, position(1):position(1)+size(croppedImg, 2) - 1, :) = croppedMask;

end