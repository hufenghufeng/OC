function [ channel ] = RemoveHook( channel,part_num,theta,line_length,hook_length,hook_type )
%remove a hook shape line in channel
%
%  hook_type: 0
% 
%    ++++++++
%        +
%      +
%    +
%  + 
%+
%
%  hook_type: 1
%
%             ++
%           +  +
%         +    +
%       +      +
%     +        +
%   +
% +

switch part_num
    
    case 2
        channel=RemoveLine(channel,2  ,2  ,2  +line_length*cos(theta*pi),2  +line_length*sin(theta*pi));  
        if hook_type==1
            if mod(2  +fix(line_length*sin(theta*pi)),2)==1
                channel=RemoveLine(channel,2  +fix(line_length*cos(theta*pi)),2  +fix(line_length*sin(theta*pi))  ,2  +fix(line_length*cos(theta*pi))-hook_length-2,2  +fix(line_length*sin(theta*pi))); 
            else
                channel=RemoveLine(channel,2  +fix(line_length*cos(theta*pi)),2  +fix(line_length*sin(theta*pi))+1,2  +fix(line_length*cos(theta*pi))-hook_length-2,2  +fix(line_length*sin(theta*pi))+1);
            end
        else
            if mod(2  +fix(line_length*cos(theta*pi)),2)==1
                channel=RemoveLine(channel,2  +fix(line_length*cos(theta*pi))  ,2  +fix(line_length*sin(theta*pi)),2  +fix(line_length*cos(theta*pi)),2  +fix(line_length*sin(theta*pi))-hook_length-2); 
            else
                channel=RemoveLine(channel,2  +fix(line_length*cos(theta*pi))+1,2  +fix(line_length*sin(theta*pi)),2  +fix(line_length*cos(theta*pi))+1,2  +fix(line_length*sin(theta*pi))-hook_length-2); 
            end
        end
            
    case 3
        channel=RemoveLine(channel,100,100,100-line_length*cos(theta*pi),100-line_length*sin(theta*pi)); 
        if hook_type==1
            if mod(100-fix(line_length*sin(theta*pi)),2)==1
                channel=RemoveLine(channel,100-fix(line_length*cos(theta*pi)),100-fix(line_length*sin(theta*pi))-1,100-fix(line_length*cos(theta*pi))+hook_length+2 ,100-fix(line_length*sin(theta*pi))); 
            else 
                channel=RemoveLine(channel,100-fix(line_length*cos(theta*pi)),100-fix(line_length*sin(theta*pi))-1,100-fix(line_length*cos(theta*pi))+hook_length+2,100-fix(line_length*sin(theta*pi))-1); 
            end
        else
            if mod(100-fix(line_length*cos(theta*pi)),2)==1
                channel=RemoveLine(channel,100-fix(line_length*cos(theta*pi))  ,100-fix(line_length*sin(theta*pi))-1,100-fix(line_length*cos(theta*pi))             ,100-fix(line_length*sin(theta*pi))+hook_length+2);
            else
                channel=RemoveLine(channel,100-fix(line_length*cos(theta*pi))-1,100-fix(line_length*sin(theta*pi))-1,100-fix(line_length*cos(theta*pi))-1           ,100-fix(line_length*sin(theta*pi))+hook_length+2);  
            end
        end
    case 4
        channel=RemoveLine(channel,2  ,100,2  +line_length*cos(theta*pi),100-line_length*sin(theta*pi));
        if hook_type==1
            if mod(100-fix(line_length*sin(theta*pi)),2)==1
                channel=RemoveLine(channel,2  +fix(line_length*cos(theta*pi)),100-fix(line_length*sin(theta*pi))  ,2  +fix(line_length*cos(theta*pi))-hook_length-2,100-fix(line_length*sin(theta*pi))  );
            else
                channel=RemoveLine(channel,2  +fix(line_length*cos(theta*pi)),100-fix(line_length*sin(theta*pi))-1,2  +fix(line_length*cos(theta*pi))-hook_length-2,100-fix(line_length*sin(theta*pi))-1 );  
            end
        else
            if mod(2  +fix(line_length*cos(theta*pi)),2)==1
                channel=RemoveLine(channel,2  +fix(line_length*cos(theta*pi))  ,100-fix(line_length*sin(theta*pi))  ,2  +fix(line_length*cos(theta*pi))  ,100-fix(line_length*sin(theta*pi))+hook_length+2  );
            else
                channel=RemoveLine(channel,2  +fix(line_length*cos(theta*pi))+1,100-fix(line_length*sin(theta*pi))  ,2  +fix(line_length*cos(theta*pi))+1,100-fix(line_length*sin(theta*pi))+hook_length+2  ); 
            end
        end
    otherwise
        warning('unknown  channel 1,2,3,4 part');
end
figure(1)
DrawChannel(channel);


end

