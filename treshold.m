function od_region = treshold(im)
    %find highest peek point
    G2 = adapthisteq(im);
    [counts, level] = imhist(G2);
    [pks,locs] = findpeaks(counts);
    max_p = max(pks);
    x_index = find(counts==max_p,1,'first');
 
%find local minimum point
    [pks2, locs2] = findpeaks(-counts);
 
 %find max intensity
    max_in = max(G2(:));
    disp("Max Intensity: "+max_in);
%  disp(counts(x_index));
    t2 = max_in;
  for i =max_in:-1:x_index  
      if(counts(i)>=6000 && i<250)
        t2 = i;
        break;
      end
     
  end

  t1 = max_in;
     t11 = double(t1);
     t12 = double(t2);
     tn = (t11+t12)/2;
%      tn = 210;
     od_region = im>=tn & im <=max_in;
%  od_region = im == 215;
     
    area_t = [];
    for i=uint8(tn):max_in
        area_t = [area_t,counts(i)];   
%         disp("level: "+level);
    
    end
  maxarea = max(area_t);
  i_index = find(counts == 22254);
  disp("Max area: "+maxarea)
  disp("level intensity: "+i_index)
  disp(":: "+counts(i_index));

     
    disp("T1: "+t1);
    disp("T2: "+t2);
    disp("Tn: "+tn); 
    disp("Max are of peek point: "+max_p);

end