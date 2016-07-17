function [ best ] = Best_Line_pair( test_case,channel,set_energy,theta1,linelength1,theta2,linelength2,theta3,linelength3,theta4,linelength4  )
%find the best pair line of left and right 
% used for case 1
% you should find the best line of the corner before carry on this step 
%   ____________
%  | T1  |  T3  |
%  |_____|______|
%  | T2  |  T4  |
%  |_____|______|
fid=fopen('case_name','w');
fprintf(fid,test_case);
fclose(fid);

% get the filled channel without line 
channel=RemoveLine(channel,100,2  ,100-linelength1*cos(theta1*pi),2  +linelength1*sin(theta1*pi));     
channel=RemoveLine(channel,2  ,2  ,2  +linelength2*cos(theta2*pi),2  +linelength2*sin(theta2*pi));
channel=RemoveLine(channel,100,100,100-linelength3*cos(theta3*pi),100-linelength3*sin(theta3*pi));   
channel=RemoveLine(channel,2  ,100,2  +linelength4*cos(theta4*pi),100-linelength4*sin(theta4*pi));
filled_channel=channel;
        figure(1)
        DrawChannel(channel);

index=1;

%% get the best two line of the upper and lower part 
%% the lower part
%   ____________
%  | T2  |  T4  |
%  |_____|______|
%  | T2  |  T4  |
%  |_____|______|
[T1,T2,T3,T4,DeltaT]=DrawFourLine(filled_channel,theta2,linelength2,theta4,linelength4,...
                                                 theta2,linelength2,theta4,linelength4,set_energy);
cost_lower_max=10000;
cost_right_T4 =T4;
cost_left_T2 =T2;

best.theta2      =theta2;
best.linelength2 =linelength2;
best.theta4     =theta4     ;
best.linelength4=linelength4;

if T4<T2    
    for Line_length_left =linelength4-1   :1   :linelength4+5
        for theta_left   =theta4     -0.03:0.01:theta4     +0.03
            [T1,T2,T3,T4,DeltaT]=DrawFourLine(filled_channel,best.theta2,best.linelength2,theta_left,Line_length_left,...
                                                             best.theta2,best.linelength2,theta_left,Line_length_left,set_energy);
            if(max(T4,T2)<cost_lower_max)
                cost_lower_max       =max(T4,T2);
                cost_right_T4        =T4;
                cost_left_T2         =T2;
                best.theta4     =theta_left;
                best.linelength4=Line_length_left;
            end
        end
    end

else if T4>T2
        for Line_length_left =best.linelength2-1   :1   :best.linelength2+5
            for theta_left   =best.theta2     -0.03:0.01:best.theta2     +0.03
                [T1,T2,T3,T4,DeltaT]=DrawFourLine(filled_channel,best.theta2,best.linelength2,theta_left,Line_length_left,...
                                                                 best.theta2,best.linelength2,theta_left,Line_length_left,set_energy);
                if(max(T4,T2)<cost_lower_max)
                    cost_lower_max       =max(T4,T2); 
                    cost_right_T4        =T4;
                    cost_left_T2         =T2;                    
                    best.theta2     =theta_left;
                    best.linelength2=Line_length_left;
                end
            end
        end
    end
end
fprintf('\nthe best two line of the lower!,the Tmax of T2,T4 is %f\n',cost_lower_max);
fprintf('\nthe best left  of 2 is :%f,theta:%f,length:%d\n',cost_left_T2 ,best.theta2 ,best.linelength2);
fprintf('\nthe best right of 4 is :%f,theta:%f,length:%d\n',cost_right_T4,best.theta4 ,best.linelength4);
end

function [Tmax1,Tmax2,Tmax3,Tmax4,DeltaT] = DrawFourLine(channel,theta1,line_length1,theta2,line_length2,theta3,line_length3, theta4,line_length4,set_energy)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

    
    channel=DrawLine(channel,100,2,100-line_length1*cos(theta1*pi),2+line_length1*sin(theta1*pi));     
    channel=DrawLine(channel,2,2,2+line_length2*cos(theta2*pi),2+line_length2*sin(theta2*pi));
    channel=DrawLine(channel,100,100,100-line_length3*cos(theta3*pi),100-line_length3*sin(theta3*pi));   
    channel=DrawLine(channel,2,100,2+line_length4*cos(theta4*pi),100-line_length4*sin(theta4*pi));

    
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
    
 
    Tmax1 =max(max(max(output1(51:101,1 :50 ))),max(max(output2(51:101, 1:50 ))));
    Tmax2 =max(max(max(output1(1 :50 ,1 :50 ))),max(max(output2(1 :50 , 1:50 ))));
    Tmax3 =max(max(max(output1(51:101,51:101))),max(max(output2(51:101,51:101))));
    Tmax4 =max(max(max(output1(1 :50 ,51:101))),max(max(output2( 1:50 ,51:101))));
    DeltaT=max(max(max(output1))-min(min(output1)),max(max(output2))-min(min(output2)));

        figure(11)
        DrawChannel(channel);

%             
%         figure(2)
%         [C,h]=contourf(output2,50);
%         set(h,'ShowText','on','TextStep',get(h,'LevelStep')*5);
%             end
    fprintf('\ntmax1=:%f\n',Tmax1);
    fprintf('\ntmax2=:%f\n',Tmax2);
    fprintf('\ntmax3=:%f\n',Tmax3);
    fprintf('\ntmax4=:%f\n',Tmax4);
    fprintf('\ndeltaT=:%f\n',DeltaT);
end