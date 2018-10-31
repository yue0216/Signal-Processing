cd
clc;clear;clf;
NOF=360;
figure(1);
d=[cd,'/images/'];
Threshold=5;
count=zeros(NOF-1,1);
for i=1:NOF-1
    img_i=imread(strcat(d,[num2str(i) '.jpg']));
    img_i_plus=imread(strcat(d,[num2str(i+1) '.jpg']));
    imbw_i=im2bw(rgb2gray(imresize(img_i,[8,8])));
    imbw_i_plus=im2bw(rgb2gray(imresize(img_i_plus,[8,8])));
    for j=1:8
        for k=1:8
            if(imbw_i(j,k)~=imbw_i_plus(j,k))
                count(i)=count(i)+1;
            end;
        end;
    end;  
end;
for i=1:NOF-2
    if(count(i)>=Threshold)
       fprintf('%d\n',i);
   end;
end;

plot(count(1:NOF-2));