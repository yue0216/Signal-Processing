cd
clc;clear;clf;
%%%%%提取图片序列%%%%%%%
video=VideoReader('video_test.mp4','Tag','Reader');
NOF=video.NumberOfFrames;
Img_diff=zeros(NOF-1,1);
mkdir([cd,'/images']);
directory=[cd,'/images/'];
figure(1);

for i=1:NOF
    Img_I=read(video,i);
    imwrite(Img_I,[directory,[num2str(i) '.jpg'];]);
end;

%%%%绝对帧间差法%%%%
%%clc;clear;clf;
for i=1:NOF-1
    img_i=imread(strcat(directory,[num2str(i) '.jpg']));
    img_i_plus=imread(strcat(directory,[num2str(i+1) '.jpg']));
    img_diff(i)=norm(double(img_i(:,:,1)-img_i_plus(:,:,1)))+norm(double(img_i(:,:,2)-img_i_plus(:,:,2)))+norm(double(img_i(:,:,3)-img_i_plus(:,:,3)));

end;
Threshold=mean(img_diff)*2.5;
for i=2:NOF-2
   if(img_diff(i)>img_diff(i-1)&&img_diff(i)>img_diff(i+1)&&img_diff(i)>Threshold)
       fprintf('%d\n',i);
   end;
    %%hold on;
end;

plot(img_diff(1:NOF-1));

