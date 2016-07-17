format long 
clear all

!./do_simulate.sh

load channel1.dat
load output1.txt
load output2.txt

      
output1=TurnoverMatrix(output1);
output2=TurnoverMatrix(output2);

figure(1);
title('Tmap--top');
[C,h]=contourf(output1,50);
set(h,'ShowText','on','TextStep',get(h,'LevelStep')*5);  

figure(2);
title('Tmap--bottom');
[C,h]=contourf(output2,50);
set(h,'ShowText','on','TextStep',get(h,'LevelStep')*5);  


figure(3)
title('channel');
DrawChannel(channel1);

