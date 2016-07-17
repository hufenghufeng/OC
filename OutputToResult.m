function [ Tmax,Tmin,deltaTTop,deltaTBottom,deltaTMax,pressure ] = OutputToResult()
%load output.dat, return Tmax, Tmin, DeltaT, pressureIn
%   load output
    load output1.txt
    load output2.txt
    load Pin.dat
    
    Tmax         =max([max(max(output1)),max(max(output2))]);
    Tmin         =min([min(min(output1)),min(min(output2))]);
    deltaTTop   =max(max(output1))-min(min(output1));
    deltaTBottom=max(max(output2))-min(min(output2));
    deltaTMax   =max(deltaTTop,deltaTBottom);    
    
    pressure=Pin(1);
end

