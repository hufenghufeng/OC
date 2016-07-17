format long 
clear all
%% choose test case
test_case='case1/test_case_01.stk';
fid=fopen('case_name','w');
fprintf(fid,test_case);
fclose(fid);


% channel=GenerateChannel(2);
% dlmwrite('channel1.dat',channel,'\t');
% !./do_simulate.sh
load Pin.dat
%set_energy=0.5;
 %           load cooling_energy.dat
 %           Pin(1)=Pin(1)*sqrt(set_energy/cooling_energy);
            
Pin(1)=11902.69;
Pin(2)=400;
dlmwrite('Pin.dat',Pin,'\t');

%% initial straight channel
%channel=initialChannel(6);
channel=GenerateChannel(34);
      %5:   % 2  3  2
            % 2     2
            % 2  3  2

dlmwrite('channel1.dat',channel,'\t');
!./do_simulate.sh
load output1.txt
load output2.txt

% output1=TurnoverMatrix(output1);
% output2=TurnoverMatrix(output2);
output1=output1-273.15;
output2=output2-273.15;
evaluate_index=1;

Tmax(evaluate_index)         =max([max(max(output1)),max(max(output2))]);
Tmin(evaluate_index)         =min([min(min(output1)),min(min(output2))]);

deltaT_top(evaluate_index)   =max(max(output1))-min(min(output1));
deltaT_bottom(evaluate_index)=max(max(output2))-min(min(output2));
deltaT_max(evaluate_index)   =max(deltaT_top(evaluate_index),deltaT_bottom(evaluate_index));

    figure(10);
    title('Tmap--bottom');
    [C,h]=contourf(output2,50);
    set(h,'LineStyle','none');
    figure(11);
    title('Tmap--top')
    [C,h]=contourf(output1,50);
    set(h,'LineStyle','none');    
    load channel1.dat;
    
channel1=TurnoverMatrix(channel1);
figure(12)
DrawChannel(channel1);