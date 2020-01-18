clear;
close all
RGB = imread('03.bmp');
 
RGB1=imadjust(RGB,[0.21 0.5],[0.615 0.9]);
imshow(RGB1);
 
figure('name','process'),
subplot(2,2,1),imshow(RGB),title('ԭͼ'),
 
%ת����YCBCR
YCBCR = rgb2ycbcr(RGB1);
whos,
subplot(2,2,2),imshow(YCBCR),title('YCBCR'),
 
%��ֵ������
imgbw = im2bw(YCBCR, 0.539);
subplot(2,2,3),imshow(imgbw),title('YCBCR?��ֵ��'),
 
%��̬ѧ����
erodeElement = strel('square', 3) ;
dilateElement=strel('square', 8) ;
imgbw = imerode(imgbw,erodeElement);
imgbw = imerode(imgbw,erodeElement);
imgbw = imdilate(imgbw, dilateElement);
imgbw = imdilate(imgbw, dilateElement);
imgbw = imfill(imgbw,'holes');
subplot(2,2,4),imshow(imgbw),title('��̬ѧ����');
 
%��ȡ��������'Area', 'Centroid', and 'BoundingBox' 
figure('name','������'),
L=bwlabel(imgbw); 
stats=regionprops(L,'Area','Centroid','BoundingBox');
number=size(stats,1); %���ǵ����
centroid=cat(1,stats.Centroid); %Ϊ�Ժ��ǵ��ṩλ��

imshow(RGB); hold on;
for i=1:number
    if stats(i).Area>600
    %text(centroid(i,1),centroid(i,2),'���','color','white');%���
    rectangle('Position',[stats(i).BoundingBox],'LineWidth',2,'LineStyle','--','EdgeColor','red'),%���
    end
end
hold off
