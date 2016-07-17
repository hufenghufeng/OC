function [ CE ] = BinarySearchCE( lower, upper, dtConst, TmaxConst )
% Binary search the Cooling Energy that satisfy constraints
%   
    CE=0.0;
    while(1)
        mid=BitControl((lower+upper)/2);
        [dt,tmax]=GetDeltaTandTmax(mid);
        if (Equal(dt,dtConst)&&(tmax<TmaxConst))
            CE=mid;
            return;
        else if ((dt>dtConst)||tmax>TmaxConst)
                lower=mid;
            else
                upper=mid;
            end
        end
        if(Equal(lower,upper))
            fprintf('binary search CE not found');
            return;
        end
    end
end


function [ controledX ] = BitControl( x )
%control the floating x to the same bits as 0.0011
    controledX=(round(x*10000))/10000;
end

function [DeltaT,maxT]= GetDeltaTandTmax(ce)

     dlmwrite('cooling_energy.dat',ce,'\t');     
     !./do_simulate.sh
     load output1.txt
     load output2.txt
     DeltaT=max(max(max(output1))-min(min(output1)),max(max(output2))-min(min(output2)));  
     maxT  =max([max(max(output1)),max(max(output2))]);
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