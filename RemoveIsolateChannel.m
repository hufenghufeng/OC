function [ channel ] = RemoveIsolateChannel( channel )
%remove the isolated 1 in channel by recusive
%   

for i=2:50
    if channel(26,i) ~= 0&&channel(26,i) ~= -1
        channel=MakeTipPart1(channel,26,i);
        break
    end
end

for i=2:50
    if channel(76,i) ~= 0&&channel(76,i) ~= -1
        channel=MakeTipPart2(channel,76,i);
        break
    end
end


for i=100:-1:52
    if channel(26,i) ~= 0&&channel(26,i) ~= -1
        channel=MakeTipPart4(channel,26,i);
        break
    end
end

for i=100:-1:52
    if channel(76,i) ~= 0&&channel(76,i) ~= -1
        channel=MakeTipPart3(channel,76,i);
        break
    end
end

for i=1:101
    for j=1:101
        if channel(i,j)==1
            channel(i,j)=0;
        end
        if channel(i,j)>=10
            channel(i,j)=channel(i,j)-10;
        end
    end
end



end

function  channel=MakeTipPart1(channel,i,j)

    if channel(i,j)>=1&&channel(i,j)<10
        channel(i,j)=channel(i,j)+10;
        if i<51&&i>1&&j<51&&j>1
            channel=MakeTipPart1(channel,i+1,j);
        end
        if i<51&&i>1&&j<51&&j>1
            channel=MakeTipPart1(channel,i-1,j);
        end
        if i<51&&i>1&&j<51&&j>1
            channel=MakeTipPart1(channel,i,j+1);
        end
        if i<51&&i>2&&j<51&&j>1
            channel=MakeTipPart1(channel,i,j-1); 
        end
    end
end

function  channel=MakeTipPart2(channel,i,j)

    if channel(i,j)>=1&&channel(i,j)<10
        channel(i,j)=channel(i,j)+10;
        if i<101&&i>51&&j<51j>1
            channel=MakeTipPart2(channel,i+1,j);
        end
        if i<101&&i>51&&j<51j>1
            channel=MakeTipPart2(channel,i-1,j);
        end
        if i<101&&i>51&&j<51j>1
            channel=MakeTipPart2(channel,i,j+1);
        end
        if i<101&&i>51&&j<51j>1
            channel=MakeTipPart2(channel,i,j-1); 
        end
    end
end

function  channel=MakeTipPart3(channel,i,j)

    if channel(i,j)>=1&&channel(i,j)<10
        channel(i,j)=channel(i,j)+10;
        if i<101&&i>51&&j<101&&j>51
            channel=MakeTipPart3(channel,i+1,j);
        end
        if i<101&&i>51&&j<101&&j>51
            channel=MakeTipPart3(channel,i-1,j);
        end
        if i<101&&i>51&&j<101&&j>51
            channel=MakeTipPart3(channel,i,j+1);
        end
        if i<101&&i>51&&j<101&&j>51
            channel=MakeTipPart3(channel,i,j-1); 
        end
    end
end

function  channel=MakeTipPart4(channel,i,j)

    if channel(i,j)>=1&&channel(i,j)<10
        channel(i,j)=channel(i,j)+10;
        if i<51&&i>1&&j<101&&j>51
            channel=MakeTipPart4(channel,i+1,j);
        end
        if i<51&&i>1&&j<101&&j>51
            channel=MakeTipPart4(channel,i-1,j);
        end
        if i<51&&i>1&&j<101&&j>51
            channel=MakeTipPart4(channel,i,j+1);
        end
        if i<51&&i>1&&j<101&&j>51
            channel=MakeTipPart4(channel,i,j-1); 
        end
    end
end