function I = make_panorama(I1, I2, H)
% assembles panorama from images I1 and I2 using the homography H which
% maps I1 onto I2.

tform = projective2d(H');

imageSize = [size(I1, 2), size(I1, 1)];
[xlim, ylim] = outputLimits(tform, [1 imageSize(2)], [1 imageSize(1)]);


% Find the minimum and maximum output limits. 
xMin = min([1; xlim(:)]);
xMax = max([imageSize(2); xlim(:)]);

yMin = min([1; ylim(:)]);
yMax = max([imageSize(1); ylim(:)]);

% Width and height of panorama.
width  = round(xMax - xMin);
height = round(yMax - yMin);

xLimits = [xMin xMax];
yLimits = [yMin yMax];
panoramaView = imref2d([height width], xLimits, yLimits);

I11 = imwarp(I1, tform, 'OutputView', panoramaView);
I22 = imwarp(I2, projective2d(eye(3)), 'OutputView', panoramaView);

mask = ones([height, width]);
mask(sum(I22, 3) > 0) = 0;
I11 = mask .* I11;
I = I11 + I22;