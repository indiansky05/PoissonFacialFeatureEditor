function [target] = pasteFunction(src, target, offX, offY)
% Code adapted from Merza Klaghstan
%------------------------------------
% source image - crc
% target image - tgt
% x            - offX
% y            - offY
% [target] returned -- position of the src displayed on top of the target
%                at each new (offX, offY)
%------------------------------------

%------------------------------------
%Iterate through the size of the src image
%copy the src to the new position on the target image for the respective
%color channel 
%------------------------------------
for i=1:size(src, 1)
    for j=1:size(src, 2)
        i = uint16(i);
        j = uint16(j);
        if(sum(src(i,j,:))~=0)
            target(i+offY,j+offX,1) = src(i,j,1);
            target(i+offY,j+offX,2) = src(i,j,2);
            target(i+offY,j+offX,3) = src(i,j,3);
        end
    end
end
imshow(target);
end