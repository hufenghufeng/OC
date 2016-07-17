function [newT]=CorrectTchannel(Tchannel)
size =101;
newT=zeros(101);
newT=Tchannel;
    for i=2:2:size-1
        for j=2:2:size-1  
                sum=Tchannel(i-1,j)+Tchannel(i+1,j)+Tchannel(i,j+1)+Tchannel(i,j-1)+Tchannel(i-1,j-1)+Tchannel(i-1,j+1)+Tchannel(i+1,j-1)+Tchannel(i+1,j+1)+Tchannel(i,j);
                Tavg=sum/9;
                
                new_T(i,j)=Tavg
        end
    end

end
