
%---------------------------------------------------------------------
Y = dir('C:\Users\KLAS\Desktop\STAJ DOSYALARI\matlab files\*.jpg*');% change address accorting to 
% original photo -------------------------

filename = Y(2).name;
figure();
RGBoRiginalImage=imread(filename);
imshow(RGBoRiginalImage);
data = rgb2gray(imread(filename)) ;
figure();
imshow(data);


%------------------------------------------------
C = cell(3,1) ;  % initialize each file's data into a cell 
for k = 1:3
    filename = Y(k).name;
    data2 = imread(filename) ;
    C{k} = data2;
    J{k,1}= imnoise(C{k,1},'salt & pepper',0.25);%0.025 GAUSSÝAN NOÝSE VARÝANCE
    K{k,1} =rgb2gray(J{k,1});
       K1= cell2mat(K(1,1));
    g=K{k,1};
    M=7;
         SpatialJ{k,1}=wienerfiltercalculation(g,M); 
end
   figure();
   imshow(K1(1:720,1:1280));
    figure();
    WienerResult=cell2mat(SpatialJ(2,1));
    imshow(cell2mat(SpatialJ(2,1)));

for i=1:3
        c(:,:,i)=cell2mat(SpatialJ(i,1));
          image= c(:,:,i);
            T(i)=Thresholding_Otsu(image);
end



 
[height,width,nframes] = size(c);

h=double(zeros(height,width));
R=double(zeros(height,width));

  for f=2:3   % the first frames will be same.
      a=T(f-1);
    a=acorrection(a);
     current=c(:,:,f);
      previous=c(:,:,f-1);
      k=current-previous;
       [row, col]=size(current);
 
       for i=1:row
          for j=1:col
             if abs(k(i,j))<T(f-1) % motion estimation. For large motion(>T), there is less redundancy.
             h(i,j)=a*current(i,j)+(1-a)*previous(i,j);
             else
             h(i,j)=current(i,j);
           end
       % current(i,j)=Fn(i,j)-------------    
       end
       
   end
  
   c(:,:,f-1)=h; % Tn(i,j)-------
  end
 %------MODÝFÝED TEMPORAL FILTER--------------------------------------  
figure();
imshow(c(:,:,2));
drawnow();
B=c(:,:,2);
%----------------------------------------------------------
%---------------------------------------
%Calculations of the image quality index

%1- STRUCTURAL SIMILARÝTY INDEX
[ssimval, ssimmap] = ssim(c,data2); % Square symmetry index for image 2
  
fprintf('The SSIM value of Second Project is %0.4f.\n',ssimval);
  
figure, imshow(ssimmap,[]);
title(sprintf('ssim Index Map - Mean ssim Value of Second Project is %0.4f',ssimval));
  
%2- PNSR (peak Signal-to-Noise-Ratio) VALUE
[peaksnr, snr] = psnr(c,data2);

fprintf('\n The Peak-SNR value of Second Project is %0.4f', peaksnr);

%3- MSE (Mean-Squared-Error) value.
err = immse(c,data2);
fprintf('\n The mean-squared error of Second Project is %0.4f\n', err);
figure();
montage({RGBoRiginalImage, data,K1(1:720,1:1280),cell2mat(SpatialJ(2,1)),c(:,:,2),ssimmap,[]});
drawnow();
%------------------------------------------------------------------------------------------------------------
%1- STRUCTURAL SIMILARÝTY INDEX
[ssimval, ssimmap] = ssim(WienerResult,data); % Square symmetry index for image 2
  
fprintf('The SSIM value of First Project is %0.4f.\n',ssimval);
  
figure, imshow(ssimmap,[]);
title(sprintf('ssim Index Map - Mean ssim Value of first project is %0.4f',ssimval));
  
%2- PNSR (peak Signal-to-Noise-Ratio) VALUE
[peaksnr, snr] = psnr(WienerResult,data);

fprintf('\n The Peak-SNR value of First Project is %0.4f', peaksnr);

%3- MSE (Mean-Squared-Error) value.
err = immse(WienerResult,data);
fprintf('\n The mean-squared error of First Project is %0.4f\n', err);
%-------------------------------------------------------------------------------------------------