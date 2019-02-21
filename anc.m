function [errl,errr,err2] = anc(xin,sin,mu,M,L,N)
% inputs:
% xin = reference signal
% sin = sound signal
% mu = stepsize > 0
% M = filter length
% L = number of samples needed to average RLS filter
% N = number of samples to process
% outputs:
% errl = lms filter output
% errr = rls filter output
xin = xin(:);
sin = sin(:);
hlms = [1,zeros(1,4)];
hlms = hlms';
hrls = hlms;
hlms2 = hlms;
errl = zeros(N,1);
errr = zeros(N,1);
err2 = zeros(N,1);
for n = M:N
    %LMS
    y = hlms' * xin(n:-1:n-M+1);
    errl(n) = sin(n) - y; %LMS error signal
    hlms = hlms + mu * xin(n:-1:n-M+1) * errl(n); %LMS h
    %/LMS
    
    %RLS + LMS L>1
    if n >= L + M
        rsx = 0;
        rxx = 0;

        

        temp = 0;
        for l = n-L+1:n
            rsx = rsx + xin(l:-1:l-M+1) * sin(l);
            rxx = rxx + xin(l:-1:l-M+1) * xin(l:-1:l-M+1)';
            
            y = hlms2' * xin(l:-1:l-M+1);
            e = sin(l) - y;
            temp = temp + e * xin(l:-1:l-M+1);
            err2(n) = err2(n) + e;
            
        end
        rsx = (1/L) * rsx;
        rxx = (1/L) * rxx;
        hrls = inv(rxx) * rsx; %RLS h
        errr(n) = sin(n) - hrls' * xin(n:-1:n-M+1); %RLS error signal
        
        err2(n) = err2(n)/L; %LMS L>1 error signal
        hlms2 = hlms2 + (mu/L) * temp; %LMS L>1 h

    end 

    
end 
plot(hlms)
hold
plot(hrls)
plot(hlms2)
hlms
hrls
hlms2
