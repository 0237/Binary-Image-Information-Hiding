clear all;
oi=imread('����ͼƬ.bmp'); %������ͼ��
[row col]=size(oi);
oi=oi(:);%�����������ſ����һ��
len=size(oi);

%ͳ���γ̳���
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

%��������Ϣת��Ϊ������
msgfid=fopen('������Ϣ.txt','r');%�������ļ�
[msg,msgcount]=fread(msgfid);
fclose(msgfid);
msg = str2bit(msg);
msg = msg';
msgcount=msgcount*8;

%�����γ̱���ķ�����������ϢǶ��ͼƬ
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

%�洢������ͼƬ
m1=Vector2Matrix(oi,row);%������ת����Ϊ��ά����
imwrite(m1,'����ͼƬ_������Ϣ.bmp');

%��ʾ����ǰ���ͼƬ
figure;
imshow('����ͼƬ.bmp');
title('����ǰ');
figure;
imshow('����ͼƬ_������Ϣ.bmp');
title('�����');