function [ CE ] = SearchCE( dtConst, TmaxConst )
% Given channel and constraints, search the min cooling energy
%   
    load cooling_energy.dat;
    CE=cooling_energy;
    [dtNow,tmaxNow]=GetDeltaTandTmax(CE);
    
    if((EqualDT(dtNow,dtConst))&&(tmaxNow<TmaxConst))
        return;
    else if((dtNow>dtConst)||(tmaxNow>TmaxConst))
            lowerBoundry=CE;
            % search for upper boundry
            while(dtNow>dtConst||tmaxNow>TmaxConst)
                lowerBoundry=CE;
                CE=BitControl(CE*1.4);
                [dtNow,tmaxNow]=GetDeltaTandTmax(CE);
                % satisfy constraints?
                if((EqualDT(dtNow,dtConst))&&(tmaxNow<TmaxConst))
                    return;
                end
            end
            upperBoundry=CE;
        else
            upperBoundry=CE;
            % search for lower boundry
            while(dtNow<dtConst&&tmaxNow<TmaxConst)
                upperBoundry=CE;
                CE=BitControl(CE*0.6);
                [dtNow,tmaxNow]=GetDeltaTandTmax(CE);
                if((EqualDT(dtNow,dtConst))&&(tmaxNow<TmaxConst))
                    return;
                end                
            end
            lowerBoundry=CE;
        end
    end
    
    CE=BinarySearchCE(lowerBoundry,upperBoundry,dtConst,TmaxConst);

end

function [ CE ] = BinarySearchCE( lower, upper, dtConst, TmaxConst )
% Binary search the Cooling Energy that satisfy constraints
%   
    CE=0.0;
    while(1)
        mid=BitControl((lower+upper)/2);
        [dt,tmax]=GetDeltaTandTmax(mid);
        if (EqualCE(dt,dtConst)&&(tmax<TmaxConst))
            CE=mid;
            return;
        else if ((dt>dtConst)||tmax>TmaxConst)
                lower=mid;
            else
                upper=mid;
            end
        end
        if(EqualCE(lower,upper))
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

function [ CEflag ] = EqualCE( lh,rh )
% Judge if two floating number is equal, eg abs(lh-rh)<0.00001
%   
    if(abs(lh-rh)<0.00005)
        CEflag=1;
    else
        CEflag=0;
    end
end

function [ DTflag ] = EqualDT( lh,rh )
% Judge if two floating number is equal, eg abs(lh-rh)<0.01
%   
    if(abs(lh-rh)<0.05)
        DTflag=1;
    else
        DTflag=0;
    end
end