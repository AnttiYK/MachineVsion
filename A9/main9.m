clear all, close all, clc

% Load images and corresponding camera matrices
im1=imread('im1.jpg');
im2=imread('im2.jpg');
load data

% The given image coordinates were originally localized manually.
% That is, 11 points (A,B,C,D,E,F,G,H,L,M,N) are marked from both images.
labels={'a','b','c','d','e','f','g','h','l','m','n'};

figure(1);imshow([im1 im2]);hold on
plot(x1(:,1), x1(:,2),'c+','MarkerSize',10);
plot(x2(:,1)+size(im1,2),x2(:,2),'c+','MarkerSize',10);
for i=1:length(x1)
    ti=text(x1(i,1), x1(i,2),labels{i});
    ti.Color='cyan';
    ti.FontSize=20;
    ti=text(x2(i, 1)+size(im1,2),x2(i, 2),labels{i});
    ti.Color='cyan';
    ti.FontSize=20;
end

% the normalized 8 point method for F-matrix estimation
F = estimateFnorm([x1 ones(11,1)]',[x2 ones(11,1)]');

%% 2-view structure from motion

edges=[1 2;1 3;3 4; 2 4; 1 5; 5 6; 2 6; 5 7; 3 7;4 8;7 8;6 8]';
figure(2);hold on;
title('3D sketch of the shelf')
for i=1:size(edges,2)
    plot3(ABCDEFGH(edges(:,i),1),ABCDEFGH(edges(:,i),2),ABCDEFGH(edges(:,i),3),'k-');
end
for i=1:8
    ti=text(ABCDEFGH(i,1),ABCDEFGH(i,2),ABCDEFGH(i,3),labels{i});
    ti.FontSize=20;
end
axis equal;
view([1 1 1]);

% extract projection matrices
P1 = eye(3, 4);
P2 = vgg_P_from_F(F);

Xc=zeros(3,8);

for i=1:8
   Xc(:,i) = trianglin(P1, P2, x1(i,:), x2(i,:));
end

Pc1 = P1*[Xc; ones(1, 8)];
Pc2 = P2*[Xc; ones(1, 8)];
cx1 = Pc1(1,:)./Pc1(3,:);
cy1 = Pc1(2,:)./Pc1(3,:);
cx2 = Pc2(1,:)./Pc2(3,:);
cy2 = Pc2(2,:)./Pc2(3,:);

% Illustrate the edges of the shelf that connect its corners 
figure(1);
for i=1:size(edges,2)
     plot(cx1(edges(:,i)),cy1(edges(:,i)),'m-');
     plot(cx2(edges(:,i))+size(im1,2),cy2(edges(:,i)),'m-');
end

% reconstruct shelf
figure(3); hold on;
title('Projection reconstruction (try rotating the shape)')
for i=1:size(edges,2)
    plot3(Xc(1,edges(:,i))',Xc(2,edges(:,i))',Xc(3,edges(:,i))','k-');
end
for i=1:8
    ti=text(Xc(1,i),Xc(2,i),Xc(3,i),labels{i});
    ti.FontSize=20;
end
view([1,1,1])