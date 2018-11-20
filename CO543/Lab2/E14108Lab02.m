%%%%%%%%%%%%%%
%  E/14/108  %
%%%%%%%%%%%%%%

%_________________________
% a

A = imread('greens.jpg');

%convert img to gray to take only one plane
img_gray = rgb2gray(A);

%set your threshold value
threshold_val = 100;

%get img size
[row, col] = size(img_gray);

%get img pixel value
for x = 1:row
    for y = 1:col
        %if the pixel value less than theshold value then pixel value set to 0
        if img_gray(x,y) < threshold_val 
            img_gray(x,y) = 0;
        else
            img_gray(x,y) = 255;
        end
    end
end

% -------------- Uncomment this to get result -------------- %
    %imshow(A);title('Original Image'); %show real img
    %figure;
    %imshow(img_gray);title('Threshold Image'); %show threshold img
% ---------------------------------------------------------- %

%__________________________
% b

%add same size images

%read img1 and img2 (same size)
img1 = imread('rice.png');
img2 = imread('cameraman.tif');
img_add = imadd(img1,img2,'uint16'); %add same size images

%subtraction same size images

img_sub = imsubtract(img1,img2); %substract same size images

% -------------- Uncomment this to get result -------------- %
    % subplot(2,2,1);imshow(img1);title('img 1');
    % subplot(2,2,2);imshow(img2);title('img 2');
    % subplot(2,2,3);imshow(img_add,[]);title('addition');
    % subplot(2,2,4);imshow(img_sub);title('subtraction');
% ---------------------------------------------------------- %

%__________________________
% c

%log tansformation
% s = c log(r+1)

%c value enter here
c = 255/2.4;

img = imread('football.jpg'); %read img
img_gray1 = rgb2gray(img); % convet rgb img to gray img

[row, col] = size(img_gray1);

for x = 1:row
    for y = 1:col
        val_doub = double(img_gray1(x,y)); %convet pixel value to double
        img_gray1(x,y) = c.*log10(1+val_doub); %get log value of that pixel
    end
end

% -------------- Uncomment this to get result -------------- %
    % subplot(1,2,1);imshow(img);title('Real Image');
    % subplot(1,2,2);imshow(img_gray1);title('Log Transformation');
% ---------------------------------------------------------- %
 
%power tansformation
% s = c * (r ^ gamma)

img = imread('football.jpg'); %read img
img_gray1 = rgb2gray(img); % convet rgb img to gray img

img_double = im2double(img_gray1); %pixel value take into double

[row, col] = size(img_double);

img1 = zeros(row,col);

g = [2 4 6 8 10]; % Gamma value

% -------------- Uncomment this to get result -------------- %
    %imshow(img)
% ---------------------------------------------------------- %

for z = 1:length(g)
    for x = 1:row
        for y = 1:col
            img1(x,y) =  c * img_double(x, y).^ g(z); 
        end
    end
    % -------------- Uncomment this to get result -------------- %
        %figure;imshow(img1);title('Power Transformation');xlabel(g(z));
    % ---------------------------------------------------------- %
end

% Gray level slicing

img = imread('onion.png'); %read img
img_gray = rgb2gray(img); % convet rgb img to gray img

[row, col] = size(img_gray);

for x = 1:row
    for y = 1:col
        if img_gray(x,y) > 150 %give condition to pixel level
            img_gray(x,y) = 255;
        else
            img_gray(x,y) = 0;
        end
    end
end

% -------------- Uncomment this to get result -------------- %
    % subplot(1,2,1);imshow(img);title('Real Image');
    % subplot(1,2,2);imshow(img_gray);title('Gray slicing Image');
% ---------------------------------------------------------- %

%Bit plane slicing

img= imread('kids.tif');   %read the image
tempimg = img(:,:,1);

[row,col]= size(tempimg);         % get the dimensions of image

s = zeros(row,col,8);           % pre allocate a variable to store 8 bit planes of the image

for z = 1:8
    for x = 1:row
        for y = 1:col
            s(x,y,z) = bitget(tempimg(x,y),z);    %get zth bit from each pixel 
        end
    end    
end

% -------------- Uncomment this to get result -------------- %
    % figure,imshow(uint8(tempimg));title('Original Image');    %display original image
    % figure;  
% ---------------------------------------------------------- %

%display all the 8 bit planes
% -------------- Uncomment this to get result -------------- %
    %     subplot(3,3,1);imshow(s(:,:,8));title('8th(MSB)Plane');
    %     subplot(3,3,2);imshow(s(:,:,7));title('7th Plane');
    %     subplot(3,3,3);imshow(s(:,:,6));title('6th Plane');
    %     subplot(3,3,4);imshow(s(:,:,5));title('5th Plane');
    %     subplot(3,3,5);imshow(s(:,:,4));title('4th Plane');
    %     subplot(3,3,6);imshow(s(:,:,3));title('3th Plane');
    %     subplot(3,3,7);imshow(s(:,:,2));title('2nd Plane');
    %     subplot(3,3,8);imshow(s(:,:,1));title('1st(LSB)Plane')
% ---------------------------------------------------------- %
    
% reconstruct the original image from generated bit planes
rec=s(:,:,1)+s(:,:,2)*2+s(:,:,3)*4+s(:,:,4)*8+s(:,:,5)*16+s(:,:,6)*32+s(:,:,7)*64+s(:,:,8)*128; 
   
% -------------- Uncomment this to get result -------------- %
    % subplot(3,3,9);imshow(uint8(rec));title('Recovered Image')%display the reconstructed image
% ---------------------------------------------------------- %    

%__________________________
% d

img = imread('onion.png'); %read img
J = imresize(img,[256 256]); %resize img to 256*256

%get croped area and convert color to black
for x = 1:256
    for y = 1:256
        if x < (256-128)/2 || x > (256-128)/2 + 128 || y < (256-128)/2 || y > (256-128)/2 + 128
            J(x,y,1) = 0;
            J(x,y,2) = 0;
            J(x,y,3) = 0;
        end
    end
end

% -------------- Uncomment this to get result -------------- %
    %  subplot(1,3,1);imshow(img);title('Real Image');
    %  subplot(1,3,2);imshow(J);title('croped Image');
% ---------------------------------------------------------- %

img = imread('onion.png'); %read img
J = imresize(img,[256 256]); %resize img to 256*256

%get croped area and convert color to black
for x = 1:256
    for y = 1:256
        i = 128-x; %convert x,y coordinate to genaral format
        j = 128-y;
        if i*i + j*j > 128*128 %crop circuler area
            J(x,y,1) = 0;
            J(x,y,2) = 0;
            J(x,y,3) = 0;
        end
    end
end

% -------------- Uncomment this to get result -------------- %
    %  subplot(1,3,3);imshow(J);title('croped Image');
% ---------------------------------------------------------- %

%__________________________
% e

img = imread('peppers.png') ;
I = img + 100 ;

% -------------- Uncomment this to get result -------------- %
    % subplot(1,2,1);imshow(img);title('Real Image');
    % subplot(1,2,2);imshow(I);title('Edited Image');
% ---------------------------------------------------------- %

%__________________________
% f

img = imread('peppers.png') ;
img_gray = rgb2gray(img);

% -------------- Uncomment this to get result -------------- %
    % imshow(img_gray);title('Image');
    % figure;
    % imhist(img_gray);title('Histrogram');xlabel('gray level');ylabel('number of pixels'); %using imhist function we can plot histrogram
% ---------------------------------------------------------- %