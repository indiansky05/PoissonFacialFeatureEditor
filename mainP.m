%------------------------------------
% Code adapted from the Computer Graphics Group at Technische Universität
% Berlin, Howard Zhou, and Merza Klaghstan
%------------------------------------

%------------------------------------
%Load the source image
%------------------------------------
img_source = evalin('base', 'img_source');
src=imread(img_source);

%------------------------------------
%Load the target image
%------------------------------------
img_target = evalin('base', 'img_target');
tgt = imread(img_target);

%------------------------------------
%Display source in figure 
%------------------------------------
figure('Name', 'Step 1: Select');
imshow(mat2gray(src));

%------------------------------------
%freehand selection from source image
%create mask from freehand selection
%------------------------------------
free = imfreehand();
mask = free.createMask();

pos = free.getPosition();

%------------------------------------
%create a cropped image from the source
%and a cropped source mask
%------------------------------------
xValues = pos(:,1);
yValues = pos(:,2);

minX = min(xValues);
maxX = max(xValues);

minY = min(yValues);
maxY = max(yValues);

croppedMask = imcrop(mask, [minX - 1, minY - 1, maxX - minX + 2, maxY - minY + 2]);
croppedImg = imcrop(src, [minX - 1, minY - 1, maxX - minX + 2, maxY - minY + 2]);

%------------------------------------
%Display cropped mask over target image
%------------------------------------
figure('Name', 'Step 2: Paste');
imshow(mat2gray(tgt));

%------------------------------------
%Allows for two images to be placed in the same figure
%------------------------------------
hold on 

[r,g,b] = decomposeRGB(croppedImg);
    r(~croppedMask)=0;  
    g(~croppedMask)=0;  
    b(~croppedMask)=0;      
sourceImageWithoutBackground = composeRGB(r,g,b);

%------------------------------------
%make the cropped mask show without the background
%------------------------------------
sourceImageHandle = imshow(sourceImageWithoutBackground);
set(sourceImageHandle, 'AlphaData', croppedMask);

%------------------------------------
%Move cropped mask to correct placement by adjusting crosshairs
%------------------------------------
while(true)
    [inj,ini, button] = ginput(1);
    if(button==1)
        offX = uint16(inj(1));
        offY = uint16(ini(1));
        t = pasteFunction(sourceImageWithoutBackground, tgt, offX, offY);
    else
        break
    end
end

hold off

set(sourceImageHandle, 'AlphaData', croppedMask);   
position= [uint16(offX), uint16(offY)];

%------------------------------------
%Use runPoisson to solve for each individual color channel
%------------------------------------
finalred=runPoisson(croppedImg, tgt, croppedMask, position, 1);
finalgreen=runPoisson(croppedImg, tgt, croppedMask, position, 2);
finalblue= runPoisson(croppedImg, tgt, croppedMask, position, 3);

%------------------------------------
%Add all three color channels together and show the final image
%------------------------------------
final= finalred+finalgreen+finalblue;
figure('Name', 'Final Blended Image');
imshow(final);








