clear all
close all
format long
%%
% this is the script for annealing , code is poor, I'll make it better
% later;

size=101;
index=5;
[testCase,dTConst,TmaxConst,CE,channelIndex,stepNum ] = Configure( index );
%% initial input channel
initial_index=channelIndex;
% load mode.dat
mode=1;
step_num=stepNum;
% load step_num.dat
if (mode==1)||(mode==3)
    channel=initialChannel(initial_index);
else
    ! rm channel1_backup.dat
    ! cp channel1.dat channel1_backup.dat
    load channel1_backup.dat
    channel=channel1_backup;
end
draw_channel=channel;
best_channel=channel;   % the best channel
best_cost   =10000;     % the best cost
best_step   =1;         % the best step

set_energy=CE;         % the cooling energy you set (w)
DTset=10;
Tthred=0.5;
fix_cooling_energy=1;   % the simulation option
index_axis(1)=1;
%% initial output Tmap
test_case=testCase;
% fid=fopen('case_name','w');
% fprintf(fid,test_case);
% fclose(fid);
 %[channel,final]=Best_Line(test_case);
new_channel=channel;
dlmwrite('channel1.dat',channel,'\t');

!./do_simulate.sh
% if fix_cooling_energy==1
%     load cooling_energy.dat
%     load Pin.dat
%     Pin(1)=Pin(1)*sqrt(set_energy/cooling_energy);
%     dlmwrite('Pin.dat',Pin,'\t');
%     fprintf('the cooling energy is 0.0065w\n')
%     !./do_simulate.sh  
% end
load Pin.dat
best_pressure=Pin(1);
            
load output1.txt
load output2.txt

temp1=max(max(output1))-min(min(output1));
temp2=max(max(output2))-min(min(output2));
best_cost=max(temp1,temp2);
% !!!!!!attention!!!!!
% the axis of channel and output is different!
% turnover the output frist!

output1=TurnoverMatrix(output1);
output2=TurnoverMatrix(output2);

balance1=output1-300;
balance2=output2-300;

Tlist_top   =balance1(:);
Tlist_bottom=balance2(:);

Tlist_top   =sort(Tlist_top);
Tlist_bottom=sort(Tlist_bottom);

step          =1;
index         =channel;
Tmin_top      =0;
Tmin_bottom   =0;
evaluate_index=1;
%% initial output parameters
index_axis(evaluate_index)   =step;
Tmax(evaluate_index)         =max([max(max(output1)),max(max(output2))]);
Tmin(evaluate_index)         =min([min(min(output1)),min(min(output2))]);
deltaT.top(evaluate_index)   =max(max(output1))-min(min(output1));
deltaT.bottom(evaluate_index)=max(max(output2))-min(min(output2));
deltaT.max(evaluate_index)   =max(deltaT.top(evaluate_index),deltaT.bottom(evaluate_index));
load cooling_energy.dat;
load Pin.dat
coolingpower(evaluate_index)=cooling_energy;
pressureIn(evaluate_index)  =Pin(1);

evaluate_index=2;
%% configure
cartoon_flag      =0;% show cartoon       ?
fix_cooling_energy=1;% fix cooling energy ? else fix pressure
fill_choice       =1;% 0:no preference               1: fill bottom channel layer 2: fill top channel layer
change_set_energy =0;% 0:keep set_enenrgy constant   1: keep the deltaT in a small domain while change set_energy
%% the total filling block number and after how many blocks has been filled you evaluate them and decide whether fill them or not
evaluate_number=3;
 %step_num       =400;
acceptArray(1) =0;
%% show  catoon 

% Set a position to explicitly impose on your figure
% pixelLowerLeftCorner = [100 100];
% pixelWidth = 1024;
% pixelHeight = 1024;
% % Pixel width must be a multiple of 4, for whatever reason, to avoid
% % slanty-ness. The 'pixelHeight' value doesn't matter, can be anything.
% if mod(pixelWidth,4)~=0
%     % Make sure it's a multiple of 4
%     pixelWidth = pixelWidth + mod(pixelWidth,4);
% end
% figurePosition = [pixelLowerLeftCorner pixelWidth pixelHeight];
% % You need to undock your figure window or it won't let you change its size
% f1 = figure('WindowStyle', 'normal', 'Position', figurePosition );
% 
% % Now make the axis fill the entire figure window
% h1 = gca;
% axisPosition = [0 0 1 1];
% set(h1,'Position',axisPosition)
% 
%     cartoon=figure('name','cartoon of my!');
%     set(cartoon,'Position',[0 0 1024 1024]);
%     set(gcf,'nextplot','replacechildren');
%     Tmap_top=figure('name','tempreture_top');
%     set(Tmap_top,'Position',[0 0 1024 1024]);
tic;

%% parameters for simulated annealing 
TdropRatio=0.98;
TdropStep=10;
averageDeltaT=0.1; % average change in deltaT 
acceptProbability =0.1; % the accept ratio if the deltaT rise 0.1K 
breakProbability  =0.99; % if the accrept ratio is below 1-breakProbability, then stop annealing
Tinital=-averageDeltaT/log(acceptProbability);
Tfinal =-averageDeltaT/log((1-breakProbability)/2);
Tnow=Tinital;
Tindex(1)=Tnow;
TacceptRatioOfBad(1)=0.1;
while  (step<step_num)
    %% reduce the evaluate_number as the step rise
    if mode ==3
            evaluate_number=floor(exp(1-step/100)+2);
    else
        evaluate_number=1;
    end
%      if(step>250)
%          evaluate_number=1;
%      end
     stepsPerT=0;
     acceptsNum=0;
     rejectNum=0;
     
     Tnow=Tnow*TdropRatio;
     while (stepsPerT<2*TdropStep&&acceptsNum<TdropStep)
         
         stepsPerT=stepsPerT+1;
         Tindex(evaluate_index)           =Tnow;
         TacceptRatioOfBad(evaluate_index)=exp(-averageDeltaT/Tnow);
         fprintf('the T of annealing is %f, the accept ratio is :%f\n',Tnow, exp(-averageDeltaT/Tnow))
    %% find the Tmin(only one) and the location of Tmin
     for i=1:10201
        flag=0;
        [top_rows,top_cols]=find(balance1==Tlist_top(i)); 
        for j=1:length(top_rows)
%            if(index(top_rows(j),top_cols(j))~=0&&index(top_rows(j),top_cols(j))~=-1)
            if(index(top_rows(j),top_cols(j))~=0)
                Tmin_top=Tlist_top(i);
                Tmin_top_rows=top_rows(j);
                Tmin_top_cols=top_cols(j);
                top_list_index=i;
                flag=1;
                break;
            end
        end
        
        if(flag==1)
            break
        end
     end  

     for i=1:10201
        flag=0;
        [bottom_rows,bottom_cols]=find(balance2==Tlist_bottom(i));  
        for j=1:length(bottom_rows)
%            if(index(bottom_rows(j),bottom_cols(j))~=0&&index(bottom_rows(j),bottom_cols(j))~=-1)
            if(index(bottom_rows(j),bottom_cols(j))~=0)
                Tmin_bottom=Tlist_bottom(i);
                Tmin_bottom_rows=bottom_rows(j);
                Tmin_bottom_cols=bottom_cols(j);
                bottom_list_index=i;
                flag=1;
                break;
            end
        end
        
        if(flag==1)
            break
        end
     end  
      
%%  fill the channel according to the Tmin   
    switch fill_choice
        case 0
            if (Tmin_top<Tmin_bottom)
                new_channel=fillChannel(new_channel,Tmin_top_rows,Tmin_top_cols);
                index(Tmin_top_rows,Tmin_top_cols)=0;
                remove_rows(step)=Tmin_top_rows;
                remove_cols(step)=Tmin_top_cols;
            %    Tlist_top(top_list_index)=[];
            else
                new_channel=fillChannel(new_channel,Tmin_bottom_rows,Tmin_bottom_cols); 
                index(Tmin_bottom_rows,Tmin_bottom_cols)=0;
                remove_rows(step)=Tmin_bottom_rows;
                remove_cols(step)=Tmin_bottom_cols;        
            %    Tlist_bottom(bottom_list_index)=[];
            end
        case 1
            new_channel=fillChannel(new_channel,Tmin_bottom_rows,Tmin_bottom_cols); 
            index(Tmin_bottom_rows,Tmin_bottom_cols)=0;
            remove_rows(step)=Tmin_bottom_rows;
            remove_cols(step)=Tmin_bottom_cols;                
        case 2
            new_channel=fillChannel(new_channel,Tmin_top_rows,Tmin_top_cols);
            index(Tmin_top_rows,Tmin_top_cols)=0;
            remove_rows(step)=Tmin_top_rows;
            remove_cols(step)=Tmin_top_cols;            
        otherwise
            warning('unknow fill channel layer');
    end
%% remove the dead block in channel                 
     if(step>200&&mod(step,50)==1)
         load pressure.dat;
         new_channel=RemoveDeadBlock(pressure,new_channel);
     end        
%% remove the rejected and filled channel from filling list,
    Tlist_top   =balance1(:);
    Tlist_bottom=balance2(:);
    if(step>1)
       remove_location=(remove_rows-1)*101+remove_cols;

       Tlist_top(remove_location)   =[];
       Tlist_bottom(remove_location)=[];
    end

    Tlist_top   =sort(Tlist_top);
    Tlist_bottom=sort(Tlist_bottom); 
    
%%  evaluate the new channel    
    if(mod(step,evaluate_number)==1||evaluate_number==1)
         dlmwrite('channel1.dat',new_channel,'\t');
         !./do_simulate.sh
         
        %% update the output            
            load output1.txt
            load output2.txt
         
        %% modefy the Pin to have the same cooling energy

            load cooling_energy.dat
            load Pin.dat

        %% adjust the power to 0.03w
%         if fix_cooling_energy==1
%             if cooling_energy<0.00001
%                 cooling_energy=coolingpower(evaluate_index-1);
%             end
%             Pin(1)=Pin(1)*sqrt(set_energy/cooling_energy);
%             dlmwrite('Pin.dat',Pin,'\t');
%             fprintf('the cooling energy is 0.0065w\n')
%             !./do_simulate.sh 
%             
%             load output1.txt
%             load output2.txt         
%         end       
        output1=TurnoverMatrix(output1);
        output2=TurnoverMatrix(output2);
        
        balance1=output1-300;
        balance2=output2-300;


        %   sort the T and choose the Tmin 
        %   find the location of the Tmin int the channel and the Tlist 

        Tlist_top   =balance1(:);
        Tlist_bottom=balance2(:);

        Tlist_top   =sort(Tlist_top);
        Tlist_bottom=sort(Tlist_bottom);

         %% evaluate
         %Tmax(evaluate_index)=max(Tlist_top(length(Tlist_top)),Tlist_bottom(length(Tlist_bottom)));
         %Tmin(evaluate_index)=min(Tlist_top(1),Tlist_bottom(1));
         Tmax(evaluate_index)         =max([max(max(output1)),max(max(output2))]);
         Tmin(evaluate_index)         =min([min(min(output1)),min(min(output2))]);
         deltaT.top(evaluate_index)   =max(max(output1))-min(min(output1));
         deltaT.bottom(evaluate_index)=max(max(output2))-min(min(output2));
         deltaT.max(evaluate_index)   =max(deltaT.top(evaluate_index),deltaT.bottom(evaluate_index));
         load cooling_energy.dat;
         coolingpower(evaluate_index)=cooling_energy;
         pressureIn(evaluate_index)=Pin(1);
         %% choose the layer whose deltaT is higher to fill
         if fill_choice~=0
             if deltaT.top(evaluate_index)<deltaT.bottom(evaluate_index)
                 fill_choice=1;
             else 
                 fill_choice=2;
             end
         end
         %% accept the new channel?
         % exp(-1)=0.01, 200*--->fill one bolck ,deltaT rise 0.025K , the accept probability is 0.01 
         %               400*--->fill one bolck ,deltaT rise 0.0125K, the accept probability is 0.01 
         
        if(evaluate_index>1)
            deltaTDrop=deltaT.max(evaluate_index)-deltaT.max(evaluate_index-1);
             if(   ( deltaTDrop<=0||...
                     rand<exp(-deltaTDrop/Tnow))...
                     &&(cooling_energy>0.0001)&&(Tmax(evaluate_index)<TmaxConst))
                 
                 channel=new_channel;
                 acceptArray(evaluate_index)=1; 
                 acceptsNum=acceptsNum+1;
                 % accept -->take down the channel
                 if strcmp(test_case,'case5/test_case_05.stk')
%                      if(max(deltaT.top(evaluate_index),deltaT.bottom(evaluate_index))<best_cost&&Tmax(evaluate_index)<338)
                     if(max(deltaT.top(evaluate_index),deltaT.bottom(evaluate_index))<best_cost&&Tmax(evaluate_index)<TmaxConst)%338.1
                         best_pressure=Pin(1);
                         best_cost=max(deltaT.top(evaluate_index),deltaT.bottom(evaluate_index));
                         best_channel=channel;
                         best_step=step;
                         best_evaluate_index=evaluate_index;
%                          dlmwrite('best_channel1.dat',best_channel,'\t');
                     end 
                 else
                     if(deltaT.max(evaluate_index)<best_cost&&Tmax(evaluate_index)<TmaxConst)%358
                         best_channel=channel;
                         best_step=step;
                         best_evaluate_index=evaluate_index;
                         %% change set_energy?
                         if (change_set_energy)
                             if (abs(deltaT.max(evaluate_index)-DTset)>Tthred)
                                 [Pin(1),deltaT.max(evaluate_index)]=SetDeltT(test_case,DTset,channel);
                                 load cooling_energy.dat;
                                 set_energy=cooling_energy;
                                 
                             end
                         end
                         best_pressure=Pin(1);
                         best_cost=deltaT.max(evaluate_index);

%                          dlmwrite('best_channel1.dat',best_channel,'\t');
                     end
                 end
                 index_axis(evaluate_index)=step;
                 fprintf('\n accept!!\n');
             else
                 rejectNum=rejectNum+1;
                 new_channel=channel;
                 index_axis(evaluate_index)=step;
                 Tmax(evaluate_index)=Tmax(evaluate_index-1);
                 Tmin(evaluate_index)=Tmin(evaluate_index-1);
                 deltaT.top(evaluate_index)=deltaT.top(evaluate_index-1);
                 deltaT.bottom(evaluate_index)=deltaT.bottom(evaluate_index-1);
                 deltaT.max(evaluate_index)=deltaT.max(evaluate_index-1);
                 coolingpower(evaluate_index)=coolingpower(evaluate_index-1);
                 pressureIn(evaluate_index)=pressureIn(evaluate_index-1);
                 Pin(1)=pressureIn(evaluate_index-1);
                 acceptArray(evaluate_index)=0;
                 fprintf('\n reject!\n');
             end     
        end
        fprintf('the deltaT is： %f\n',deltaT.max(evaluate_index));
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
    
    fprintf('the step is %d,the fill location is (%d,%d)\n',step,remove_rows(step),remove_cols(step));
    
    step=step+1;
     end
end
%% optimize the best 
% [best_channel,final]=OptimizeLine(test_case,best_channel,set_energy,0.23,27,0.3,34,0.14,36,0.14,36);
% dlmwrite('best_channel1.dat',best_channel,'\t');
% dlmwrite('channel1.dat',best_channel,'\t');
% !./do_simulate.sh
% 
% load cooling_energy.dat
% load Pin.dat  
% 
% Pin(1)=Pin(1)*sqrt(set_energy/cooling_energy);
% dlmwrite('Pin.dat',Pin,'\t');
% fprintf('the cooling energy is 0.0065w\n')
% !./do_simulate.sh 
% 
% load output1.txt
% load output2.txt
% 
% output1=TurnoverMatrix(output1);
% output2=TurnoverMatrix(output2);
% deltaT.final=max(max(max(output2))-min(min(output2)),max(max(output1))-min(min(output1)));
%% output
toc;
acceptRatio=GetAcceptRatio(acceptArray,20);

if cartoon_flag==1
%     movie(cartoon,F,2,2,[0 0 0 0]);
%     set(gca,'Position',[0 0 810 800]);
    movie2avi(F,'LTchannel.avi','compression','None','fps',10);
%     movie(Tmap_top,T,2,2,[0 0 0 0]);
%     set(gca,'Position',[0 0 810 800]);
    movie2avi(T,'T_top.avi','compression','None','fps',10)
end
    figure(3);
    title('Tmax and Tmin');
    plot(index_axis,Tmax,'r',index_axis,Tmin,'g');
    figure(4);
    title('Tmax-Tmin');
    plot(index_axis,deltaT.top,'-r',index_axis,deltaT.bottom,'b',index_axis,deltaT.max,'g');

    figure(6);
    title('cooling power');
    plot(index_axis,coolingpower);
    figure(7);
    title('channel');
            
    draw_channel=best_channel;
    for i=1:101
        for j=1:101
            switch channel(i,j)
                case 2
                    draw_channel(i,j)=0;
                case 1
                    draw_channel(i,j)=5;
                case 3
                    draw_channel(i,j)=10;
                otherwise
                    draw_channel(i,j)=15;
            end
        end
    end
    contourf(draw_channel);
     channel_name=['results_version3/',test_case,'_',num2str(best_cost),'k_',num2str(best_pressure),'pa_',num2str(set_energy),'w_',int2str(initial_index),'.dat'];
     dlmwrite('channel1.dat',best_channel,'\t');
     dlmwrite(channel_name  ,best_channel,'\t');
         !./do_simulate.sh
         
        %% update the output            
            load output1.txt
            load output2.txt
         
        %% modefy the Pin to have the same cooling energy

            load cooling_energy.dat
            load Pin.dat

        %% adjust the power to set energy
%         if fix_cooling_energy==1
%             if cooling_energy<0.00001
%                 cooling_energy=coolingpower(evaluate_index-1);
%             end
%             Pin(1)=Pin(1)*sqrt(set_energy/cooling_energy);
%             dlmwrite('Pin.dat',Pin,'\t');
%             fprintf('the cooling energy is 0.0065w\n')
%             !./do_simulate.sh 
%             
%             load output1.txt
%             load output2.txt         
%         end        
        output1=TurnoverMatrix(output1);
        output2=TurnoverMatrix(output2);
figure(5);
    title('Tmap--top');
    [C,h]=contourf(output1,50);
    set(h,'ShowText','on','TextStep',get(h,'LevelStep')*5);          

    figure(8)
    title('pressure in')
    plot(index_axis,pressureIn);
    figure(10);
    title('Tmap--top');
    [C,h]=contourf(output2,50);
    set(h,'ShowText','on','TextStep',get(h,'LevelStep')*5);
    
    figure(9)
    title('T in annealing ')
    plot(index_axis,Tindex);    
    
    figure(11)
    title('T in annealing ')
    plot(index_axis,TacceptRatioOfBad);    