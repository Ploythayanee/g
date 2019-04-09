% % radius = 3; 
% % theta = linspace(0,2*pi,360);
% % x = radius*cos(theta);
% % y = radius*sin(theta);
% % 
% % disp("X: "+x + "Y: "+y);
% 
% 
%  dt = {100,300,200;1,2,3};
%  disp(dt(:,2));
% %  row1= {1, 2, 3};
% %  row2 = {580, 20,500};
% %   n = cell2mat(row2);
% %  [r,idx]= sort(n,'descend')
% % 
% %  disp(row1(idx));
% %   disp(r);
%  
%    frow = dt(1,:);
%    srow = dt(2,:);
%    n1 = cell2mat(frow);
%    [s,x] = sort(n1,'descend');
%    dx = uint8(x(1));
%    disp(s(1));
%    disp(class(dx));
%    disp(dt(:,dx));
   

% I = imread('../img/G_53/img012_G.jpg');
% % gr = rgb2gray(I);
% greenChannel = I(:,:,2); 
% redChannel = I(:,:,1);
% allBlack = zeros(size(I,1),size(I,2),'uint8');
% just_green = cat(3,allBlack,greenChannel,allBlack); 
% just_red = cat(3,redChannel,allBlack,allBlack); 
% G  = rgb2gray(I);
% H  = adapthisteq(G);
% D  = im2double(G);
% 
%   y=[182 233 251 205 169];
%   x=[163 166 207 248 210];
%   P=[x(:) y(:)];
% 
%   J=DrawSegmentedArea2D(P,[400 400]);
%   figure, imshow(J); 

myFolder = '../img/G_53';
% Check to make sure that folder actually exists.  Warn user if it doesn't.
if ~isdir(myFolder)
  errorMessage = sprintf('Error: The following folder does not exist:\n%s', myFolder);
  uiwait(warndlg(errorMessage));
  return;
end
% Get a list of all files in the folder with the desired file name pattern.
filePattern = fullfile(myFolder, '*.jpg'); % Change to whatever pattern you need.
theFiles = dir(filePattern);
for k = 1 : 5
  baseFileName = theFiles(k).name;
  fullFileName = fullfile(myFolder, baseFileName);
  fprintf(1, 'Now reading %s\n', fullFileName);
  % Now do whatever you want with this file name,
  % such as reading it in as an image array with imread()
  imageArray = imread(fullFileName);
  imshow(fullFileName);  % Display image.
  drawnow; % Force display to update immediately.
end



