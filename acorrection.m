function a=acorrection(a) %% corrects 'a'  by using adaptivetermal image threshold value


thermalimageconstant=95;  % constant to be determined by using real thermal images
x=a-thermalimageconstant;
  if x<=0
        a= 0.5; %% will be determined on real video
    
  elseif x>0 && x<25 % 25 will be determined by using real values on video
          a=-0.0184*a+1.748;  %% will be determined on real video
          
  elseif x>25 
         a=0,04;
     
  end
  a=a;
end