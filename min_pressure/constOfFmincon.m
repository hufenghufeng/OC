function [ satisfy,ceq ] = constOfFmincon(x,Tmax,DTmax)
% The constraints for fmincon
%   if satisfy the thermal constraints, satisfy=-1 else satisfy=1
    format long
    
    global P
    global TMAX
    global DT
    global res
    
    load Pin.dat;
    Pin(1)=x*1000;
    dlmwrite('Pin.dat',Pin,'\t');
    
    !./do_simulate.sh
    satisfy=0;
    ceq=0.0;
    load output1.txt
    load output2.txt

     DeltaT1=max(max(max(output1))-min(min(output1)),max(max(output2))-min(min(output2)));  
     maxT1  =max([max(max(output1)),max(max(output2))]);
     P=[P x];
     TMAX=[TMAX maxT1];
     DT=[DT DeltaT1];
     if maxT1<=273.15+Tmax && DeltaT1<=DTmax
         satisfy=-1*DeltaT1;
         if x<res
             res=x;
         end
         return
     else
         if maxT1>273.15+Tmax
             satisfy=satisfy+maxT1;
         end
         if DeltaT1> DTmax
             satisfy=satisfy+DeltaT1;
         end
         return
     end
end

