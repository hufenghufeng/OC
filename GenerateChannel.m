function [ channel] = GenerateChannel( index )
%UNTITLED10 Summary of this function goes here
%   Detailed explanation goes here
size=101;
channel=zeros(101);
% fill the all the -1 
for i=1:2:size
    for j=1:2:size
        channel(i,j)=-1;
    end
end

switch index
    case 1
        
        for i=1:size
            for j=2:2:100
                if(i==1)
                    channel(i,j)=3;
                end
                if(i==101)
                    channel(i,j)=2;
                end
                if((i>1)&&(i<101))
                    channel(i,j)=1;
                end
            end
        end
        contourf(channel);
        drawnow;
    case 2
        for i=1:size
            for j=2:2:100
                if(i==1)
                    channel(i,j)=2;
                end
                if(i==101)
                    channel(i,j)=3;
                end
                if((i>1)&&(i<101))
                    channel(i,j)=1;
                end
            end
        end        
        contourf(channel);
        drawnow;    
    case 3
        for i=2:2:size-1
            for j=1:size
                if(j==1)
                    channel(i,j)=2;
                end
                if(j==101)
                    channel(i,j)=3;
                end
                if((j>1)&&(j<101))
                    channel(i,j)=1;
                end
            end
        end 
    case 4
        for i=2:2:size-1
            for j=1:size
                if(j==1)
                    channel(i,j)=3;
                end
                if(j==101)
                    channel(i,j)=2;
                end
                if((j>1)&&(j<101))
                    channel(i,j)=1;
                end
            end
        end 
        
    case 33
        for i=2:2:size-1
            for j=1:size
                if(j==1)
                    channel(i,j)=2;
                end
                if(j==101)
                    channel(i,j)=3;
                end
                if((j>1)&&(j<101))
                    channel(i,j)=1;
                end
            end
        end 
            for i=45:57
                for j=1:101
                    if (channel(i,j)~=-1)
                        channel(i,j)=0;
                    end
                end
            end
    case 34
        for i=2:2:size-1
            for j=1:size
                if(j==1)
                    channel(i,j)=3;
                end
                if(j==101)
                    channel(i,j)=2;
                end
                if((j>1)&&(j<101))
                    channel(i,j)=1;
                end
            end
        end 
            for i=45:57
                for j=1:101
                    if (channel(i,j)~=-1)
                        channel(i,j)=0;
                    end
                end
            end        
        
        
    otherwise
    warning('unknown generate channel type');
end
   
end

