function [finalImg] = runPoisson(croppedImg, tgt, croppedMask, position, clrchan)
% Code adapted from the Computer Graphics Group at Technische Universität Berlin
%------------------------------------
% source image   - croppedImg
% target image   - tgt
% mask           - croppedMask
% position       - position
% color channel  - clrchan (1, 2, or 3)
%------------------------------------

[compImg] = createImage(croppedImg, tgt, croppedMask, position, clrchan);
[compMask] =createMask(croppedImg, tgt, croppedMask, position);

%------------------------------------
%Convert from uint8 to uint16
%------------------------------------
compImg = int16(compImg);
croppedImg = int16(croppedImg);

%------------------------------------
%Calculate the pixel size of the cropped source image
%------------------------------------
[x, y] = size(compImg);
pixelNum=(x*y)/3;

%------------------------------------
%Create a zeroes matrix the same size as the cropped image
%------------------------------------
zeroesMatrix = zeros(size(compImg, 1), size(compImg, 2));

%------------------------------------
%Define pixelNumMatrix
%------------------------------------
pixelNumMatrix = zeros(pixelNum, 2);

%------------------------------------
%For loop to iterate through size of columns and rows of the composed image
%------------------------------------
count = 1;
for col = 1 : size(compImg, 2);
    for rws = 1 : size(compImg, 1);
        
        zeroesMatrix(rws, col) = count;
        pixelNumMatrix(count, 1) = rws;
        pixelNumMatrix(count, 2) = col;
        count = count + 1;
        
    end
end


%------------------------------------
%Sparse matrix setup
%Create vector field vector 
%------------------------------------
A = spalloc(pixelNum, pixelNum, pixelNum * 5);
b = zeros(pixelNum, 3);

%------------------------------------
%For loop to iterate through size of columns and rows of the composed image
%------------------------------------
for col=1:size(compImg, 2)
    for rws=1:size(compImg, 1)
        ind = zeroesMatrix(rws, col);
        
%------------------------------------
%Make sure target image remains the same
%------------------------------------
        if compMask(rws, col) == 0
            
            A(ind, ind) = 1;
            b(ind, clrchan) = 0;
%------------------------------------
%Define pixels that will receive laplacian transformation
%Perform laplacian transformation
%------------------------------------
        else          
            A(ind, ind) = 4;
            A(ind, ind + 1) = -1;
            A(ind, ind - 1) = -1;
            A(ind, ind + size(compImg, 1)) = -1;
            A(ind, ind - size(compImg, 1)) = -1;
            
%-------------------------------------
%Convert cImg coordinates to cropped image coordinates
%-------------------------------------
            cimg2source_r = rws - position(2) + 1;
            cimg2source_c = col - position(1) + 1;
            
            croppedImgLaplacian = 4 * croppedImg(cimg2source_r, cimg2source_c, clrchan) - croppedImg(cimg2source_r + 1, cimg2source_c, clrchan)- croppedImg(cimg2source_r - 1, cimg2source_c, clrchan)- croppedImg(cimg2source_r, cimg2source_c + 1, clrchan)- croppedImg(cimg2source_r, cimg2source_c - 1, clrchan);
            cImgLaplacian = 4 * compImg(rws, col, clrchan)-compImg(rws + 1, col, clrchan)- compImg(rws - 1, col, clrchan)- compImg(rws, col + 1, clrchan)- compImg(rws, col - 1, clrchan);
            b(ind, clrchan) = croppedImgLaplacian - cImgLaplacian;
        end
    end
end

%-------------------------------------
%Solve the system of linear equations
%-------------------------------------
t = A \ b(:, clrchan);

result = zeros(size(compImg), 'uint8');

for i=1:pixelNum

    rws = pixelNumMatrix(i, 1);
    col = pixelNumMatrix(i, 2);
    result(rws, col, clrchan) = uint8(t(i) + double(compImg(rws, col, clrchan)));

end

%--------------------------------------
%Return final image in respect to the color channel being called
%--------------------------------------
finalImg = result;

end