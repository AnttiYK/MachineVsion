function J = apply_homography(I, H)
% Author: Antti Yli-Kujala
% Student Number: e123107
%
%This function applies the homography H to the image I and returns the
%transformed image J.
%PARMETERS:
%I HxW or HxWx3 grayscale or color image
%H: 3x3 homography matrix
[h, w, z] = size(I);

% convert the image to double
I = im2double(I);

% create the meshgrids x and y
[x, y] = meshgrid(1:w, 1:h);

% create a 3xWH array of homogeneous coordinates X
X = zeros(3, w*h);
X(1,:) = reshape(x,1,h*w);
X(2,:) = reshape(y,1,h*w);
X(3,:) = ones(1, w*h);

% apply the homography
Y = mtimes(H, X);

% convert the result to cartesian coordinates
Y = Y(1:2, :, :) ./ Y(3, :, :);

% create scattered grids of transformed coordinates
xx = reshape(Y(1,:),h,w);
yy = reshape(Y(2,:),h,w);

% find corner point of bounding rectangle
minx = floor(min(xx, [], 'all'))
maxx = ceil(max(xx,[],'all'))
miny = floor(min(yy,[],'all'))
maxy = ceil(max(yy,[], 'all'))

% create new meshgrids
[xnew, ynew] = meshgrid(minx:maxx, miny:maxy);
[hnew, wnew] = size(xnew);

% create new image and initiate to zeros
J = zeros(hnew,wnew,z);

% interpolate the pixels values on the new meshgrid. Note you need to
% process one channel at a time
for i = 1:z
    J(:,:,i) = griddata(x, y, I, xnew, ynew); 
end
% convert final result to uint8
J = im2uint8(J);

end