cd
clc;clear;clf;

d=[cd,'/images/'];
NOF=360;
img_diff=zeros(NOF-1,1);
figure(1);

%%ÑÕÉ«Ö±·½Í¼
%%imglist=d(3:NOF+2);
Threshold=0.93;
for i=1:NOF-1
    img_i=imread(strcat(d,[num2str(i) '.jpg']));
    img_i_plus=imread(strcat(d,[num2str(i+1) '.jpg']));
    Hist1=imhist(rgb2gray(img_i));
    Hist2=imhist(rgb2gray(img_i_plus));
    S=min(Hist1(1),Hist2(1));
    for j=2:length(Hist1)
        S=S+min(Hist1(j),Hist2(j));
    end;
    H=sum(Hist1);
    img_diff(i)=S/H;
end;
for i=1:length(img_diff)
    if(img_diff(i)<Threshold)
       fprintf('%d\n',i);
   end;
end;
plot(img_diff(1:NOF-1));
