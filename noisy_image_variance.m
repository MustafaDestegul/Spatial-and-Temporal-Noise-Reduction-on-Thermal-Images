Y = dir('C:\Users\KLAS\Desktop\STAJ DOSYALARI\matlab files\*.jpg*');% change address accorting to 
% original photo -------------------------
filename = Y(1).name;
data = rgb2gray(imread(filename)) ;
J= imnoise(data,'gaussian',0,0.025);%0.025 GAUSSİAN NOİSE VARİANCE
in=J;
figure
imshow(J)
[h,w]=size(in);
% in= double(zeros(h,w));
intImg=double(zeros(h,w));
%in();input image
t=15;
for i=1:h
             sum=0;
              for j=1:w
               sum=sum+in(i,j);
                  if i==1 
                   intImg(i,j)=sum;
                  else
                   intImg(i,j)=intImg(i-1,j)+sum;
                  end
              end
end
%--------------------------------------------------------
   s=w/8;    k=0;l=0;m=0;n=0;
   out=zeros(h,w);
for i=1:h
    k=k+1;
    for j=1:w
      x1=i-s/2; %{border checking is not shown}
      x2=i+s/2;
      y1=j-s/2;
      y2=j+s/2;
      l=l+1;
      count=(x2-x1)*(y2-y1)/2;
      %sum=intImg(x2,y2)-intImg(x2,y1-1)-intImg(x1-1,y2)+intImg(x1-1,y1-1);
            if(i>=1)&&(i<=s/2+1)
                if (j>=1)&&(j<=s/2+1)
                sum2=intImg(x2,y2); 
                elseif(j<=w)&&(j>=w-s/2)
                sum2=-intImg(x2,y1-1);     
                else
                sum2=intImg(x2,y2)-intImg(x2,y1-1);  
                end     
            elseif(i<=h)&&(i>=h-s/2)
                if (j>=1)&&(j<=s/2+1)
                sum2=-intImg(x1-1,y2);
                elseif(j<=w)&&(j>=w-s/2)
                sum2=intImg(x1-1,y1-1);  
                else
                sum2=-intImg(x1-1,y2)+intImg(x1-1,y1-1);
                end
            else
                if (j>=1)&&(j<=s/2+1)
                sum2=intImg(x2,y2)-intImg(x1-1,y2);
                elseif (j<=w)&&(j>=w-s/2)   
                sum2=-intImg(x2,y1-1)+intImg(x1-1,y1-1);
                else
                sum2=intImg(x2,y2)-intImg(x2,y1-1)-intImg(x1-1,y2)+intImg(x1-1,y1-1);  
                end   
             m=m+1;   
            end 
                n=n+1;
           if (in(i,j)*count)<=(sum2*(100-t)/100) 
               out(i,j)= (sum2*(100-t)/100) /count;
           else 
               out(i,j)=in(i,j); 
           end 
    end
end
EstimatedNoise=var(out(:))/(256*256) % variance of the noisy pixels
figure();
imshow(out);
%out();output image showing the treshold values 