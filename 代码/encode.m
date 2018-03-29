clear all;
oi=imread('载体图片.bmp'); %打开载体图像
[row col]=size(oi);
oi=oi(:);%将矩阵竖向排开变成一列
len=size(oi);

%统计游程长度
i=1;
j=1;
while i<len(1)
    or=oi(i,1);
    count=1;
    while (i<len(1)&&oi(i+1,1)==or)
        i=i+1;
        count=count+1;
    end
    RLE(j)=count;
    j=j+1;
    i=i+1;
end
if i==len(1)
    RLE(j)=1;
end
RLE=RLE';

%将秘密信息转化为二进制
msgfid=fopen('隐藏信息.txt','r');%打开秘密文件
[msg,msgcount]=fread(msgfid);
fclose(msgfid);
msg = str2bit(msg);
msg = msg';
msgcount=msgcount*8;

%利用游程编码的方法将秘密信息嵌入图片
for l=1:msgcount
    modpoint=0;
    for x=1:2*l
        modpoint=modpoint+RLE(x,1);
    end
    if msg(l,1)==0
        if ((mod(RLE(2*l,1),2)~=0)&&(RLE(2*1+1,1)~=1))
            oi(modpoint+1,1)=mod((oi(modpoint+1,1)+1),2);
        end
    else
        if ((mod(RLE(2*l,1),2)==0)&&(RLE(2*1+1,1)~=1))
            oi(modpoint+1,1)=mod((oi(modpoint+1,1)+1),2);
        end
    end
end

%存储处理后的图片
m1=Vector2Matrix(oi,row);%将数组转换成为二维矩阵
imwrite(m1,'载体图片_隐藏信息.bmp');

%显示处理前后的图片
figure;
imshow('载体图片.bmp');
title('处理前');
figure;
imshow('载体图片_隐藏信息.bmp');
title('处理后');