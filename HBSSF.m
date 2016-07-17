clear all
close all
format long

size=101;

%% set case
test_case='case1/test_case_01.stk';
fid=fopen('case_name','w');
fprintf(fid,test_case);
fclose(fid);

%% initial input channel

initial_index=503;
channel    =initialChannel(initial_index);
new_channel=channel;
markChannel=channel; % if channel cell is marked ,we won't choose it
%% condition and constraints

set_energy=0.11;         % the cooling energy you set (w)
DTset     =10;
Tthred    =0.5;
fix_cooling_energy=1;   % the simulation option

totalSteNum       =10;
evaluate_number   =1; % fill 1,or 2, or 3 cells one time

%% configure
cartoon_flag      =0;% show cartoon       ?
fix_cooling_energy=1;% fix cooling energy ? else fix pressure
fill_choice       =1;% 0:no preference               1: fill bottom channel layer 2: fill top channel layer
change_set_energy =0;% 0:keep set_enenrgy constant   1: keep the deltaT in a small domain while change set_energy

%% initial output 
step          =1;
evaluate_index=1;
GenerateOutput(channel,set_energy);

load output1.txt;
load output2.txt;
topTmap   =TurnoverMatrix(output2);
bottomTmap=TurnoverMatrix(output1);
%% initial results
index_axis(evaluate_index)   =step;% for convenience for draw figure

[Tmax(evaluate_index),...
 Tmin(evaluate_index),...
 deltaT.top(evaluate_index),...
 deltaT.bottom(evaluate_index),...
 deltaT.max(evaluate_index),...
 pressureIn(evaluate_index)]=OutputToResult();

step          =2;
evaluate_index=2;

best_channel=channel;   % the best channel
best_cost   =10000;     % the best cost
best_step   =1;         % the best step
%% begin my work
waiterWins=1;
loserWins=0;
%removeLocations=[]; % accelate finding Tmin
remove.Counter=0;
topLoser   =loser();
bottomLoser=loser();

while (step<totalSteNum)
%% choose waiter
if waiterWins
    [topWaiterRow,topWaiterCol]      =GetLocationOfUnmarkdTmin(topTmap   ,markChannel,remove.Location);
    [bottomWaiterRow,bottomWaiterCol]=GetLocationOfUnmarkdTmin(bottomTmap,markChannel,remove.Location);
    
    waiterRow=bottomWaiterRow;
    waiterCol=bottomWaiterCol;
end    
%% choose waiter or loser ?
    [waiterWins,loserWins]=WhoWins(0.8);

%% if waiter wins
    if waiterWins
        
        remove.Counter=remove.Counter+1;    
        remove.Rows(remove.Counter)=waiterRow;
        remove.Cols(remove.Counter)=waiterCol;      
        remove.Location(remove.Counter)=(remove.Rows-1)*101+remove.Cols;

        fillRow=waiterRow;
        fillCol=waiterCol;

        markChannel(waiterRow,waiterCol)=0;

%% loser wins                
    else
        topLoser   =UpdateLoserList(topTmap);
        bottomLoser=UpdateLoserList(bottomTmap);
        [fillRow,fillCol]=bottomLoser.ChooseOneLoser();
    end
%% fill     
         new_channel=fillChannel(new_channel,fillRow,fillCol);
%          remove_rows(step)=fillRow;
%          remove_cols(step)=fillCol;         
    %%  evaluate the new channel 
            if(mod(step,evaluate_number)==0||evaluate_number==1)
                GenerateOutput(new_channel,set_energy);
                load output1.txt
                load output2.txt
                tempTopTmap   =TurnoverMatrix(output2);
                tempBottomTmap=TurnoverMatrix(output1);   

                [Tmax(evaluate_index),...
                 Tmin(evaluate_index),...
                 deltaT.top(evaluate_index),...
                 deltaT.bottom(evaluate_index),...
                 deltaT.max(evaluate_index),...
                 pressureIn(evaluate_index)]=OutputToResult();     
             %% accept the new channel?
             % exp(-1)=0.01, 200*--->fill one bolck ,deltaT rise 0.025K , the accept probability is 0.01 
             %               400*--->fill one bolck ,deltaT rise 0.0125K, the accept probability is 0.01 
                if(evaluate_index>1)
                     if(((deltaT.max(evaluate_index)-deltaT.max(evaluate_index-1))<=0||rand<exp(-50*(deltaT.max(evaluate_index)-deltaT.max(evaluate_index-1))/evaluate_number))&&(cooling_energy>0.0001)&&(Tmax(evaluate_index)<1000))
                         topTmap   =tempTopTmap;
                         bottomTmap=tempBottomTmap;
                         channel   =new_channel;
                         acceptArray(evaluate_index)=1; 
                         % accept -->take down the channel
                         if strcmp(test_case,'case5/test_case_05.stk')
                             if(max(deltaT.top(evaluate_index),deltaT.bottom(evaluate_index))<best_cost&&Tmax(evaluate_index)<388.1)%338.1
                                 best_pressure=Pin(1);
                                 best_cost=max(deltaT.top(evaluate_index),deltaT.bottom(evaluate_index));
                                 best_channel=channel;
                                 best_step=step;
                                 best_evaluate_index=evaluate_index;
                             end 
                         else
                             if(deltaT.max(evaluate_index)<best_cost&&Tmax(evaluate_index)<358)%358
                                 best_channel=channel;
                                 best_step=step;
                                 best_evaluate_index=evaluate_index;
%                                  %% change set_energy?
%                                  if (change_set_energy)
%                                      if (abs(deltaT.max(evaluate_index)-DTset)>Tthred)
%                                          [Pin(1),deltaT.max(evaluate_index)]=SetDeltT(test_case,DTset,channel);
%                                          load cooling_energy.dat;
%                                          set_energy=cooling_energy;
%                                      end
%                                  end
                                 best_pressure=Pin(1);
                                 best_cost=deltaT.max(evaluate_index);
                             end
                         end
                         index_axis(evaluate_index)=step;
                         fprintf('\n accept!!\n');
                         if loserWins
                            topLoser   =topLoser.RemoveLoser(loserRow,loserCol);
                            bottomLoser=bottomLoser.RemoveLoser(loserRow,loserCol);
                         end
                     else                        
                         new_channel                 =channel;
                         index_axis(evaluate_index)  =step;
                         Tmax(evaluate_index)        =Tmax(evaluate_index-1);
                         Tmin(evaluate_index)        =Tmin(evaluate_index-1);
                         deltaT.top(evaluate_index)  =deltaT.top(evaluate_index-1);
                         deltaT.bottom(evaluate_index)=deltaT.bottom(evaluate_index-1);
                         deltaT.max(evaluate_index)   =deltaT.max(evaluate_index-1);
                         coolingpower(evaluate_index) =coolingpower(evaluate_index-1);
                         pressureIn(evaluate_index)   =pressureIn(evaluate_index-1);
                         Pin(1)                       =pressureIn(evaluate_index-1);
                         acceptArray(evaluate_index)  =0;
                         fprintf('\n reject!\n');
                         % if waiter is rejected 
                            if waiterWins
                                topLoser   =topLoser.AddToLoserList(fillRow,fillCol);
                                bottomLoser=bottomLoser.AddToLoserList(fillRow,fillCol);
                            else
                         % loser is rejected 
                                topLoser   =topLoser.PlusTOfRejectedLoser(fillRow,fillCol);
                                bottomLoser=bottomLoser.PlusTOfRejectedLoser(fillRow,fillCol);
                            end
                     end     
                end 
                fprintf('the deltaT is: %f\n',deltaT.max(evaluate_index));
                %% try cartoon  
                if cartoon_flag==1
                     DrawChannel(channel);
                     drawnow
                     F(evaluate_index-1)=getframe(cartoon);                    

                     [C,h]=contourf(output2,50);
                     set(h,'ShowText','on','TextStep',get(h,'LevelStep')*5);
                     drawnow
                     T(evaluate_index-1)=getframe(Tmap_top);
                end    
                evaluate_index=evaluate_index+1;                
            end     
            
    fprintf('the step is %d,the fill location is (%d,%d)\n',fillRow,fillCol);    
    step=step+1;
end