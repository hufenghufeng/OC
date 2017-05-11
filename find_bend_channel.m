clear all 
format long

size=101;
channel=zeros(101);

% fill the all the -1 
for i=1:2:size
    for j=1:2:size
        channel(i,j)=-1;
    end
end

for i=2:100
    for j=2:100
        if channel(i,j)~=-1
            channel(i,j)=1;
        end
    end
end

for i=2:6:100
    channel(i,1)=2;
    channel(i,size)=3;
end


dlmwrite('channel.dat',channel,'\t');
dlmwrite('channel1.dat',channel,'\t');
go;
!python test.py;
load bend_channel.dat;
bend_channel=RemoveLoops(bend_channel);
dlmwrite('channel1.dat',bend_channel,'\t');
go;