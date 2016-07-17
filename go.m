!./do_simulate.sh
load output1.txt
load output2.txt

output1=TurnoverMatrix(output1);
output2=TurnoverMatrix(output2);
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
    channel2=channel1;
    for i=1:101
        for j=1:101
            switch channel2(i,j)
                case 2
                    channel2(i,j)=0;
                case 1
                    channel2(i,j)=5;
                case 3
                    channel2(i,j)=10;
                otherwise
                    channel2(i,j)=15;
            end
        end
    end
    figure(1)
    contourf(channel2);
    
    [r1,c1]=find(output1==min(min(output1)));
    minOutput1=min(min(output1));
    minOutput2=min(min(output2));
    
    [r2,c2]=find(output2==min(min(output2)));