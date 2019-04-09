function M = distance(s,xc,yc)
  dt ={};
  for m=1: length(s)
      
      hi = s(m).MajorAxisLength;
      area = cat(1, s.Area);
%       disp("hight: "+hi);
      ma = max(area);
     
      %X = [s(m).Centroid(:,1),s(m).Centroid(:,2):xc,yc];
      p1 = [s(m).Centroid(:,1),s(m).Centroid(:,2)];
      p2 = [xc,yc];
      new_cen = p1+p2/2;
      d = ceil(norm(p1-p2));
%       c = [c,new_cen];
  
      if(d <140)
        dt = [dt,{d;m}];
      end     
  end   
      frow = dt(1,:);
      srow = dt(2,:);
      n1 = cell2mat(frow);
      n2 = cell2mat(srow);

      [s,x] = sort(n1,'descend');
      in_second = dt{2,x(1)};
%       disp(": xxx "+s);
%       disp(": xxx5 "+x);
%       disp(": xx1 "+in_second);
      dx = uint8(in_second);
%       disp("dx: "+dx);
      M = dx;
end