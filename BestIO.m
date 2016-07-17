function [ channel ] = BestIO(test_case)
%   Get the best arragement of inlet and outlet
%   get the T without the influence of direction of fluid
%   try different initial channels
%   simulate for a time,then make them the same power 
%   simulate one more time,take down the Tmax and pressure

    Tavg=AverageT(test_case);
    [C,h]=contourf(Tavg,50);
    set(h,'ShowText','on','TextStep',get(h,'LevelStep')*5);
    
    
    for i=1:10
        channel=initialChannel(300+i);


        fid=fopen('case_name','w');
        fprintf(fid,test_case);
        fclose(fid);

        dlmwrite('channel1.dat',channel,'\t');
        !./do_simulate.sh
    %% get the power 
        load cooling_energy.dat
        load Pin.dat

    %% adjust the power to 0.5w
        Pin(1)=Pin(1)*sqrt(0.0013/cooling_energy);
        dlmwrite('Pin.dat',Pin,'\t');
        fprintf('the cooling energy is 0.5w\n')
        !./do_simulate.sh
    %% similate,get the Tmax and deltaT in channel layer 
        
        load output1.txt
        load output2.txt
        load output3.txt % the channel layer 
        %output3=CorrectTchannel(output3);
        Tmax(i)=max(max(max(output1)),max(max(output2)));
        Tmin(i)=min(min(min(output1)),min(min(output2)));
        deltaT.top(i)=max(max(output1))-min(min(output1));
        deltaT.bottom(i)=max(max(output2))-min(min(output2));
        deltaT.middle(i)=max(max(output3))-min(min(output3));       
        
        index(i)=i;
    end
    
    figure(7);
    title('Tmax and Tmin');
    plot(index,Tmax,'r',index,Tmin,'g');
    figure(8);
    title('Tmax-Tmin');
    plot(index,deltaT.top,'-r',index,deltaT.bottom,'b',index,deltaT.middle,'g');   
    
end

function DrawChannel(channel)
            draw_channel=channel;
            for i=1:101
                for j=1:101
                    switch channel(i,j)
                        case 2
                            draw_channel(i,j)=0;
                        case 1
                            draw_channel(i,j)=5;
                        case 3
                            draw_channel(i,j)=10;
                        otherwise
                            draw_channel(i,j)=15;
                    end
                end
            end
            contourf(draw_channel)

end