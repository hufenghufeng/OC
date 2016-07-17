function  [reverse_channel]=ReverseChannel(channel)
%UNTITLED12 Summary of this function goes here
%  reverse the inlet and outlet of the channel
    size=101;
    reverse_channel=channel;
    for j=2:2:(size-1)
        if(channel(1,j)==2)
            reverse_channel(1,j)=3;
        else if(channel(1,j)==3)
                reverse_channel(1,j)=2;
            end
        end
        
        if(channel(size,j)==2)
            reverse_channel(size,j)=3;
        else if(channel(size,j)==3)
                reverse_channel(size,j)=2;
            end
        end
    end
    
    for i=2:2:(size-1)
        if(channel(i,1)==2)
            reverse_channel(i,1)=3;
        else if(channel(i,1)==3)
                reverse_channel(i,1)=2;
            end
        end
        
        if(channel(i,size)==2)
            reverse_channel(i,size)=3;
        else if(channel(i,size)==3)
                reverse_channel(i,size)=2;
            end
        end  
    end

end

