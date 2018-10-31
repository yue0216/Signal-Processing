cd
clc;clear;clf;
d=[cd,'/images/'];
NOF=360;
img_sim=zeros(NOF-1,1);
figure(1);
%%图像相关系数
 
for i=1:NOF-1
    img_i=imread(strcat(d,[num2str(i) '.jpg']));
    img_i_plus=imread(strcat(d,[num2str(i+1) '.jpg']));
    img_sim(i)=corr2(img_i(:,:,1),img_i_plus(:,:,1))+corr2(img_i(:,:,2),img_i_plus(:,:,2))+corr2(img_i(:,:,3),img_i_plus(:,:,3));
    img_sim(i)=img_sim(i)/3;
end;
Threshold=0.4;
for i=1:length(img_sim)
    if(img_sim(i)<Threshold)
       fprintf('%d\n',i);
   end;
end;
plot(img_sim(1:NOF-1));
