function [ channel,best ] = OptimizeLineWithWall( test_case,channel,set_energy,linelength1,theta1,linelength2,theta2,linelength3,theta3,linelength4,theta4 )
%optimize the four line with four seperating wall
%   remove the orignal line
%   find the line that minimize delta T in it's own area
%   ____________
%  | T1  |  T3  |
%  |_____|______|
%  | T2  |  T4  |
%  |_____|______|

fid=fopen('case_name','w');
fprintf(fid,test_case);
fclose(fid);
% choose whether to see the channel or Tmap
show_flag=1;
showTmap =0;
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
    
if showTmap==1   
    Tmap_top=figure('name','tempreture_top');
    set(Tmap_top,'Position',[0 0 1024 1024]);
end 

for theta=0.18:0.02:0.32
    for LineLength=20:2:40

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
%% show Tmap        
        if showTmap==1
             [C,h]=contourf(output2,50);
             set(h,'ShowText','on','TextStep',get(h,'LevelStep')*5);
             drawnow
             T(index)=getframe(Tmap_top);
        end
        
        Tmax.top(index)   =max(max(output1));
        Tmax.bottom(index)=max(max(output2));
        Tmax.max(index)   =max(Tmax.top(index),Tmax.bottom(index));
        
        Tmax1(index)=max(max(max(output1(51:101,1 :50 ))),max(max(output2(51:101, 1:50 ))));
        Tmax2(index)=max(max(max(output1(1 :50 ,1 :50 ))),max(max(output2(1 :50 , 1:50 ))));
        Tmax3(index)=max(max(max(output1(51:101,51:101))),max(max(output2(51:101,51:101))));
        Tmax4(index)=max(max(max(output1(1 :50 ,51:101))),max(max(output2( 1:50 ,51:101))));
        % sample some points for evaluate
        Tsample1(index)=max(max(output2(75:101,1:26)));
        Tsample2(index)=max(max(output2(75:101,27:51)));
        Tsample3(index)=max(max(output2(50:74,27:51  )));
        Tsample4(index)=max(max(output2(50:74,1:26  )));
        
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
channel=filled_channel;
channel=DrawLine(channel,100,2  ,100-best.linelength1*cos(best.theta1*pi),2  +best.linelength1*sin(best.theta1*pi));
channel=DrawLine(channel,2  ,2  ,2  +best.linelength2*cos(best.theta2*pi),2  +best.linelength2*sin(best.theta2*pi));
channel=DrawLine(channel,100,100,100-best.linelength3*cos(best.theta3*pi),100-best.linelength3*sin(best.theta3*pi));
channel=DrawLine(channel,2  ,100,2  +best.linelength4*cos(best.theta4*pi),100-best.linelength4*sin(best.theta4*pi));

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
        figure(14);
    plot([1:index-1],Tsample1,'r-',[1:index-1],Tsample2,'b-',[1:index-1],Tsample3,'m-',[1:index-1],Tsample4,'y-')
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