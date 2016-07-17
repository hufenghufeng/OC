classdef outputTmap
    %output of the Tmap
    %       
    properties
        top;
        bottom;
        topTemp;
        bottomTemp;
    end
    
    methods
        function lo=outputTmap()
            lo.top   =[];
            lo.bottom=[];
            lo.topTemp=[];
            lo.bottomTemp=[];
        end
        
        function [obj] = GenerateTempOutput(obj, channel, setCoolingEnergy )
        %run simulation under given cooling energy and channel. 
        %   
            dlmwrite('channel1.dat',channel,'\t');
            !./do_simulate.sh

%             load cooling_energy.dat
%             load Pin.dat
% 
%             if cooling_energy<0.00001
%                 fprintf(stderr,'\nwrong channel, cooling energy is almost 0!');
%             end
% 
%             Pin(1)=Pin(1)*sqrt(setCoolingEnergy/cooling_energy);
%             dlmwrite('Pin.dat',Pin,'\t');
%             !./do_simulate.sh  
            
            load output1.txt
            load output2.txt

            output1=TurnoverMatrix(output1);
            output2=TurnoverMatrix(output2);
        
            obj.topTemp   =output1;
            obj.bottomTemp=output2;
        end
        % keep the output for the comparision of the next time
        function [obj]=UpdateOutput(obj)
            obj.top=obj.topTemp;
            obj.bottom=obj.bottomTemp;
        end  
        
        function [nowdeltaTMaxOfPart1]=TempDeltaTOfPart1(obj)
            deltaTTopOfPart1    =max(max(obj.topTemp(51:101,1:50)))   -min(min(obj.topTemp(51:101,1:50)));
            deltaTBottomOfPart1 =max(max(obj.bottomTemp(51:101,1:50)))-min(min(obj.bottomTemp(51:101,1:50)));
            nowdeltaTMaxOfPart1 =max(deltaTTopOfPart1,deltaTBottomOfPart1);             
        end
        
        function [nowdeltaTMaxOfPart2]=TempDeltaTOfPart2(obj)
            deltaTTopOfPart2    =max(max(obj.topTemp(1:50,1:50)))   -min(min(obj.topTemp(1:50,1:50)));
            deltaTBottomOfPart2 =max(max(obj.bottomTemp(1:50,1:50)))-min(min(obj.bottomTemp(1:50,1:50)));
            nowdeltaTMaxOfPart2 =max(deltaTTopOfPart2,deltaTBottomOfPart2);             
        end

        function [nowdeltaTMaxOfPart3]=TempDeltaTOfPart3(obj)
            deltaTTopOfPart3    =max(max(obj.topTemp(51:101,51:101)))   -min(min(obj.topTemp(51:101,51:101)));
            deltaTBottomOfPart3 =max(max(obj.bottomTemp(51:101,51:101)))-min(min(obj.bottomTemp(51:101,51:101)));
            nowdeltaTMaxOfPart3 =max(deltaTTopOfPart3,deltaTBottomOfPart3);             
        end

        function [nowdeltaTMaxOfPart4]=TempDeltaTOfPart4(obj)
            deltaTTopOfPart4    =max(max(obj.topTemp(1:50,51:101)))   -min(min(obj.topTemp(1:50,51:101)));
            deltaTBottomOfPart4 =max(max(obj.bottomTemp(1:50,51:101)))-min(min(obj.bottomTemp(1:50,51:101)));
            nowdeltaTMaxOfPart4 =max(deltaTTopOfPart4,deltaTBottomOfPart4);             
        end        
        
        function [nowdeltaTMax,Tmax]=TempResultOfAll(obj)
            deltaTTop    =max(max(obj.topTemp))   -min(min(obj.topTemp));
            deltaTBottom =max(max(obj.bottomTemp))-min(min(obj.bottomTemp));
            nowdeltaTMax =max(deltaTTop,deltaTBottom); 
            Tmax         =max([max(max(obj.topTemp)),max(max(obj.bottomTemp))]);
        end  
        
        function [ Tmax,Tmin,deltaTMax,dt1,dt2,dt3,dt4,Tmax1,Tmax2,Tmax3,Tmax4,pressure ] = tempOutputToTempResult(obj)
        %load output.dat, return Tmax, Tmin, DeltaT, pressureIn
            load Pin.dat
            output1=obj.topTemp;
            output2=obj.bottomTemp;
            Tmax         =max([max(max(output1)),max(max(output2))]);
            Tmin         =min([min(min(output1)),min(min(output2))]);
            deltaTTop   =max(max(output1))-min(min(output1));
            deltaTBottom=max(max(output2))-min(min(output2));
            deltaTMax   =max(deltaTTop,deltaTBottom);    
            dt1=TempDeltaTOfPart1(obj);
            dt2=TempDeltaTOfPart2(obj);
            dt3=TempDeltaTOfPart3(obj);
            dt4=TempDeltaTOfPart4(obj);
            Tmax1=max([max(max(output1(52:101,1:50))),max(max(output2(52:101,1:50)))]);
            Tmax2=max([max(max(output1(1:50,1:50))),max(max(output2(1:50,1:50)))]);
            Tmax3=max([max(max(output1(52:101,52:101))),max(max(output2(52:101,52:101)))]);
            Tmax4=max([max(max(output1(52:101,52:101))),max(max(output2(52:101,52:101)))]);
            pressure=Pin(1);
        end  
        
        function [fillChoice]=WhichLayerIsDominant(obj)
            % fillChoice: 1 top is dominant
            %             2 bottom is dominant
            output1=obj.topTemp;
            output2=obj.bottomTemp;
            deltaTTop   =max(max(output1))-min(min(output1));
            deltaTBottom=max(max(output2))-min(min(output2));            
            if deltaTTop > deltaTBottom
                fillChoice=1;
            else
                fillChoice=2;
            end
        end
    end
end

