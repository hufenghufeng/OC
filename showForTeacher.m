clear all
format long
evaluate_index=1;
for ce=0.0005:0.0001:0.002
    dlmwrite('cooling_energy.dat',ce,'\t');
    !./do_simulate.sh
    
    load output1.txt
    load output2.txt
    output1=TurnoverMatrix(output1);
    output2=TurnoverMatrix(output2);
    output1=output1-273.15;
    output2=output2-273.15;

    Tmax1(evaluate_index)         =max([max(max(output1)),max(max(output2))]);
    Tmin1(evaluate_index)         =min([min(min(output1)),min(min(output2))]);

    deltaT_top1(evaluate_index)   =max(max(output1))-min(min(output1));
    deltaT_bottom1(evaluate_index)=max(max(output2))-min(min(output2));
    deltaT_max1(evaluate_index)   =max(deltaT_top1(evaluate_index),deltaT_bottom1(evaluate_index));
    evaluate_index=evaluate_index+1;
end


! rm channel1.dat
! cp channel2.dat channel1.dat
evaluate_index=1;
for ce=0.0005:0.0001:0.002
    dlmwrite('cooling_energy.dat',ce,'\t');
    !./do_simulate.sh
    
    load output1.txt
    load output2.txt
    output1=TurnoverMatrix(output1);
    output2=TurnoverMatrix(output2);
    output1=output1-273.15;
    output2=output2-273.15;

    Tmax2(evaluate_index)         =max([max(max(output1)),max(max(output2))]);
    Tmin2(evaluate_index)         =min([min(min(output1)),min(min(output2))]);

    deltaT_top2(evaluate_index)   =max(max(output1))-min(min(output1));
    deltaT_bottom2(evaluate_index)=max(max(output2))-min(min(output2));
    deltaT_max2(evaluate_index)   =max(deltaT_top2(evaluate_index),deltaT_bottom2(evaluate_index));
    evaluate_index=evaluate_index+1;
end


! rm channel1.dat
! cp channel3.dat channel1.dat
evaluate_index=1;
for ce=0.0005:0.0001:0.002
    dlmwrite('cooling_energy.dat',ce,'\t');
    !./do_simulate.sh
    
    load output1.txt
    load output2.txt
    output1=TurnoverMatrix(output1);
    output2=TurnoverMatrix(output2);
    output1=output1-273.15;
    output2=output2-273.15;

    Tmax3(evaluate_index)         =max([max(max(output1)),max(max(output2))]);
    Tmin3(evaluate_index)         =min([min(min(output1)),min(min(output2))]);

    deltaT_top3(evaluate_index)   =max(max(output1))-min(min(output1));
    deltaT_bottom3(evaluate_index)=max(max(output2))-min(min(output2));
    deltaT_max3(evaluate_index)   =max(deltaT_top3(evaluate_index),deltaT_bottom3(evaluate_index));
    evaluate_index=evaluate_index+1;
end

figure(1)
title('Tmax vs cooling energy')
plot(0.0005:0.0001:0.002,Tmax1,'-r',0.0005:0.0001:0.002,Tmax2,'g',0.0005:0.0001:0.002,Tmax3,'b');

figure(2)
title('dt vs cooling energy')
plot(0.0005:0.0001:0.002,deltaT_max1,'-r',0.0005:0.0001:0.002,deltaT_max2,'g',0.0005:0.0001:0.002,deltaT_max3,'b');
