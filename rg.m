% function R2 = region_gw2(im,x,y,mx,my)

    I = imread('../img/G_53/img008_G.jpg');
    im  = rgb2gray(I);
    D = im2double(im);
    
    [x1c,y1c,x2c,y2c,x3c,y3c,x4c,y4c,hwc,hcc] = position_boun(im);
    radius = hcc-50; 
    theta = 0:20:360;
    x = ceil(radius*cos(theta)+x3c);
    y = ceil(radius*sin(theta)+y2c);
    
 
  
%     x = [1620 137 889 889];
%     y = [889 889 137 1640];
    
%     for i =1:length(x)
%         
%     
%             
%         
%         
%         in = im(y(i),x(i));
%         
%         disp("I: "+in);
%          disp("X: "+x(i));
%         disp("Y: "+y(i));
%     end
    

%    
  R1 = zeros(size(D,1),size(D,2));
 for i =1:length(x)  
     
       if im(y(i),x(i)) >200
%    
%             % region growing
            R = regiongrowing(D,y(i),x(i),0.05);
%             R2 = [R2,{R}];
%             J() = nan;
            R1 = R1+R;
            
      disp(x(i)+" "+y(i));
       
           
            
       end

    
          
            
 end
 
   J = im;
     for i =1:size(D,1)
      for j=1:size(D,2)
        if R1(i,j)==0
%              disp(J(i,j));
             J(i,j) = nan;
%              disp(i+"&&"+j);
            
        end
      end
     end 
%  
%  figure 
%  imshow(R1(:,:,1));
 
 figure 
 imshow(R1);
  figure 
 imshow(~J);
 figure 
 imshow(J+);
% 
%  plot(x,y, 'g+','MarkerSize',30,'LineWidth',2)


% end