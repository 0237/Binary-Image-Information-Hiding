clear all;
oi=imread('载体图片_隐藏信息.bmp'); %打开携密图像
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

%将游程信息提取为二进制比特串
msgcount=256;
for i=1:msgcount
    msg(i,1)=0;
end
for l=1:msgcount
    if mod(RLE((2*l),1),2)==0 
        msg(l,1)=0; %如果游程的值为偶数，表示隐藏的信息为0
    else
        msg(l,1)=1; %如果游程的值为奇数，表示隐藏的信息为1
    end
end

%将比特串解码为字符串后保存到文件
out=bit2str(msg);
fid=fopen('提取信息.txt', 'wt');
fwrite(fid, out);
fclose(fid);