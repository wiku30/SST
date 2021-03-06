function  [slope,delta]=formant(xx, fs, time)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
width=4096;
numcoef=20;


xx=hamming(width).*xx(round(time*fs+1):round(time*fs+width));

y=log(abs(fft(xx)));

ceps=fft(y);

ceps((numcoef+1):(width-numcoef),1)=0;
envelop=real(ifft(ceps));  %can plot the envelop here 

i=1;
while(i<4000)
    if(envelop(i+10) < envelop(i))
        break;
    end
    i=i+10;
end
X=zeros(width/4,2);
for i=1:(width/4)
    X(i,1)=i;
    X(i,2)=1;
end

[B,~,R]=regress(envelop(i:(i+width/4-1)),X);
slope=B(1);
delta=sqrt(R'*R);
end

