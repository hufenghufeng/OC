function [best] = Best_Line_single(test_case,channel,set_energy,theta1,linelength1,theta2,linelength2,theta3,linelength3,theta4,linelength4)
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
best.cost1=10000;
best.cost2=10000;
best.cost3=10000;
best.cost4=10000;
fid=fopen('case_name','w');
fprintf(fid,test_case);
fclose(fid);

if strcmp(test_case,'case5/test_case_05.stk')
    channel=RemoveLine(channel,100,2  ,100-linelength1*cos(theta1*pi),2  +linelength1*sin(theta1*pi));    
else
    % get the filled channel without line 
    channel=RemoveLine(channel,100,2  ,100-linelength1*cos(theta1*pi),2  +linelength1*sin(theta1*pi));     
    channel=RemoveLine(channel,2  ,2  ,2  +linelength2*cos(theta2*pi),2  +linelength2*sin(theta2*pi));
    channel=RemoveLine(channel,100,100,100-linelength3*cos(theta3*pi),100-linelength3*sin(theta3*pi));   
    channel=RemoveLine(channel,2  ,100,2  +linelength4*cos(theta4*pi),100-linelength4*sin(theta4*pi));
end
filled_channel=channel;
        figure(1)
        DrawChannel(channel);
for LineLength=32:2:42
    for theta=0.14:0.02:0.3
        if strcmp(test_case,'case5/test_case_05.stk')
            channel=DrawLine(filled_channel,100,2  ,100-linelength1*cos(theta1*pi),2  +linelength1*sin(theta1*pi));
        else    
            channel=DrawFourSameLine(filled_channel,theta,LineLength);
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
        
        Tmax1(index)=max(max(output2(51:101,1:50)));
        Tmax2(index)=max(max(output2(1:50,1:50)));
        Tmax3(index)=max(max(output2(51:101,51:101)));
        Tmax4(index)=max(max(output2(1:50,51:101)));

        if Tmax1(index)<best.cost1
            best.cost1= Tmax1(index);
            best.theta1=theta;
            best.linelength1=LineLength;
        end
        if Tmax2(index)<best.cost2
            best.cost2= Tmax2(index);
            best.theta2=theta;
            best.linelength2=LineLength;
        end
        if Tmax3(index)<best.cost3
            best.cost3= Tmax3(index);
            best.theta3=theta;
            best.linelength3=LineLength;
        end
        if Tmax4(index)<best.cost4
            best.cost4= Tmax4(index);
            best.theta4=theta;
            best.linelength4=LineLength;
        end
        
        Tsample_100_45_bottom(index)     =output2(100,45);
        Tsample_92_1_bottom(index)    =output2(92,1);
        Tsample_5_100_bottom(index)   =output2(5,100);
        Tsample_97_100_bottom(index)  =output2(97,100);
        Tsample_52_84_bottom(index)   =output2(52,84);
        Tsample_52_44_bottom(index)   =output2(52,44);
       
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
    figure(2)
    [C,h]=contourf(output1,50);
    set(h,'ShowText','on','TextStep',get(h,'LevelStep')*5);
%     figure(3)
%     [C,h]=contourf(output2,50);
%     set(h,'ShowText','on','Textindex',get(h,'Levelindex')*5);
fprintf('\nthe best of the four corner respectively!');
fprintf('\nthe best of 1 is :%f,theta:%f,length:%d\n',best.cost1,best.theta1,best.linelength1);
fprintf('\nthe best of 2 is :%f,theta:%f,length:%d\n',best.cost2,best.theta2,best.linelength2);
fprintf('\nthe best of 3 is :%f,theta:%f,length:%d\n',best.cost3,best.theta3,best.linelength3);
fprintf('\nthe best of 4 is :%f,theta:%f,length:%d\n',best.cost4,best.theta4,best.linelength4);

figure(3)
plot(Tsample_100_45_bottom);
figure(4)
plot(Tsample_92_1_bottom);
figure(5)
plot(Tsample_5_100_bottom);
figure(6)
plot(Tsample_97_100_bottom);
figure(7)
plot(Tsample_52_84_bottom);
figure(8)
plot(Tmax.max);
figure(9)
plot(Tsample_52_44_bottom);
figure(10)
plot(1:index-1,Tmax1,'-b',1:index-1,Tmax2,'-or',1:index-1,Tmax3,'--g',1:index-1,Tmax4,'y')
end

function  channel = DrawFourSameLine(channel,k,line_length)
    channel=DrawLine(channel,2,2,2+line_length*cos(k*pi),2+line_length*sin(k*pi));
    channel=DrawLine(channel,100,2,100-line_length*cos(k*pi),2+line_length*sin(k*pi));    
    channel=DrawLine(channel,2,100,2+line_length*cos(k*pi),100-line_length*sin(k*pi));
    channel=DrawLine(channel,100,100,100-line_length*cos(k*pi),100-line_length*sin(k*pi));
    %% this is only for the part one in case 1
            IO_Length=28;
            IO_Wall  =6 ;
            for i=2:2:IO_Length
                channel(101,i)=2;
                channel(1,  i)=2;
                channel(101,102-i)=2;
                channel(1,  102-i)=2;
            end

            for i=2:2:IO_Wall
                channel(i    ,IO_Length+1)=0;
                channel(102-i,IO_Length+1)=0;
                channel(i    ,101-IO_Length)=0;
                channel(102-i,101-IO_Length)=0;                
            end
            
            
end

