function makeMovie(filename)

load('Model.mat');
[xx,fs]=audioread(filename);
xx=xx(:,1);
xx=resample(xx,44100,fs);
fs=44100;
l=round(length(xx)/4410)-10;
vec=zeros(1,32);


sound(xx,44100);




figure %新建一张图
axis off
axis([0 5 0 2])%定义x轴（从0到5）和y轴的范围（从0到2）
l=length(str);
t=text(0.5,1,'Start','fontsize',80,'color','black');

for i=1:l
    tic;
    vec=anal(xx,fs,i*0.1);
    pred=predict(Mdl,vec);
    delete(t);
    if pred==5
        t=text(0.5,1,'Violin','fontsize',80,'color','black');%i=1时，写一个‘百’字
    end
    if pred==0
        t=text(0.5,1,'Guitar','fontsize',80,'color','black');%i=1时，写一个‘百’字
    end
    if pred==2
        t=text(0.5,1,'Flute','fontsize',80,'color','black');%i=1时，写一个‘百’字
    end
    if pred==1
        t=text(0.5,1,'Saxophone','fontsize',80,'color','black');%i=1时，写一个‘百’字
    end
    if pred==3
        t=text(0.5,1,'Piano','fontsize',80,'color','black');%i=1时，写一个‘百’字
    end
    if pred==4
        t=text(0.5,1,'Trumpet','fontsize',80,'color','black');%i=1时，写一个‘百’字
    end
    pause(0.1-toc);
end

delete(t);
end



