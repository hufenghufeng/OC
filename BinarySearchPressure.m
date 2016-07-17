function [Pset] = BinarySearchPressure(Pmin,Pmax,dTset)
%Given the deltaT you want and the search domain, return the Pressure that:
%   abs(dt-dTset))<Tthreshold
%   you need to set the case name in file 'case_name'

    Pmid=(Pmin+Pmax)/2;
    dt  =GetDeltaT(Pmid);
    if((abs(dt-dTset))<0.3)
        Pset = Pmid;
        return;
    else
        if (dt<dTset)
            Pset = BinarySearchPressure(Pmin,Pmid,dTset);
            return
        else
            Pset = BinarySearchPressure(Pmid,Pmax,dTset);
            return 
        end
    end
end

function DeltaT= GetDeltaT(pressure)
     load Pin.dat
     Pin(1)=pressure;
     dlmwrite('Pin.dat',Pin,'\t');     
     !./do_simulate.sh
     load output1.txt
     load output2.txt
     DeltaT=max(max(max(output1))-min(min(output1)),max(max(output2))-min(min(output2)));  
end

function [ flag ] = Equal( lh,rh )
% Judge if two floating number is equal, eg abs(lh-rh)<0.00001
%   
    if(abs(lh-rh)<0.00005)
        flag=1;
    else
        flag=0;
    end
end