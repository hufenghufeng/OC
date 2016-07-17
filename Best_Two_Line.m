function [  ] = Best_Two_Line( theta1,line_length1,theta2,line_length2,theta3,line_length3, theta4,line_length4)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    channel=initialChannel(6);
    
    channel=DrawLine(channel,100,2,100-line_length1*cos(theta1*pi),2+line_length1*sin(theta1*pi));     
    channel=DrawLine(channel,2,2,2+line_length2*cos(theta2*pi),2+line_length2*sin(theta2*pi));
   
    channel=DrawLine(channel,2,100,2+line_length4*cos(theta4*pi),100-line_length4*sin(theta4*pi));
    channel=DrawLine(channel,100,100,100-line_length3*cos(theta3*pi),100-line_length3*sin(theta3*pi));
    
    dlmwrite('channel1.dat',channel,'\t');
    !./do_simulate.sh

    load cooling_energy.dat
    load Pin.dat  

    Pin(1)=Pin(1)*sqrt(0.0015/cooling_energy);
    dlmwrite('Pin.dat',Pin,'\t');
    fprintf('the cooling energy is 0.0065w\n')
    !./do_simulate.sh 

    load output1.txt
    load output2.txt


    output1=TurnoverMatrix(output1);
    output2=TurnoverMatrix(output2);
    
    index=1;
    Tmax1(index)=max(max(output2(51:101,1:50)));
    Tmax2(index)=max(max(output2(1:50,1:50)));
    Tmax3(index)=max(max(output2(51:101,51:101)));
    Tmax4(index)=max(max(output2(1:50,51:101)));
    figure(1)
    DrawChannel(channel);
    figure(2)
    [C,h]=contourf(output2,50);
    set(h,'ShowText','on','TextStep',get(h,'LevelStep')*5); 
    fprintf('\ntmax1=:%f\n',Tmax1(index));
    fprintf('\ntmax2=:%f\n',Tmax2(index));
    fprintf('\ntmax3=:%f\n',Tmax3(index));
    fprintf('\ntmax4=:%f\n',Tmax4(index));    
end

function channel=DrawLine(channel,x1,y1,x2,y2)
%% draw '0' lines in channel

    if(x1<1||x1>101)
        warning('draw line error:the point is not in channel');
    end
    if(x2<1||x2>101)
        warning('draw line error:the point is not in channel');
    end
    if(y1<1||y1>101)
        warning('draw line error:the point is not in channel');
    end
    if(y2<1||y2>101)
        warning('draw line error:the point is not in channel');
    end
    if(x1~=x2)
        k=(y2-y1)/(x2-x1);
        if (x2<x1)
            for i=x1:-1:x2
                for j=round(k*(i-x1)+y1):sign(y2-y1):round(k*(i-1-x1)+y1)
                    if channel(i,j)~=-1
                        channel=fillChannel(channel,i,j);
                    end
                end
            end            
        else
            for i=x1:x2
                for j=round(k*(i-x1)+y1):sign(y2-y1):round(k*(i+1-x1)+y1)
                    if channel(i,j)~=-1
                        channel=fillChannel(channel,i,j);
                    end
                end
            end
        end
        
            
    else
        if(y1<y2)
            for i=y1:y2
                if channel(x1,i)~=-1            
                    channel=fillChannel(channel,x1,i);
                end
            end
        else
             for i=y1:-1:y2
                if channel(x1,i)~=-1            
                    channel=fillChannel(channel,x1,i);
                end
             end 
        end
    end
end