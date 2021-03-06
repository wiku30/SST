function varargout=ceps(in1, fs, time) 
%out1: ceps 
%out2: area of ceps
%out3: peak style
    xmax = 0.14;

    n=round(fs*xmax);

    sig=in1(round(fs*time+1) : round(fs*time+n),1);
    for i=1:n
        sig(i)=sig(i)*power(sin(i/n*pi),2); %�����Եë��
    end
    freq=fft(sig,n);
    logamp=log(abs(freq));
    cp=abs(ifft(logamp));
    if(nargin>3)
        plot(0:1/n:1-1/n,cp(1:n));
        xlim([0.002,xmax]);
        ylim([0,0.7]);
    end
    varargout{1}=cp;
    
    if(nargout>=2)
        varargout{2}(1)=mean(varargout{1}(round(0.005*n):round(0.1*n)));
    end

    absmax=0; 
    argmax=0;
    k=0;
    maxth=0.2; % min ratio between consequent peaks
    flatth=0.03;
    width=12;
    peak=zeros(1,2);
    for i=width+1:n-width
        if(i>n-width)
            break;
        end
        if (cp(i) == max(cp(i-width:i+width)) && cp(i)>absmax*maxth && cp(i)>flatth)
            if(k==0)
                width = round(0.7*i); 
                if(cp(i)~=max(cp(i-width:i+width)))
                    continue;
                end
                % For fundamental freq,
                % Assume no chord at the moment
                % will be improved afterwards 
                % (By only considering the basic series)
            end
            argmax=i;
            absmax=cp(i);
            k=k+1;
            peak(k,1)=(i-1)/xmax;
            peak(k,2)=absmax;
            if(nargin>3)
                text(peak(k,1)/fs,peak(k,2),num2str(round(peak(k,2)*100)));
            end
        end
    end
    if(nargout >= 3)
        varargout{3}=peak;

    end
    
end