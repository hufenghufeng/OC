format long 
clear all

%% initial input channel
initial_index=6;
channel=initialChannel(initial_index);

line_length=25;
k     =0.4;

    channel=DrawLine(channel,2,2,2+line_length*cos(k*pi),2+line_length*sin(k*pi));
    channel=DrawLine(channel,100,2,100-line_length*cos(k*pi),2+line_length*sin(k*pi));    
    channel=DrawLine(channel,2,100,2+line_length*cos(k*pi),100-line_length*sin(k*pi));
    channel=DrawLine(channel,100,100,100-line_length*cos(k*pi),100-line_length*sin(k*pi));

dlmwrite('channel1.dat',channel,'\t');
!./do_simulate.sh

load output1.txt
load output2.txt               
output1=TurnoverMatrix(output1);
output2=TurnoverMatrix(output2);

figure(1);
title('Tmap--top');
[C,h]=contourf(output1,50);
set(h,'ShowText','on','TextStep',get(h,'LevelStep')*5);  

figure(2)
title('Tmap--top');
[C,h]=contourf(output2,50);
set(h,'ShowText','on','TextStep',get(h,'LevelStep')*5);  

figure(3)
DrawChannel(channel);

