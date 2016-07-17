function [ channel ] = BestIO()
%   Get the best arragement of inlet and outlet
%   anti clock the IO from the T(1,2) and get Tqueue
    size=101;
    edge_length=25;
    Tavg=AverageT();
    channel=initialChannel(5);
    Tqueue=zeros(1,size-1);
    index=1;
    % the first row
    for i=2:4:(size-1)
        Tqueue(index)=Tavg(1,i)+Tavg(1,i+2);
        index=index+1;
    end
    % the east column
    for i=2:4:(size-1)
        Tqueue(index)=Tavg(i,size)+Tavg(i+2,size);
        index=index+1;
    end
    % the bottom row
    for i=(size-1):-4:2
        Tqueue(index)=Tavg(size,i)+Tavg(size,i-2);
        index=index+1;
    end
    % the west column
    for i=(size-1):-4:2
        Tqueue(index)=Tavg(i,1)+Tavg(i,1);
        index=index+1;
    end
    
    % storage different ratio of 2/3
    location=zeros(13,4);% the location of devide point
    sortlist=zeros(13,4);% the sort of Tavg in ascend
    len=[0,0,0,0];  % the length of array
    deltaT=zeros(1,13);
    
    for i=1:edge_length
        for j=1:edge_length
            for k=1:edge_length
                for l=1:edge_length
                    T1=Tqueue(i+1:edge_length+j);
                    len(1)=length(T1);
                    Tavg1=sum(T1)/(length(T1));
                    T2=Tqueue(edge_length+j+1:edge_length*2+k);
                    len(2)=length(T2);
                    Tavg2=sum(T2)/(length(T2));
                    T3=Tqueue(edge_length*2+k+1:edge_length*3+l);
                    len(3)=length(T3);
                    Tavg3=sum(T3)/(length(T3));
                    T4=[Tqueue(edge_length*3+l+1:(size-1)),Tqueue(1:i)];
                    len(4)=length(T4); 
                    Tavg4=sum(T4)/(length(T4));
                    % sort Tgroupe by column
                    Tgroupe=[Tavg1,Tavg2,Tavg3,Tavg4;1,2,3,4;len(1),len(2),len(3),len(4)];
                    Tgroupe=sortrows(Tgroupe');% ascend
                    Tgroupe=Tgroupe';
                    % limit the number of 2 and 3
                    numof2=Tgroupe(3,3)+Tgroupe(3,4);
                    numof3=Tgroupe(3,2)+Tgroupe(3,1);
                    % Ratio23 is in
                    % 1,2,3,4,5,6,7,8,9,10,11,12,13(0.5,0.525,0.55-----0.8)
                    Ratio23=round((numof2/numof3)*40-19);
                    if((Ratio23>1)&&(Ratio23<13))
                        if((Tgroupe(1,3)+Tgroupe(1,4)-Tgroupe(1,1)-Tgroupe(1,2))>deltaT(Ratio23))
                            sortlist(Ratio23,:)=Tgroupe(2,:);
                            location(Ratio23,:)=[i,j,k,l];
                            deltaT(Ratio23)=(Tgroupe(1,3)+Tgroupe(1,4)-Tgroupe(1,1)-Tgroupe(1,2));
                            best2num(Ratio23)=numof2;
                            best3num(Ratio23)=numof3;
                        end   
                    end
                end
            end
        end
    end
    
    %% find the best IO in location(1-7)
    for i=1:13   
        %% fill the IO
        % sort the 1,2,3,4and arrange the 2, or 3
        temp=[sortlist(i,:);3,3,2,2];
        temp=sortrows(temp');
        temp=temp';

        for num=4*location(i,1)+2:4:size-1
            channel(1,num)=temp(2,1);
            channel(1,num+2)=temp(2,1);
        end

        for num=2:4:4*location(i,2)-2
            channel(num,size)=temp(2,1);
            channel(num+2,size)=temp(2,1);
        end

        for num=4*location(i,2)+2:4:size-3
            channel(num,size)=temp(2,2);
            channel(num+2,size)=temp(2,2);
        end

        for num=size-1:-4:4*(edge_length+1-location(i,3))
            channel(size,num)=temp(2,2);
            channel(size,num-2)=temp(2,2);
        end

        for num=4*(edge_length+1-location(i,3))-4:-4:4
            channel(size,num)=temp(2,3);
            channel(size,num-2)=temp(2,3);
        end

        for num=size-1:-4:4*(edge_length+1-location(i,4))
            channel(num,1)=temp(2,3);
            channel(num-2,1)=temp(2,3);
        end

        for num=4*(edge_length+1-location(i,4))-4:4:4
            channel(num,1)=temp(2,4);
            channel(num-2,1)=temp(2,4);
        end

        for num=2:4:4*location(i,1)-2
            channel(1,num)=temp(2,4);
            channel(1,num+2)=temp(2,4);
        end
        %% evaluate the Tmax-Tmin by simulator
        dlmwrite('channel1.dat',channel,'\t');
        !./optimized test_case_01.stk
        load output1.txt
        load output2.txt
        
        output1=TurnoverMatrix(output1)-300;
        output2=TurnoverMatrix(output2)-300;
        
        Tgradient(i)=max((max(max(output1))-min(min(output1))),(max(max(output2))-min(min(output2))));
        
    end
    %% find the best number of 2 and 3 
    plot(Tgradient);
    
end

