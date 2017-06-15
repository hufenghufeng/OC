clear all
format long

global P;
global TMAX;
global DT;
global res

P=[];
TMAX=[];
DT=[];
res=inf;

Tmax=85;
DTmax=10;

i=1;

startPoint=[2  5  10  18 30];
for i =1:length(startPoint)
    x0=startPoint(i);
    oldoptions = optimoptions(@fmincon,'DiffMinChange',0.002*x0,'DiffMaxChange',0.1*x0,'Display','iter-detailed',...
        'TolCon',1,'TolX',0.0001,'FinDiffType','central');

    [x,fval]=fmincon(@myfun,x0,[],[],[],[],0.1,1000,@(x)constOfFmincon(x,Tmax,DTmax),oldoptions);
    
end

disp('The minimized pressure is:')
disp(res*1000)

n=length(P);
index=[];
for i=1:n
    index=[index i];
end

figure(1)
title('change of pressure')
plot(P)

figure(2)
title('CE vs DT')
plot(DT)

figure(3)
title('CE vs Tmax')
plot(TMAX)
