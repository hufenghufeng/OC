function [best] = Best_Hook_single(test_case,channel,set_energy,part_num,theta,linelength)
%UNTITLED Summary of this function goes here
%   ____________
%  | T1  |  T3  |
%  |_____|______|
%  | T2  |  T4  |
%  |_____|______|
%
%   firstly, get the best single line of the four corners respectively
index=1;

% set_energy=0.0044;

best.cost=10000;
fid=fopen('case_name','w');
fprintf(fid,test_case);
fclose(fid);


switch part_num
    % get the filled channel without line
    case 1
    channel=RemoveLine(channel,100,2  ,100-linelength*cos(theta*pi),2  +linelength*sin(theta*pi)); 
    case 2
    channel=RemoveLine(channel,2  ,2  ,2  +linelength*cos(theta*pi),2  +linelength*sin(theta*pi));
    case 3
%     channel=RemoveLine(channel,100,100,100-linelength*cos(theta*pi),100-linelength*sin(theta*pi));
            channel=RemoveLine(channel,100,100,100-28*cos(0.32*pi),100-28*sin(0.32*pi));
            channel=RemoveLine(channel,100-round(28*cos(0.32*pi)),100-round(28*sin(0.32*pi))-1,100-round(28*cos(0.32*pi))+8 ,100-round(28*sin(0.32*pi))-1);             
    case 4
    channel=RemoveLine(channel,2  ,100,2  +linelength*cos(theta*pi),100-linelength*sin(theta*pi));
    otherwise 
        warning('unknown part number');
end

filled_channel=channel;
figure(1)
DrawChannel(channel);
for LineLength=24:2:42
    for theta=0.26:0.02:0.38
        for HookLength=2:2:6
            
            switch part_num
                % draw line according part number
                case 1
                   channel=DrawHook(filled_channel,1,theta,LineLength,HookLength,1); 
                case 2
                   channel=DrawHook(filled_channel,2,theta,LineLength,HookLength,0);
                case 3
                   channel=DrawHook(filled_channel,3,theta,LineLength,HookLength,1);
                case 4
                   channel=DrawHook(filled_channel,4,theta,LineLength,HookLength,0);
                otherwise 
                    warning('unknown part number');
            end
            

            figure(1)
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


            output1=TurnoverMatrix(output1);
            output2=TurnoverMatrix(output2); 

    %         figure(3)
    %          [C,h]=contourf(output2,50);
    %          set(h,'ShowText','on','TextStep',get(h,'LevelStep')*5);

            Tmax.top(index)   =max(max(output1));
            Tmax.bottom(index)=max(max(output2));
            Tmax.max(index)   =max(Tmax.top(index),Tmax.bottom(index));

            deltaT(index)     =max(max(max(output2))-min(min(output2)),max(max(output1))-min(min(output1)));
            if deltaT(index)<best.cost
                best.cost      =deltaT(index);
                best.theta     =theta;
                best.linelength=LineLength;
                best.hooklength=HookLength;
                best.pressure  =Pin(1);
                best_channel   =channel;
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


fprintf('\nthe best of the four corner respectively!');
fprintf('\nthe best of 4 is :%f,theta:%f,length:%d,hook length:%d\n',best.cost,best.theta,best.linelength,best.hooklength);
channel_name=['results_version3/',test_case,'_o_',num2str(best.cost),'k_',num2str(best.pressure),'pa_',num2str(set_energy),'w_','.dat'];
dlmwrite(channel_name  ,best_channel,'\t');
dlmwrite('channel1.dat',best_channel,'\t');
DrawChannel(best_channel);

         !./do_simulate.sh
         
        %% update the output            
            load output1.txt
            load output2.txt
         
        %% modefy the Pin to have the same cooling energy

            load cooling_energy.dat
            load Pin.dat

        %% adjust the power to set energy

            Pin(1)=Pin(1)*sqrt(set_energy/cooling_energy);
            dlmwrite('Pin.dat',Pin,'\t');
            fprintf('the cooling energy is 0.0065w\n')
            !./do_simulate.sh 
            
            load output1.txt
            load output2.txt         
     
            output1=TurnoverMatrix(output1);
            output2=TurnoverMatrix(output2);
    figure(4);
    title('Tmap--top');
    [C,h]=contourf(output1,50);
    set(h,'ShowText','on','TextStep',get(h,'LevelStep')*5);
    
    figure(5);
    title('Tmap--top');
    [C,h]=contourf(output2,50);
    set(h,'ShowText','on','TextStep',get(h,'LevelStep')*5);

figure(6)
plot(deltaT);

figure(8)
plot(Tmax.max);

end


