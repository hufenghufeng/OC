function [ channel,best ] = OptimizeLine( test_case,channel,set_energy,theta1,linelength1,theta2,linelength2,theta3,linelength3,theta4,linelength4 )
%best the line in the final filled channel
%   ____________
%  | T1  |  T3  |
%  |_____|______|
%  | T2  |  T4  |
%  |_____|______|
fid=fopen('case_name','w');
fprintf(fid,test_case);
fclose(fid);
show_flag=1;
% get the filled channel without line 
channel=RemoveLine(channel,100,2  ,100-linelength1*cos(theta1*pi),2  +linelength1*sin(theta1*pi));     
channel=RemoveLine(channel,2  ,2  ,2  +linelength2*cos(theta2*pi),2  +linelength2*sin(theta2*pi));
channel=RemoveLine(channel,100,100,100-linelength3*cos(theta3*pi),100-linelength3*sin(theta3*pi));   
channel=RemoveLine(channel,2  ,100,2  +linelength4*cos(theta4*pi),100-linelength4*sin(theta4*pi));
filled_channel=channel;
%%   firstly, get the best single line of the four corners respectively
best.cost1=10000;
best.cost2=10000;
best.cost3=10000;
best.cost4=10000;
index=1;
tic;
%% show  catoon 
% Set a position to explicitly impose on your figure
pixelLowerLeftCorner = [100 100];
pixelWidth  = 512;
pixelHeight = 512;
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
    set(cartoon,'Position',[0,0,1024,1024]);
    set(gca,'nextplot','replacechildren');
for theta=0.1:0.02:0.3
    for LineLength=20:2:44
    

        channel=DrawFourSameLine(filled_channel,theta,LineLength);
        if show_flag==1
             DrawChannel(channel);
             drawnow
             F(index)=getframe(cartoon);  
        end
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

if show_flag==1
    movie(F,2,10);
    movie2avi(F,'draw_line.avi','compression','None','fps',10);
end
%% get the best two line of the left side and right side 
%% the left side
[T1,T2,T3,T4,DeltaT]=DrawFourLine(filled_channel,best.theta1,best.linelength1,best.theta2,best.linelength2,...
                                                 best.theta1,best.linelength1,best.theta2,best.linelength2,set_energy);
cost_left_max=10000;
cost_left_T1 =T1;
cost_left_T2 =T2;

best.left_theta2     =best.theta2;
best.left_linelength2=best.linelength2;
best.left_theta1     =best.theta1     ;
best.left_linelength1=best.linelength1;

if T1<T2    
    for Line_length_left =best.linelength1-1   :1   :best.linelength1+5
        for theta_left   =best.theta1     -0.03:0.01:best.theta1     +0.03
            [T1,T2,T3,T4,DeltaT]=DrawFourLine(filled_channel,theta_left,Line_length_left,best.theta2,best.linelength2,...
                                                             theta_left,Line_length_left,best.theta2,best.linelength2,set_energy);
            if(max(T1,T2)<cost_left_max)
                cost_left_max        =max(T1,T2);
                cost_left_T1         =T1;
                cost_left_T2         =T2;
                best.left_theta1     =theta_left;
                best.left_linelength1=Line_length_left;
            end
        end
    end

else if T1>T2
        for Line_length_left =best.linelength2-1   :1   :best.linelength2+5
            for theta_left   =best.theta2     -0.03:0.01:best.theta2     +0.03
                [T1,T2,T3,T4,DeltaT]=DrawFourLine(filled_channel,best.theta1,best.linelength1,theta_left,Line_length_left,...
                                                                 best.theta1,best.linelength1,theta_left,Line_length_left,set_energy);
                if(max(T1,T2)<cost_left_max)
                    cost_left_max        =max(T1,T2); 
                    cost_left_T1         =T1;
                    cost_left_T2         =T2;                    
                    best.left_theta2     =theta_left;
                    best.left_linelength2=Line_length_left;
                end
            end
        end
    end
end

%% the right side 
[T1,T2,T3,T4,DeltaT]=DrawFourLine(filled_channel,best.theta3,best.linelength3,best.theta4,best.linelength4,...
                                                 best.theta3,best.linelength3,best.theta4,best.linelength4,set_energy);
cost_right_max=1000;
cost_right_T3 =T3;
cost_right_T4 =T4;
best.right_theta4     =best.theta4;
best.right_linelength4=best.linelength4;
best.right_theta3     =best.theta3     ;
best.right_linelength3=best.linelength3;    
if T3<T4    
    for Line_length_right= best.linelength3-1   :1   :best.linelength3+5
        for theta_right  = best.theta3     -0.03:0.01:best.theta3     +0.03
            [T1,T2,T3,T4,DeltaT]=DrawFourLine(filled_channel,theta_right,Line_length_right,best.theta4,best.linelength4,...
                                                             theta_right,Line_length_right,best.theta4,best.linelength4,set_energy);
            if(max(T3,T4)<cost_right_max)
                cost_right_max        =max(T3,T4);
                cost_right_T3         =T3;
                cost_right_T4         =T4;
                best.right_theta3     =theta_right;
                best.right_linelength3=Line_length_right;
            end
        end
    end

else if T3>T4
        for Line_length_right=best.linelength4-1   :1   :best.linelength4+5
            for theta_right  =best.theta4     -0.03:0.01:best.theta4     +0.03
                [T1,T2,T3,T4,DeltaT]=DrawFourLine(filled_channel,best.theta3,best.linelength3,theta_right,Line_length_right,...
                                                                 best.theta3,best.linelength3,theta_right,Line_length_right,set_energy);
                if(max(T3,T4)<cost_right_max)
                    cost_right_max        =max(T3,T4);
                    cost_right_T3         =T3;
                    cost_right_T4         =T4;                    
                    best.right_theta4     =theta_right;
                    best.right_linelength4=Line_length_right;
                end
            end
        end
    end
end

%% get the final best four line as a whole
[T1,T2,T3,T4,DeltaT]=DrawFourLine(filled_channel,best.left_theta1 ,best.left_linelength1   ,best.left_theta2 ,best.left_linelength2 ,...
                                                 best.right_theta3,best.right_linelength3  ,best.right_theta4,best.right_linelength4,set_energy);
cost_final_max=10000;
delta_final   =10000;
Tmax_left     =max(T1,T2);
Tmax_right    =max(T3,T4);
final_index=1;
best.final_theta1     =best.left_theta1;
best.final_linelength1=best.left_linelength1;
best.final_theta2     =best.left_theta2;
best.final_linelength2=best.left_linelength2;
best.final_theta3     =best.right_theta3;
best.final_linelength3=best.right_linelength3;
best.final_theta4     =best.right_theta4;
best.final_linelength4=best.right_linelength4;

if Tmax_left<Tmax_right
    Line_length_left_top   =best.left_linelength1-1;
    Line_length_left_bottom=best.left_linelength2-1;
    theta_left_top         =best.left_theta1     -0.03;
    theta_left_bottom      =best.left_theta2     -0.03;
    while Line_length_left_top<=best.left_linelength1+4
        theta_left_top   =best.left_theta1 -0.03;
        theta_left_bottom=best.left_theta2 -0.03;
        while theta_left_top  <=best.left_theta1+0.03
            fprintf('\n the final index is: %d\n',final_index);
            [T1,T2,T3,T4,DeltaT]=DrawFourLine(filled_channel, theta_left_top,   Line_length_left_top,   theta_left_bottom,Line_length_left_bottom,    ...
                                                              best.right_theta3,best.right_linelength3, best.right_theta4,best.right_linelength4 ,set_energy);
            final_index=final_index+1;
                                                   
            if (max(T3,T4)<cost_final_max)&&((max(T1,T2)-max(T3,T4))<0.1)&&(DeltaT<=delta_final)
                delta_final   =DeltaT;
                cost_final_max=max(T3,T4);
                cost_final_T1 =T1;
                cost_final_T2 =T2;
                cost_final_T3 =T3;
                cost_final_T4 =T4;                
                best.final_theta1     =theta_left_top;
                best.final_linelength1=Line_length_left_top;
                best.final_theta2     =theta_left_bottom;
                best.final_linelength2=Line_length_left_bottom;
            end
            theta_left_top   =theta_left_top   +0.01;
            theta_left_bottom=theta_left_bottom+0.01;            
        end
        Line_length_left_top   =Line_length_left_top   +1;
        Line_length_left_bottom=Line_length_left_bottom+1;
    end

else if Tmax_left>Tmax_right

        Line_length_right_top   =best.right_linelength3-1;
        Line_length_right_bottom=best.right_linelength4-1;
        theta_right_top         =best.right_theta3     -0.03;
        theta_right_bottom      =best.right_theta4     -0.03;
        while Line_length_right_top<=best.right_linelength3+4
            theta_right_top         =best.right_theta3    -0.03;
            theta_right_bottom      =best.right_theta4    -0.03;
            while theta_right_top  <=best.right_theta3    +0.03
                fprintf('\n the final index is: %d\n',final_index);
                [T1,T2,T3,T4,DeltaT]=DrawFourLine(filled_channel, best.left_theta1,best.left_linelength1, best.left_theta2,  best.left_linelength2,    ...
                                                                  theta_right_top, Line_length_right_top, theta_right_bottom,Line_length_right_bottom, set_energy);
                final_index=final_index+1;                                       
                if (max(T1,T2)<cost_final_max)&&((max(T3,T4)-max(T1,T2))<0.1)&&(DeltaT<=delta_final)
                    delta_final   =DeltaT;                    
                    cost_final_max=max(T1,T2);
                    cost_final_T1 =T1;
                    cost_final_T2 =T2;
                    cost_final_T3 =T3;
                    cost_final_T4 =T4;
                    best.final_theta3     =theta_right_top;
                    best.final_linelength3=Line_length_right_top;
                    best.final_theta4     =theta_right_bottom;
                    best.final_linelength4=Line_length_right_bottom;
                end
                theta_right_top   =theta_right_top   +0.01;
                theta_right_bottom=theta_right_bottom+0.01;            
            end
            Line_length_right_top   =Line_length_right_top   +1;
            Line_length_right_bottom=Line_length_right_bottom+1;
        end
    end
end
toc;
fprintf('\nthe best of the four corner respectively!');
fprintf('\nthe best of 1 is :%f,theta:%f,length:%d\n',best.cost1,best.theta1,best.linelength1);
fprintf('\nthe best of 2 is :%f,theta:%f,length:%d\n',best.cost2,best.theta2,best.linelength2);
fprintf('\nthe best of 3 is :%f,theta:%f,length:%d\n',best.cost3,best.theta3,best.linelength3);
fprintf('\nthe best of 4 is :%f,theta:%f,length:%d\n',best.cost4,best.theta4,best.linelength4);

fprintf('\nthe best two line of the left!,the Tmax of T1,T2 is %f\n',cost_left_max);
fprintf('\nthe best left of 1 is :%f,theta:%f,length:%d\n',cost_left_T1,best.left_theta1,best.left_linelength1);
fprintf('\nthe best left of 2 is :%f,theta:%f,length:%d\n',cost_left_T2,best.left_theta2,best.left_linelength2);
fprintf('\nthe best two line of the right!,the Tmax of T3,T4 is %f\n',cost_right_max);
fprintf('\nthe best right of 3 is :%f,theta:%f,length:%d\n',cost_right_T3,best.right_theta3,best.right_linelength3);
fprintf('\nthe best right of 4 is :%f,theta:%f,length:%d\n',cost_right_T4,best.right_theta4,best.right_linelength4);

fprintf('\nthe best final four lines !!!, the Tmax is %f,the deltaT is %f\n',cost_final_max,delta_final);
fprintf('\nthe best left  of 1 is :%f,theta:%f,length:%d\n',cost_final_T1 ,best.final_theta1,best.final_linelength1);
fprintf('\nthe best left  of 2 is :%f,theta:%f,length:%d\n',cost_final_T2 ,best.final_theta2,best.final_linelength2);
fprintf('\nthe best right of 3 is :%f,theta:%f,length:%d\n',cost_final_T3 ,best.final_theta3,best.final_linelength3);
fprintf('\nthe best right of 4 is :%f,theta:%f,length:%d\n',cost_final_T4 ,best.final_theta4,best.final_linelength4);

channel=filled_channel;
channel=DrawLine(channel,100,2  ,100-best.final_linelength1*cos(best.final_theta1*pi),2  +best.final_linelength1*sin(best.final_theta1*pi));
channel=DrawLine(channel,2  ,2  ,2  +best.final_linelength2*cos(best.final_theta2*pi),2  +best.final_linelength2*sin(best.final_theta2*pi));
channel=DrawLine(channel,100,100,100-best.final_linelength3*cos(best.final_theta3*pi),100-best.final_linelength3*sin(best.final_theta3*pi));
channel=DrawLine(channel,2  ,100,2  +best.final_linelength4*cos(best.final_theta4*pi),100-best.final_linelength4*sin(best.final_theta4*pi));

end


function  channel = DrawFourSameLine(channel,k,line_length)
    channel=DrawLine(channel,2,2,2+line_length*cos(k*pi),2+line_length*sin(k*pi));
    channel=DrawLine(channel,100,2,100-line_length*cos(k*pi),2+line_length*sin(k*pi));    
    channel=DrawLine(channel,2,100,2+line_length*cos(k*pi),100-line_length*sin(k*pi));
    channel=DrawLine(channel,100,100,100-line_length*cos(k*pi),100-line_length*sin(k*pi));
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
%             if show_flag==1
%     figure(11)
%     DrawChannel(channel);
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