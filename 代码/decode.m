clear all;
oi=imread('����ͼƬ_������Ϣ.bmp'); %��Я��ͼ��
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

%���γ���Ϣ��ȡΪ�����Ʊ��ش�
msgcount=256;
for i=1:msgcount
    msg(i,1)=0;
end
for l=1:msgcount
    if mod(RLE((2*l),1),2)==0 
        msg(l,1)=0; %����γ̵�ֵΪż������ʾ���ص���ϢΪ0
    else
        msg(l,1)=1; %����γ̵�ֵΪ��������ʾ���ص���ϢΪ1
    end
end

%�����ش�����Ϊ�ַ����󱣴浽�ļ�
out=bit2str(msg);
fid=fopen('��ȡ��Ϣ.txt', 'wt');
fwrite(fid, out);
fclose(fid);