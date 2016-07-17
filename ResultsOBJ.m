classdef ResultsOBJ
    % keep the history results
    % 
    
    properties
        deltaTMax
        Tmax
        Tmin
        pressure
        deltaT1
        deltaT2
        deltaT3
        deltaT4
        Tmax1
        Tmax2
        Tmax3
        Tmax4
        filledR
        filledC
        filledT
        filledF % 0: whether unfillable is unknown 1:good!,unfillable; -1 :bad
    end
    
    methods
        function lo=ResultsOBJ()
            lo.deltaTMax=[];
            lo.Tmax=[];
            lo.Tmin=[];
            lo.pressure=[];
            lo.deltaT1=[];
            lo.deltaT2=[];
            lo.deltaT3=[];
            lo.deltaT4=[]; 
            lo.Tmax1=[];
            lo.Tmax2=[];
            lo.Tmax3=[];
            lo.Tmax4=[];
            lo.filledR=[];
            lo.filledC=[];
            lo.filledT=[];
            lo.filledF=[];
        end
        
        function [obj]=FirstBasicResult(obj,Tmax,Tmin,deltaTMax,dt1,dt2,dt3,dt4,Tmax1,Tmax2,Tmax3,Tmax4,pressure)
            if isempty(obj.Tmax)
                obj.Tmax(1)=Tmax;
                obj.Tmin(1)=Tmin;
                obj.deltaTMax(1)=deltaTMax;
                obj.pressure(1)  =pressure;   
                obj.deltaT1(1)=dt1;
                obj.deltaT2(1)=dt2;
                obj.deltaT3(1)=dt3;
                obj.deltaT4(1)=dt4;  
                obj.Tmax1(1)=Tmax1;
                obj.Tmax2(1)=Tmax2;
                obj.Tmax3(1)=Tmax3;
                obj.Tmax4(1)=Tmax4;
            else
                fprintf('error in accept the first results!\n');
            end
        end 

        function [flag,obj]=anneaingEvaluate(obj,Tmax,Tmin,deltaT,sa,R,C)
            lastIndex=length(obj.deltaTMax);
            dcost=deltaT-obj.deltaTMax(lastIndex);
            if dcost<=0||(rand()<exp(-dcost/sa.T))
                flag=1;
                % take down fill history
                obj.filledR=[obj.filledR,R];
                obj.filledC=[obj.filledC,C];
                for i=1:length(R)
                   obj.filledT=[obj.filledT,dcost/length(R)]; 
                   obj.filledF=[obj.filledF,0];
                end
            else
                flag=0;
            end           
        end   
                
        function [flag,obj]=whetherAccept(obj,Tmax,Tmin,deltaT)
            lastIndex=length(obj.deltaTMax);
            if deltaT<=obj.deltaTMax(lastIndex)
                flag=1;
            else
                flag=0;
            end
        end
        
        function [part1,part2,part3,part4,obj]=WhetherAcceptOfPart(obj,Tmax,Tmin,deltaTMax,dt1,dt2,dt3,dt4,tmax1,tmax2,tmax3,tmax4,pressure)
           
            lastIndex=length(obj.deltaT1);
%            if dt1<=obj.deltaT1(lastIndex)
            if dt1<=obj.deltaT1(lastIndex)&&(~((obj.isMax(tmax1,tmax1,tmax2,tmax3,tmax4))&&(tmax1>obj.Tmax1(lastIndex))))
                %accept
                part1=1;
            else
                part1=0;
            end
%            if dt2<=obj.deltaT2(lastIndex)
            if dt2<=obj.deltaT2(lastIndex)&&(~((obj.isMax(tmax2,tmax1,tmax2,tmax3,tmax4))&&(tmax2>obj.Tmax2(lastIndex))))
                part2=1;
            else
                part2=0;
            end 
%            if dt3<=obj.deltaT3(lastIndex)
            if dt3<=obj.deltaT3(lastIndex)&&(~((obj.isMax(tmax3,tmax1,tmax2,tmax3,tmax4))&&(tmax3>obj.Tmax3(lastIndex))))
                part3=1;
            else
                part3=0;
            end  
%            if dt4<=obj.deltaT4(lastIndex)
            if dt4<=obj.deltaT4(lastIndex)&&(~((obj.isMax(tmax4,tmax1,tmax2,tmax3,tmax4))&&(tmax4>obj.Tmax4(lastIndex))))
                part4=1;
            else
                part4=0;
            end                             
            % if all rejected
%             if (part1==0)&&(part2==0)&&(part3==0)&&(part4==0)
%                 obj.Tmax(obj.Tmax.length+1)=obj.Tmax(obj.Tmax.length);
%                 obj.Tmin(obj.Tmin.length+1)=obj.Tmin(obj.Tmin.length);
%                 obj.deltaTMax(obj.deltaTMax.length+1)=obj.deltaTMax(obj.deltaTMax.length);
%                 obj.pressure(obj.pressure.length+1)=obj.pressure(obj.pressure.length);
%             else
%                 obj.Tmax(obj.Tmax.length+1)=Tmax;
%                 obj.Tmin(obj.Tmin.length+1)=Tmin;
%                 obj.deltaTMax(obj.deltaTMax.length+1)=deltaTMax;
%                 obj.pressure(obj.pressure.length+1)  =pressure;
%             end
        end
        
        function [obj]=UpdateResults(obj,Tmax,Tmin,deltaTMax,dt1,dt2,dt3,dt4,Tmax1,Tmax2,Tmax3,Tmax4,pressure)
            Index=length(obj.Tmax)+1;
            obj.Tmax(Index)=Tmax;
            obj.Tmin(Index)=Tmin;
            obj.deltaTMax(Index)=deltaTMax;
            obj.pressure(Index)  =pressure;   
            obj.deltaT1(Index)=dt1;
            obj.deltaT2(Index)=dt2;
            obj.deltaT3(Index)=dt3;
            obj.deltaT4(Index)=dt4;  
            obj.Tmax1(Index)=Tmax1;
            obj.Tmax2(Index)=Tmax2;
            obj.Tmax3(Index)=Tmax3;
            obj.Tmax4(Index)=Tmax4;
        end
        
        function [obj]=CopyLastResults(obj)
            Index=length(obj.Tmax);
            obj.Tmax(Index+1)=obj.Tmax(Index);
            obj.Tmin(Index+1)=obj.Tmin(Index);
            obj.deltaTMax(Index+1)=obj.deltaTMax(Index);
            obj.pressure(Index+1)  =obj.pressure(Index);   
            obj.deltaT1(Index+1)=obj.deltaT1(Index);
            obj.deltaT2(Index+1)=obj.deltaT2(Index);
            obj.deltaT3(Index+1)=obj.deltaT3(Index);
            obj.deltaT4(Index+1)=obj.deltaT4(Index);  
            obj.Tmax1(Index+1)=obj.Tmax1(Index);
            obj.Tmax2(Index+1)=obj.Tmax2(Index);
            obj.Tmax3(Index+1)=obj.Tmax3(Index);
            obj.Tmax4(Index+1)=obj.Tmax4(Index);             
        end
        
        function []=ShowFinalResults(obj)
            Index=length(obj.Tmax);
            figure(7)
            title('deltaT')
            plot(1:Index,obj.deltaTMax,'-g');
            figure(6)
            title('Tmax & Tmin')
            plot(1:Index,obj.Tmax,'-r',1:Index,obj.Tmin,'b');
            figure(5)
            title('pressure')
            plot(1:Index,obj.pressure,'p');
            figure(4)
            title('deltaT in four part')
            plot(1:Index,obj.deltaT1,'-or',1:Index,obj.deltaT2,'y',1:Index,obj.deltaT3,'p',1:Index,obj.deltaT4,'b');
        end
        
        function [isMax]=isMax(obj,num,tmax1,tmax2,tmax3,tmax4)
            maxNum=max([tmax1,tmax2,tmax3,tmax4]);
            if(abs(num-maxNum)<0.1)
                isMax=true;
            else
                isMax=false;
            end
        end
        
    end    
end

