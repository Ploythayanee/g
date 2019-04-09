function [x1c,y1c,x2c,y2c,x3c,y3c,x4c,y4c,hwc,hcc] = position_boun(im)
    eye = im>1;
    eye = imclearborder(eye);
    L = bwlabel(eye);
    [r,c] = find(L);
    lrc = min(r);
    lcc = min(c);
    rrc = max(r);
    rcc = max(c);
    hc = rrc - lrc+1;
    hcc = hc/2;
    wc = rcc-lcc+1;
    hwc = wc/2;
    % r
    y1c = rrc-hwc;
    x1c = rcc;
    %l
    y2c = lrc+hcc;
    x2c = lcc;
    %top
    y3c = lrc;
    x3c = lcc+hwc;
    %bottom
    y4c = rcc;
    x4c = rrc-hwc;
    
%     disp("Height: "+hcc);
%     disp("Width: "+hwc);
    
end