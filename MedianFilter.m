%Median Fýlter


clear; clc;
Y = dir('C:\Users\KLAS\Desktop\STAJ DOSYALARI\matlab files\*.jpg*');% change address accorting to 
% original photo -------------------------



filename = Y(2).name;
data = rgb2gray(imread(filename)) ;
figure();
imshow(data);
I= imnoise(data,'salt & pepper',0.25);%0.025 GAUSSÝAN NOÝSE VARÝANCE
figure();
imshow(I);
[r c] = size(I);
Rep = zeros(r + 2, c + 2);
for x = 2 : r + 1
    for y = 2 : c + 1
        Rep(x,y) = I(x - 1, y - 1);
    end
end
B = zeros(r, c);
for x = 1 : r
    for y = 1 : c
        for i = 1 : 3
            for j = 1 : 3
                q = x - 1;     w = y -1;
                array((i - 1) * 3 + j) = Rep(i + q, j + w);
            end
        end
        B(x, y) = median(array(:));
    end
 end


figure();
imshow(uint8(B));
% Calculations of the image quality index

% 1- STRUCTURAL SIMILARÝTY INDEX
[ssimval, ssimmap] = ssim(uint8(B),I); % Square symmetry index for image 2
  
fprintf('The SSIM value of Median Filter is %0.4f.\n',ssimval);
  
figure, imshow(ssimmap,[]);
title(sprintf('ssim Index Map - Mean ssim Value of Median Filter is %0.4f',ssimval));
  
%2- PNSR (peak Signal-to-Noise-Ratio) VALUE
[peaksnr, snr] = psnr(uint8(B),I);

fprintf('\n The Peak-SNR value of Median Filteris %0.4f', peaksnr);
fprintf('\n The SNR value of Median Filter is %0.4f \n', snr);

%3- MSE (Mean-Squared-Error) value.
err = immse(uint8(B),I);
fprintf('\n The mean-squared error of Median Filter is %0.4f\n', err);
