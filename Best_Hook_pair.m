function [best] = Best_Hook_pair(test_case,channel,set_energy,part_num,theta2,linelength2,theta4,linelength4)
%this is designed for case 1
%   ____________
%  | T1  |  T3  |
%  |_____|______|
%  | T2  |  T4  |
%  |_____|______|
%
% 
% get the lowest Tmax of the bottom part (T2 and T4)
% 
index=1;

% set_energy=0.0044;

best.cost2=10000;
best.cost4=10000;
fid=fopen('case_name','w');
fprintf(fid,test_case);
fclose(fid);

channel=RemoveHook(channel,2,theta2,linelength2,10,1);
channel=RemoveHook(channel,4,theta4,linelength4,10,1);
            channel=RemoveLine(channel,2  +round(32*cos(0.28*pi)),100-round(32*sin(0.28*pi))  ,2  +round(32*cos(0.28*pi))-14,100-round(32*sin(0.28*pi))  ); 
            channel=RemoveLine(channel,2  +round(27*cos(0.25*pi)),2  +round(27*sin(0.25*pi))+2,2  +round(27*cos(0.25*pi))-14,2  +round(27*sin(0.25*pi))+2);
filled_channel=channel;
figure(1)
DrawChannel(channel);


%% draw two same hook of the bottom

for LineLength=28:1:35
    for theta=0.26:0.005:0.31
        for HookLength=0:2:8
            
            channel=DrawHook(filled_channel,2,theta,LineLength,HookLength,1);
            channel=DrawHook(channel       ,4,theta,LineLength,HookLength,1);        
%             figure(1)
%             DrawChannel(channel);

            dlmwrite('channel1.dat',channel,'\t');
            !./do_simulate.sh

            load cooling_energy.dat
            load Pin.dat  

            Pin(1)=Pin(1)*sqrt(set_energy/cooling_energy);
            dlmwrite('Pin.dat',Pin,'\t');
            fprintf('the cooling energy is 0.0065w\n')
            !./do_simulate.sh 

            load output1.txt
            load output2.txt

            output1=TurnoverMatrix(output1);
            output2=TurnoverMatrix(output2); 

            Tmax.top(index)   =max(max(output1));
            Tmax.bottom(index)=max(max(output2));
            Tmax.max(index)   =max(Tmax.top(index),Tmax.bottom(index));

            Tmax1(index)=max(max(max(output1(51:101,1 :50 ))),max(max(output2(51:101, 1:50 ))));
            Tmax2(index)=max(max(max(output1(1 :50 ,1 :50 ))),max(max(output2(1 :50 , 1:50 ))));
            Tmax3(index)=max(max(max(output1(51:101,51:101))),max(max(output2(51:101,51:101))));
            Tmax4(index)=max(max(max(output1(1 :50 ,51:101))),max(max(output2( 1:50 ,51:101)))); 
            
            if Tmax2(index)<best.cost2
                best.cost2= Tmax2(index);
                best.theta2=theta;
                best.linelength2=LineLength;
                best.hooklength2=HookLength;
            end

            if Tmax4(index)<best.cost4
                best.cost4= Tmax4(index);
                best.theta4=theta;
                best.linelength4=LineLength;
                best.hooklength4=HookLength;                
            end
            
            if(Tmax.top(index)>Tmax.bottom(index))
                [row_top,col_top]=find(output1==Tmax.max(index));
                fprintf('the Tmax is :%f\n',Tmax.max(index));
                fprintf('the top row is :\n');
                disp(row_top);
                fprintf('the top col is :\n'); 
                disp(col_top);
                fprintf('\n');
            else 
                [row_bottom,col_bottom]=find(output2==Tmax.max(index));
                fprintf('the Tmax is :%f\n',Tmax.max(index));
                fprintf('the bottom row is :\n');
                disp(row_bottom);
                fprintf('the bottom col is :\n'); 
                disp(col_bottom);
                fprintf('\n');
            end
            fprintf('the index is: %d\n',index);
            index=index+1;                
            
        end
    end
end

channel=DrawHook(filled_channel,2,best.theta2,best.linelength2,best.hooklength2,1);
channel=DrawHook(channel       ,4,best.theta4,best.linelength4,best.hooklength4,1); 


dlmwrite('channel1.dat',channel,'\t');
DrawChannel(channel);

    dlmwrite('channel1.dat',channel,'\t');
    !./do_simulate.sh

    load cooling_energy.dat
    load Pin.dat  

    Pin(1)=Pin(1)*sqrt(set_energy/cooling_energy);
    dlmwrite('Pin.dat',Pin,'\t');
    fprintf('the cooling energy is 0.0065w\n')
    !./do_simulate.sh 

 
    load output1.txt
    load output2.txt
    
    channel_name=['results_version3/',test_case,'_o_',num2str(max(max(max(output1))-min(min(output1)),max(max(output2))-min(min(output2)))),'k_',num2str(Pin(1)),'pa_',num2str(set_energy),'w_','.dat'];
    dlmwrite(channel_name  ,channel,'\t');  

    output1=TurnoverMatrix(output1);
    output2=TurnoverMatrix(output2);
    
    figure(4);
    title('Tmap--top');
    [C,h]=contourf(output1,50);
    set(h,'ShowText','on','TextStep',get(h,'LevelStep')*5);
    
    figure(5);
    title('Tmap--top');
    [C,h]=contourf(output2,50);
    set(h,'ShowText','on','TextStep',get(h,'LevelStep'));
    
end

