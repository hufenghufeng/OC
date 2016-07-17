function [ channel ] = fillOutputArea( channel,length)
%   pre-locate straght channel in output area
%
%   Detect the output automatically
%
%   ____________
%  | T1  |  T3  |
%  |_____|______|
%  | T2  |  T4  |
%  |_____|______|
%
% for example
% part4:
%   pattern 1:
%   |
%   | |
%   | | |
%   | | | |
%   pattern 2:
%   ________
%     ______
%       ____
%         __
%
output=3;
input =2;
Size=101;
testPoint1=floor(Size/2)-10;
testPoint2=testPoint1-10;
testPoint3=testPoint2-10;
length=26;

% part 1 ,detect output side
if (channel(testPoint1,1)==3&&channel(testPoint2,1)==3&&channel(testPoint3,1)==3)
    for i=2:2:length
        for j=2:2:i
            channel(23+i,j)=0;
        end
    end
else 
    for i=2:2:length
        for j=2:2:i
            channel(j,23+i)=0;
        end
    end           
end

%part 2
if (channel(50+testPoint1,1)==3&&channel(50+testPoint2,1)==3&&channel(50+testPoint3,1)==3)
    for i=2:2:length
        for j=2:2:i
            channel(102-(23+i),j)=0;
        end
    end
else 
    for i=2:2:length
        for j=2:2:i
            channel(102-j,23+i)=0;
        end
    end           
end    

%part3
if (channel(testPoint1,Size)==3&&channel(testPoint2,Size)==3&&channel(testPoint3,Size)==3)
    for i=2:2:length
        for j=2:2:i
            channel(23+i,102-j)=0;
        end
    end
else 
    for i=2:2:length
        for j=2:2:i
            channel(j,102-(23+i))=0;
        end
    end           
end

%part4
if (channel(50+testPoint1,Size)==3&&channel(50+testPoint2,Size)==3&&channel(50+testPoint3,Size)==3)
    for i=2:2:length
        for j=2:2:i
            channel(100-(23+i),102-j)=0;
        end
    end
else 
    for i=2:2:length
        for j=2:2:i
            channel(102-j,102-(23+i))=0;
        end
    end           
end
end