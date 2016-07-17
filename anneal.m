clear all
close all
format long

size=101;
%%  configure

test_case='case1/test_case_01.stk';
fid=fopen('case_name','w');
fprintf(fid,test_case);
fclose(fid);

initial_index=212;
initChannel=initialChannel(initial_index);
% load mode.dat
% load step_num.dat
mode=1;
step_num=400;
set_energy=0.001;  % the cooling energy you set (w)

cartoon_flag      =1;% show cartoon       ?
fix_cooling_energy=1;% fix cooling energy ? else fix pressure
fill_choice       =1;% 0:no preference               1: fill bottom channel layer 2: fill top channel layer
change_set_energy =0;% 0:keep set_enenrgy constant   1: keep the deltaT in a small domain while change set_energy
%% initial input channel 
if (mode==1)||(mode==3)
    channel=initialChannel(initial_index);
else
    ! rm channel1_backup.dat
    ! cp channel1.dat channel1_backup.dat
    load channel1_backup.dat
    channel=channel1_backup;
end
%% initial Object
channelObj   =channelOBJ(channel);
outputTmapObj=outputTmap();
outputTmapObj=outputTmapObj.GenerateTempOutput(channel,set_energy);
outputTmapObj=outputTmapObj.UpdateOutput();
resultObj    =ResultsOBJ();
saObj        =SA(0.2,0.1,40,0.98,0.99,1000);

tempChannel=channel; % temp channel for evaluating accepting or not
bestChannel=channel;

[bestTmax,bestTmin,bestDeltaT,bestDt1,bestDt2,bestDt3,bestDt4,Tmax1,Tmax2,Tmax3,Tmax4,bestPressure]=outputTmapObj.tempOutputToTempResult();
resultObj=resultObj.FirstBasicResult(bestTmax,bestTmin,bestDeltaT,bestDt1,bestDt2,bestDt3,bestDt4,Tmax1,Tmax2,Tmax3,Tmax4,bestPressure);

step=1;
%% show  catoon 

%Set a position to explicitly impose on your figure
pixelLowerLeftCorner = [100 100];
pixelWidth = 1024;
pixelHeight = 1024;
% Pixel width must be a multiple of 4, for whatever reason, to avoid
% slanty-ness. The 'pixelHeight' value doesn't matter, can be anything.
if mod(pixelWidth,4)~=0
    % Make sure it's a multiple of 4
    pixelWidth = pixelWidth + mod(pixelWidth,4);
end
figurePosition = [pixelLowerLeftCorner pixelWidth pixelHeight];
% You need to undock your figure window or it won't let you change its size
f1 = figure('WindowStyle', 'normal', 'Position', figurePosition );

% Now make the axis fill the entire figure window
h1 = gca;
axisPosition = [0 0 1 1];
set(h1,'Position',axisPosition)

    cartoon=figure('name','cartoon of my!');
    set(cartoon,'Position',[0 0 1024 1024]);
    set(gcf,'nextplot','replacechildren');
%     channelCartoon=figure('name','channel');
%     set(channelCartoon,'Position',[0 0 1024 1024]);
%% begin filling loop
Tindex=[];
TacceptRatioOfBad=[];
while (saObj.T>=saObj.Tcold && step<step_num)
    
    stepsPerT=0;
    acceptNum=0;
    rejectNum=0;
    while(stepsPerT<2*saObj.Kmoves && acceptNum<saObj.Kmoves)
        
        stepsPerT=stepsPerT+1;
        Tindex=[Tindex,saObj.T];
        TacceptRatioOfBad=[TacceptRatioOfBad,exp(-saObj.deltaTavg/saObj.T)];
        
        if mod(step,10)==9
           [R1,C1,resultObj]=channelObj.ChooseOneForRecover(resultObj);
           fprintf('recover!(%d,%d)\n',R1,C1);
           if length(R1)<1
               continue;
           end
           tempChannel=recoverChannel(channelObj.channel,initChannel,R1,C1);
        else
           %% choose cells to fill
           fillChoice=outputTmapObj.WhichLayerIsDominant();
           if fillChoice==1
               choosenTmap=outputTmapObj.topTemp;
           else
               choosenTmap=outputTmapObj.bottomTemp;
           end

           [R1,C1,channelObj]    =channelObj.topNForFill(choosenTmap,2);
   
           %% temp channel for evaluating
           for i=1:length(R1)
               tempChannel=fillChannel(channelObj.channel,R1(i),C1(i));
           end
        end

        
           %% remove the dead block in channel                 
           if(step>200&&mod(step,50)==1)
              load pressure.dat;
              tempChannel=RemoveDeadBlock(pressure,tempChannel);
           end  
           %% evaluate in four part
           outputTmapObj=outputTmapObj.GenerateTempOutput(tempChannel,set_energy);
           [Tmax,Tmin,deltaTMax,dt1,dt2,dt3,dt4,Tmax1,Tmax2,Tmax3,Tmax4,pressure]=outputTmapObj.tempOutputToTempResult();
           [part1,resultObj]=resultObj.anneaingEvaluate(Tmax,Tmin,deltaTMax,saObj,R1,C1);
           

           %% get new channel
           if part1
               acceptNum=acceptNum+1;
                         
               channelObj=channelObj.UpdateChannel(tempChannel);
%                for i=1:length(R1)
%                 channelObj=channelObj.FillPart1(R1(i),C1(i));
%                end
               %% update Tmap
               outputTmapObj=outputTmapObj.UpdateOutput();
               %% update results
               [Tmax,Tmin,deltaTMax,dt1,dt2,dt3,dt4,Tmax1,Tmax2,Tmax3,Tmax4,pressure]=outputTmapObj.tempOutputToTempResult();
               resultObj=resultObj.UpdateResults(Tmax,Tmin,deltaTMax,dt1,dt2,dt3,dt4,Tmax1,Tmax2,Tmax3,Tmax4,pressure);
               %% take down the best
               if deltaTMax<bestDeltaT
                   bestDeltaT=deltaTMax;
                   bestTmax=Tmax;
                   bestTmin=Tmin;
                   bestPressure=pressure;
                   bestStep=step;
                   bestChannel=channelObj.channel;
               end       
           else
               rejectNum=rejectNum+1;
               resultObj=resultObj.CopyLastResults();
           end

           step=step+1;
           %% notification 
           fprintf('the deltaT is： %f\n',deltaTMax);
           fprintf('step is %d \n',step);
        %   fprintf('1:accept 0:reject\n');
            %% try cartoon  
            if cartoon_flag==1
                 DrawChannel(tempChannel);
                 drawnow
                 F(step-1)=getframe(cartoon);                    
        %          [C,h]=contourf(output2,50);
        %          set(h,'ShowText','on','TextStep',get(h,'LevelStep')*5);
        %          drawnow
        %          T(step-1)=getframe(Tmap_top);
            end              
    end
    %% stop annealing 
    if saObj.StopAnnealing(rejectNum,stepsPerT)
        break
    end
    %% drop T of annealing 
    saObj=saObj.DropSAT();
end

resultObj.ShowFinalResults();

% if cartoon_flag==1
%     movie2avi(F,'LTchannel.avi','compression','None','fps',5);
% end    

channel_name=['results_version3/',test_case,'_',num2str(bestDeltaT),'k_',num2str(bestPressure),'pa_',num2str(set_energy),'w_',int2str(initial_index),'.dat'];
dlmwrite('channel1.dat',bestChannel,'\t');
dlmwrite(channel_name  ,bestChannel,'\t');