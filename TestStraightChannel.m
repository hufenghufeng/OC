format long 
clear all
%% choose test case
test_case='case1/test_case_01.stk';
fid=fopen('case_name','w');
fprintf(fid,test_case);
fclose(fid);

load Pin.dat
Pin(1)=15000;
Pin(2)=200;
dlmwrite('Pin.dat',Pin,'\t');
fprintf('the cooling energy is 0.0065w\n')

Max_deltaT=15;
Max_T     =358.15;

%% initial straight channel
channel=initialChannel(5);
      5:    % 2  3  2
            % 2     2
            % 2  3  2

dlmwrite('channel1.dat',channel,'\t');
!./do_simulate.sh

%% get results
load output1.txt
load output2.txt

Tmax(evaluate_index)         =max([max(max(output1)),max(max(output2))]);
Tmin(evaluate_index)         =min([min(min(output1)),min(min(output2))]);

deltaT.top(evaluate_index)   =max(max(output1))-min(min(output1));
deltaT.bottom(evaluate_index)=max(max(output2))-min(min(output2));
deltaT.max(evaluate_index)   =max(deltaT.top(evaluate_index),deltaT.bottom(evaluate_index));

