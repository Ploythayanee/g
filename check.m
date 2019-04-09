function max1 = check(s)
 ar = {};
 for m=1: length(s)
     
      h = s(m).MajorAxisLength;
      disp("H: "+h);
      if(h<300)
          
          area = s(m).Area;
          %disp("area: "+area);
          ar = [ar,{area;m}];
                 
      end

 end 

      frow = ar(1,:);
      srow = ar(2,:);
      n1 = cell2mat(frow);
      n2 = cell2mat(srow);
      [s,x] = sort(n1,'descend');
      midx = ar{2,x(1)}; 
      max1 = ar{1};
      

 end