% myFolder = '../img/G_53';
% % Check to make sure that folder actually exists.  Warn user if it doesn't.
% if ~isdir(myFolder)
%   errorMessage = sprintf('Error: The following folder does not exist:\n%s', myFolder);
%   uiwait(warndlg(errorMessage));
%   return;
% end
% % Get a list of all files in the folder with the desired file name pattern.
% filePattern = fullfile(myFolder, '*.jpg'); % Change to whatever pattern you need.
% theFiles = dir(filePattern);
% for k = 46 : 53
%   baseFileName = theFiles(k).name;
%   fullFileName = fullfile(myFolder, baseFileName);
%   fprintf(1, 'Now reading %s\n', fullFileName);


% I = imread(fullFileName);
I = imread('../img/G_53/img035_G.jpg');
% gr = rgb2gray(I);
greenChannel = I(:,:,2); 
redChannel = I(:,:,1);
allBlack = zeros(size(I,1),size(I,2),'uint8');
just_green = cat(3,allBlack,greenChannel,allBlack); 
just_red = cat(3,redChannel,allBlack,allBlack); 
G  = rgb2gray(I);
H  = adapthisteq(G);
D  = im2double(G);
D2  = im2double(I);

  %<==== for gray level only==>

  % r=1 , ;=2, top=3, bottom =4
  [x1c,y1c,x2c,y2c,x3c,y3c,x4c,y4c,hwc,hcc] = position_boun(G);
    xcen = x3c;
    ycen = y2c;
    radius = hwc-10; 
    
    theta = 0:20:360;
    x = ceil(radius*cos(theta)+xcen);
    y = ceil(radius*sin(theta)+ycen);
  
  x_c = [x1c x2c x3c x4c];
  y_c = [y1c y2c y3c y4c];
  
  
  R = region_gw(G,x_c,y_c,xcen,ycen,hwc);

  %<<===========================
  J = G;
     for i =1:size(R,1)
      for j=1:size(R,2)
        if R(i,j)~=0
            
%              disp(J2(i,j));
             J(i,j) = nan;
%              disp(i+"&&"+j);
            
        end
      end
     end       
 
  
  %<<==========================>
%   J = ~J;
 
  od_region = treshold(J);
  s = regionprops(od_region,'centroid','BoundingBox','Area','MajorAxisLength','MinorAxisLength');
  centroids = cat(1, s.Centroid);
  area = cat(1, s.Area);
   disp(area);

  ma = max(area);
%   
%   disp("F: "+fa);
%   disp("Major X: "+major);
%   disp("Minor Y: "+minor);

  %=============
  
  se = strel('disk',10);
  close = imclose(od_region,se);
  
  %===========
  
    max1 = check(s);
    disp("max1: "+max1);
  for m=1: length(s)
   if(s(m).Area==max1)
    F = s(m).BoundingBox;
    xc = s(m).Centroid(:,1);
    yc = s(m).Centroid(:,2);
    xmin = ceil(s(m).BoundingBox(1));
    w = s(m).BoundingBox(3);
    ymin = ceil(s(m).BoundingBox(2));
    h = s(m).BoundingBox(4);
    end
  end
%       xc = s(midx).Centroid(:,1);
%       yc = s(midx).Centroid(:,2);
  %<<==============================
   
    M = distance(s,xc,yc);
    disp("index M: "+M);
    
    
    
    F1 = s(M).BoundingBox;
    xc1 = s(M).Centroid(:,1);
    yc1= s(M).Centroid(:,2);
    
    xm = ceil(s(M).BoundingBox(1));
    wm = s(M).BoundingBox(3);
    ym = ceil(s(M).BoundingBox(2));
    hm = s(M).BoundingBox(4);
    xmin_con = xmin;
    xm_con = xm;
    wm1 = 0;
    if(xc1>xc)
       xx = xmin;
       yy = ymin;
       w1 = -xmin+xm+wm1;
       h1 = h; 
    else
       xx = xm;
       yy = ymin;
       w1 = w+xmin-xm;
       h1 = h; 
    end
    
    
%     disp("xm: "+xm);
%     disp("xmin: "+xmin);
   
    a = [xx yy w1 h1];
    
%     disp("a: "+a);
    
    disp("W: "+w1);
    disp("H: "+h1);
     
%     %find centroid     
    xc2 = xx+(w1/2);
    yc2 = yy+(h1/2); 
    
  %<<===create boundary arounf center========>
    
    %1/4 radius
    b = 1/2 * radius;
    b2 = 1/2 * radius;
    b3 = 1/4 * radius;
%     b3 = 20;
    xLeft = xc2 - b/3;
    yBottom = yc2 - b/3;  
    FB = [xLeft yBottom b3 b3];
 
  %<<===================
  mask = zeros(size(D));
%   mask(yBottom:yBottom+b,xLeft:xLeft+b) = 1;
  [rNum,cNum,~] = size(I);
  [xx,yy] = ndgrid((1:rNum)-yc2,(1:cNum)-xc2);
  mask = (xx.^2 + yy.^2)<b3^2;
  bw = activecontour(D, mask, 200, 'Chan-Vese','ContractionBias',1,'SmoothFactor',2);
  
  
  %<< boundaty outside OD=========>
   theta2 = 0:30:360;
   x2 = ceil(b2*cos(theta2)+xc2);
   y2 = ceil(b2*sin(theta2)+yc2);
 
   [px,py, d] = circle2(xc2,yc2,b3);
   %<<======boundary inside =========================
   ri = 10;
   theta3 = 0:30:360;
   x3 =ceil(b3*cos(theta3)+xc2);
   y3 = ceil(b3*sin(theta3)+yc2);
 
 
  %<<=========== GVF ===============>
  
  
    P=[y2(:) x2(:)];
    P2=[y3(:) x3(:)];
   
%   Options=struct;
%   Options.Verbose=true;
%   Options.Iterations=400;
%   Options.Wedge=2;
%   Options.Wline=0;
%   Options.Wterm=0;
%   Options.Kappa=8;
% %   Options.Sigma1=8;
% %   Options.Sigma2=8;
%   Options.Alpha=0.5;
%   Options.Beta=0.5;
%   Options.Mu=0.5;
%   Options.Delta=-0.1;
%   Options.GIterations=600;
%   Options.GIterations=0;

 Options=struct;
 Options.Verbose=true;
 Options.Iterations=100;
  
   [O,J2]=Snake2D_2(D,P,Options);
    rg2 = zeros(size(J2,1),size(J2,2));
  for i =1:size(J2,1)
      for j=1:size(J2,2)
        if J2(i,j)==1
            rg2(i,j) = D(i,j);
%             disp(i+"&&"+j);
        end
      end
  end
  
  
  %<<========================
    [O2,J3]=Snake2D_2(D,P2,Options);
  

  
  %<<=========================
%   
      rg3 = zeros(size(bw,1),size(bw,2));
  for i =1:size(bw,1)
      for j=1:size(bw,2)
        if bw(i,j)==1
            rg3(i,j) = D(i,j);
%             disp(i+"&&"+j);
        end
      end
  end
  
      in = intersect(rg2,rg3);
      
     
  
  %<<=============================>
  
%   figure 
%   imshow(J3+D,[]);
%  
%   
%   figure 
%   imshow(J);
%   
%   figure 
%   imshow(od_region);
  
  figure
  imshow(I); %title("order"+k);
  
%   figure
%   imshow(rg2);

%   figure
%   imshow(od_region+D,[]);
  
%   figure
%   imshow(just_green);
  
%  figure
%  imshow(D);
 hold on
%  visboundaries(bw,'Color','b');
%  plot(x,y, 'g+','MarkerSize',30,'LineWidth',2)
%  plot(x1c, y1c, 'b+','MarkerSize',30,'LineWidth',2)
%  plot(x2c, y2c, 'b+','MarkerSize',30,'LineWidth',2)
%  plot(x3c, y3c, 'b+','MarkerSize',30,'LineWidth',2)
%  plot(x4c, y4c, 'b+','MarkerSize',30,'LineWidth',2)
%  plot(xc, yc, 'b+','MarkerSize',30,'LineWidth',2)
%  plot(xc1, yc1, 'b+','MarkerSize',30,'LineWidth',2)
 plot(xc2, yc2, 'rx','MarkerSize',30,'LineWidth',2);

 plot(O(:,2),O(:,1),'r.');
 plot(O2(:,2),O2(:,1),'b.');
%  plot(P2(:,2),P2(:,1),'g.');
%  plot(x2, y2, 'rx','MarkerSize',30,'LineWidth',2)
%  plot(px, py, 'rx','MarkerSize',30,'LineWidth',2)
%  rectangle('Position',[px py d d],'Curvature',[1,1]);
%   rectangle('Position',F1);

 hold off
%  end

figure
imshow(od_region);