function [ channel ] = RemoveDeadBlock( pressure,channel )
%   remove the dead block in channel,e.g the channel has no velocity or the
%   velocity is very tiny
%   1 find pressure in pressure
%   search the neighbor pressure,see whether they are identical
%   if idectical recursive ,and pressure[i][j]=-1,channel[i][j]=0

%% remove isolated  IO
pressure_threshold=0.1;
Size=101;
for i=2:2:Size-1

    % top
    if(channel(1,i)>1&&channel(2,i)<1)
        channel(1,i)=0;
    end
    if(channel(1,i)>1&&channel(2,i)==1)
        if(abs(pressure(1,i)-pressure(2,i))<pressure_threshold)
            channel=fillChannel(channel,1,i);
            channel=fillChannel(channel,2,i);
        end
    end
    % bottom
    if(channel(Size,i)>1&&channel(Size-1,i)<1)
        channel=fillChannel(channel,Size,i);
    end
    if(channel(Size,i)>1&&channel(Size-1,i)==1)
        if(abs(pressure(Size,i)-pressure(Size-1,i))<pressure_threshold)
            channel=fillChannel(channel,Size,i);
            channel=fillChannel(channel,Size-1,i);
        end
    end    
    %west
    if(channel(i,1)>1&&channel(i,2)<1)
        channel=fillChannel(channel,i,1);
    end
    if(channel(i,1)>1&&channel(i,2)==1)
        if(abs(pressure(i,1)-pressure(i,2))<pressure_threshold)
            channel=fillChannel(channel,i,1);
            channel=fillChannel(channel,i,2);
        end
    end 
    %east
     if(channel(i,Size)>1&&channel(i,Size-1)<1)
        channel=fillChannel(channel,i,Size);
    end
    if(channel(i,Size)>1&&channel(i,Size-1)==1)
        if(abs(pressure(i,Size)-pressure(i,Size-1))<pressure_threshold)
            channel=fillChannel(channel,i,Size);
            channel=fillChannel(channel,i,Size-1);
        end
    end    
end
%% remove inner part,recursive 
for i=1:1:Size
    for j=1:1:Size
        if(channel(i,j)~=-1)
            [channel,pressure]=CheckDeadBlock(i,j,pressure,channel);
        end
    end 
end

end
%% inner part
function [Channel,Pressure]=CheckDeadBlock(i,j,Pressure,Channel)
    
Size=101;   
pressure_limits=2;
    %-1 1 -1
    % 1 1  1
    %-1 1 -1
    if(mod(i,2)==0&&mod(j,2)==0&&Channel(i,j)>0)
        % top
        if(i>1&&Channel(i-1,j)>0)
            if(Pressure(i,j)~=-1&&abs(Pressure(i,j)-Pressure(i-1,j))<pressure_limits)
                Channel=fillChannel(Channel,i-1,j);
                [Channel,Pressure]=CheckDeadBlock(i-1,j,Pressure,Channel);
                Pressure(i-1,j)=-1;
            end
        end
        % bottom
        if(i<Size&&Channel(i+1,j)>0)
            if(Pressure(i,j)~=-1&&abs(Pressure(i,j)-Pressure(i+1,j))<pressure_limits)
                Channel=fillChannel(Channel,i+1,j);
                [Channel,Pressure]=CheckDeadBlock(i+1,j,Pressure,Channel);
                Pressure(i+1,j)=-1;
            end 
        end
        % west 
        
        if(j>1&&Channel(i,j+1)>0)
            if(Pressure(i,j)~=-1&&abs(Pressure(i,j)-Pressure(i,j-1))<pressure_limits)
                Channel=fillChannel(Channel,i,j-1);
                [Channel,Pressure]=CheckDeadBlock(i,j-1,Pressure,Channel);
                Pressure(i,j-1)=-1;
            end
        end
        % east
        if(j<Size&&Channel(i,j+1)>0)
            if(Pressure(i,j)~=-1&&abs(Pressure(i,j)-Pressure(i,j+1))<pressure_limits)
                Channel=fillChannel(Channel,i,j+1);
                [Channel,Pressure]=CheckDeadBlock(i,j+1,Pressure,Channel);
                Pressure(i,j+1)=-1;
            end  
        end
    else
        %
        % -1 1 -1
        %
        
        if(mod(i,2)==1&&Channel(i,j)>0)
            % top
            if(i>1&&Channel(i-1,j)>0)
                if(Pressure(i,j)~=-1&&abs(Pressure(i,j)-Pressure(i-1,j))<pressure_limits)
                    Channel=fillChannel(Channel,i,j);
                    [Channel,Pressure]=CheckDeadBlock(i-1,j,Pressure,Channel);
                    Pressure(i,j)=-1;
                end
            end
            % bottom
            if(i<Size&&Channel(i+1,j)>0)
                if(Pressure(i,j)~=-1&&abs(Pressure(i,j)-Pressure(i+1,j))<pressure_limits)
                    Channel=fillChannel(Channel,i,j);             
                    [Channel,Pressure]=CheckDeadBlock(i+1,j,Pressure,Channel);
                    Pressure(i,j)=-1;
                end 
            end
        end
        %-1
        % 1
        %-1
        if(mod(j,2)==1&&Channel(i,j)>0)
            % west 
            if(j>1&&Channel(i,j-1)>0)
                if(Pressure(i,j)~=-1&&abs(Pressure(i,j)-Pressure(i,j-1))<pressure_limits)
                    Channel=fillChannel(Channel,i,j);
                    [Channel,Pressure]=CheckDeadBlock(i,j-1,Pressure,Channel);
                    Pressure(i,j)=-1;
                end
            end
            % east
            if(j<Size&&Channel(i,j+1)>0)
                if(Pressure(i,j)~=-1&&abs(Pressure(i,j)-Pressure(i,j+1))<pressure_limits)
                    Channel=fillChannel(Channel,i,j);                  
                    [Channel,Pressure]=CheckDeadBlock(i,j+1,Pressure,Channel);
                    Pressure(i,j)=-1;
                end  
            end 
        end
    end
end