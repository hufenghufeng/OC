clear all
close all
format long

size=101;

plus=zeros(size);
%% initial input channel
initial_index=231;
load mode.dat
load step_num.dat
%  mode=1;
%  step_num=400
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

set_energy=0.001;         % the cooling energy you set (w)
DTset=10;
Tthred=0.5;
fix_cooling_energy=1;   % the simulation option
index_axis(1)=1;
%% initial output Tmap
test_case='case3/test_case_03.stk';
fid=fopen('case_name','w');
fprintf(fid,test_case);
fclose(fid);
 %[channel,final]=Best_Line(test_case);
new_channel=channel;
dlmwrite('channel1.dat',channel,'\t');

!./do_simulate.sh
if fix_cooling_energy==1
    load cooling_energy.dat
    load Pin.dat
    Pin(1)=Pin(1)*sqrt(set_energy/cooling_energy);
    dlmwrite('Pin.dat',Pin,'\t');
    fprintf('the cooling energy is 0.0065w\n')
    !./do_simulate.sh  
end
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

topTmap=output1-300;
bottomTmap=output2-300;

step          =1;
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

evaluate_index=1;
%% configure
cartoon_flag      =0;% show cartoon       ?
fix_cooling_energy=1;% fix cooling energy ? else fix pressure
fill_choice       =1;% 0:no preference               1: fill bottom channel layer 2: fill top channel layer
change_set_energy =0;% 0:keep set_enenrgy constant   1: keep the deltaT in a small domain while change set_energy
%% the total filling block number and after how many blocks has been filled you evaluate them and decide whether fill them or not
evaluate_number=400;
% step_num       =400;
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
while  (step<step_num)
    %% reduce the evaluate_number as the step rise
    if mode ==3
        if step>200
            evaluate_number=2;
        else
            evaluate_number=floor(log(103-step/2));
        end
    else
        evaluate_number=1;
    end
    
    %% find the Tmin(only one) and the location of Tmin
    balanceTop   =topTmap   +plus;
    balanceBottom=bottomTmap+plus;
    [topR,topC]      =FindNTmin(balanceTop   ,5);
    [bottomR,bottomC]=FindNTmin(balanceBottom,5); 
    
    
    for i=1:101*101
        if plus(i)~=0
            plus(i)=plus(i)-1;
        end
    end
    
    a=rand();
   if fill_choice==1    
        if a<0.7
            fillRow=topR(1);
            fillCol=topC(1);
        else if 0.7<a&&a<0.85
            fillRow=topR(2);
            fillCol=topC(2);
            else if 0.85<a && a<0.95
             fillRow=topR(3);
             fillCol=topC(3); 
                else 
                 fillRow=topR(4);
                 fillCol=topC(4); 
                end
            end
        end
   else
        if a<0.7
            fillRow=bottomR(1);
            fillCol=bottomC(1);
        else if 0.7<a&&a<0.85
            fillRow=bottomR(2);
            fillCol=bottomC(2);
            else if 0.85<a && a<0.95
             fillRow=bottomR(3);
             fillCol=bottomC(3); 
                else 
                 fillRow=bottomR(4);
                 fillCol=bottomC(4); 
                end
            end
        end    
   end
%     if fill_choice==1
%         fillRow=topR(1);
%         fillCol=topC(1);
%     else
%         fillRow=bottomR(1);
%         fillCol=bottomC(1);
%     end
        
%%  fill the channel according to the Tmin   
        new_channel=fillChannel(new_channel,fillRow,fillCol);

%% remove the dead block in channel                 
     if(step>200&&mod(step,50)==1)
         load pressure.dat;
         new_channel=RemoveDeadBlock(pressure,new_channel);
     end        
   
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
        if fix_cooling_energy==1
            if cooling_energy<0.00001
                cooling_energy=coolingpower(evaluate_index-1);
            end
            Pin(1)=Pin(1)*sqrt(set_energy/cooling_energy);
            dlmwrite('Pin.dat',Pin,'\t');
            fprintf('the cooling energy is 0.0065w\n')
            !./do_simulate.sh 
            
            load output1.txt
            load output2.txt         
        end       
        output1=TurnoverMatrix(output1);
        output2=TurnoverMatrix(output2);
        
        tempBalance1=output1-300;
        tempBalance2=output2-300;

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
             if(((deltaT.max(evaluate_index)-deltaT.max(evaluate_index-1))<=0||rand<exp(-50*(deltaT.max(evaluate_index)-deltaT.max(evaluate_index-1))/evaluate_number))&&(cooling_energy>0.0001)&&(Tmax(evaluate_index)<1000))
                 channel=new_channel;
                 acceptArray(evaluate_index)=1; 
                 topTmap=tempBalance1;
                 bottomTmap=tempBalance2;
                 plus(fillRow,fillCol)=plus(fillRow,fillCol)+1000;
                 % accept -->take down the channel
                 if strcmp(test_case,'case5/test_case_05.stk')
%                      if(max(deltaT.top(evaluate_index),deltaT.bottom(evaluate_index))<best_cost&&Tmax(evaluate_index)<338)
                     if(max(deltaT.top(evaluate_index),deltaT.bottom(evaluate_index))<best_cost&&Tmax(evaluate_index)<388.1)%338.1
                         best_pressure=Pin(1);
                         best_cost=max(deltaT.top(evaluate_index),deltaT.bottom(evaluate_index));
                         best_channel=channel;
                         best_step=step;
                         best_evaluate_index=evaluate_index;
%                          dlmwrite('best_channel1.dat',best_channel,'\t');
                     end 
                 else
                     if(deltaT.max(evaluate_index)<best_cost&&Tmax(evaluate_index)<358)%358
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
                 % plus
                 plus(fillRow,fillCol)=plus(fillRow,fillCol)+300;
                 %
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
    
    fprintf('the step is %d,the fill location is (%d,%d)\n',step,fillRow,fillCol);
    
    step=step+1;
    
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
acceptRatio=GetAcceptRatio(acceptArray,5);

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
        if fix_cooling_energy==1
            if cooling_energy<0.00001
                cooling_energy=coolingpower(evaluate_index-1);
            end
            Pin(1)=Pin(1)*sqrt(set_energy/cooling_energy);
            dlmwrite('Pin.dat',Pin,'\t');
            fprintf('the cooling energy is 0.0065w\n')
            !./do_simulate.sh 
            
            load output1.txt
            load output2.txt         
        end        
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