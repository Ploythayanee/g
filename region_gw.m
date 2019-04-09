function R = region_gw(im,x,y,mx,my,hwc)
    D = im2double(im);
    pg =x ;
    radius = hwc-50; 
    theta = 0:20:360;
    x1 = ceil(radius*cos(theta)+mx);
    y1 = ceil(radius*sin(theta)+my);
    
    x = [x x1];
    y = [y y1];
%     figure
%     imshow(im);
%     hold on;
%      plot(x,y, 'g+','MarkerSize',30,'LineWidth',2);
%      
%     hold off;
%     disp("Tx "+x);
%     disp("Ty "+y);
%     disp("Tx1 "+ceil(x));
%     disp("Ty1 "+ceil(y));
    R = zeros(size(D,1),size(D,2));
 
     for i =1:length(x)  
         
     
       if im(ceil(y(i)),ceil(x(i))) >200
            
%             % region growing
            R1 = regiongrowing(D,y(i),x(i),0.05);
%             R2 = [R2,{R}];
            R = R+R1;         
       end         
 end
 
 
 
 

    
    

