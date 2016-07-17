function [balance1,balance2]=BalanceTmap(channel)
%UNTITLED11 Summary of this function goes here
%   reverse the inlet and outlet of the channel
%   get the output ,caculate the balance matrix
    reverse_channel=ReverseChannel(channel);
    dlmwrite('channel1.dat',reverse_channel,'\t');
    !./optimized test_case_01.stk
    
    load output1.txt
    load output2.txt
    
    output3=TurnoverMatrix(output1);
    output4=TurnoverMatrix(output2);    
    
    balance1=output3-300;
    balance2=output4-300;
    

end

function Tchannel=CorrectTchannel(Tchannel,channel)
size =101;
    for i=2:2:size-1
        if(channel(1,i)>0)
            channel(1,i)=1;
        end
        if(channel(size,i)>0)
            channel(size,i)=1;
        end
        if(channel(i,1)>0)
            channel(i,1)=1;
        end
        if(channel(i,size)>0)
            channel(i,size)=1;
        end
    end
    
    for i=2:2:size-1
        for j=2:2:size-1
            if channel(i,j)>0
                sum=channel(i-1,j)*Tchannel(i-1,j)+channel(i+1,j)*Tchannel(i+1,j)+channel(i,j-1)*Tchannel(i,j-1)+channel(i,j+1)*Tchannel(i,j+1)+channel(i,j)*Tchannel(i,j);
                Tavg=sum/(channel(i-1,j)+channel(i+1,j)+channel(i,j-1)+channel(i,j+1))+channel(i,j);

                Tchannel(i-1,j)=(1-channel(i-1,j))*Tchannel(i-1,j)+channel(i-1,j)*Tavg;
                Tchannel(i+1,j)=(1-channel(i-1,j))*Tchannel(i+1,j)+channel(i+1,j)*Tavg;
                Tchannel(i,j-1)=(1-channel(i-1,j))*Tchannel(i,j-1)+channel(i,j-1)*Tavg;
                Tchannel(i,j+1)=(1-channel(i-1,j))*Tchannel(i,j+1)+channel(i,j+1)*Tavg;
                Tchannel(i,j)  =(1-channel(i-1,j))*Tchannel(i,j)  +channel(i,j)*Tavg;
                
                channel(i-1,j)=0;
                channel(i+1,j)=0;
                channel(i,j-1)=0;
                channel(i,j+1)=0;
                channel(i,j)=0;                
            end
        end
    end
end