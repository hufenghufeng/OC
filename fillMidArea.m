function [ channel ] = fillMidArea( channel,length )
%fill the middle area as the following show:
 %   2  2   2  2
% 3       0      3
% 3     0 0 0    3
%    0 0 0 0 0 0
% 2     0 0 0    3
% 2       0      3
%    3  3   2  2 
[row,column]=size(channel);
if(row~=column&&mod(row,2)~=1)
    fprintf('the matrix is not a square or size is not right!')
    return
end
fill_kind=1;
% get the center point
center_row   =floor(row/2)+1;
center_column=floor(column/2)+1;
% |\
% |  \
% |    \
% |______\
if fill_kind==1
    % 1.begin point
    for i=2:2:floor(length/square(2))
        %%part 4
        for horizon=1:2:length-i
            if  channel(center_row+i,center_column+i+horizon)==1
                channel(center_row+i,center_column+i+horizon)=0;
            end
        end

        for vertical=1:2:length-i
            if  channel(center_row+i+vertical,center_column+i)==1
                channel(center_row+i+vertical,center_column+i)=0;
            end
        end
        %%part 3
        for horizon=1:2:length-i
            if  channel(center_row+i,center_column-i-horizon)==1
                channel(center_row+i,center_column-i-horizon)=0;
            end
        end

        for vertical=1:2:length-i
            if  channel(center_row+i+vertical,center_column-i)==1
                channel(center_row+i+vertical,center_column-i)=0;
            end
        end  
        %%part 2
        for horizon=1:2:length-i
            if  channel(center_row-i,center_column+i+horizon)==1
                channel(center_row-i,center_column+i+horizon)=0;
            end
        end

        for vertical=1:2:length-i
            if  channel(center_row-i-vertical,center_column+i)==1
                channel(center_row-i-vertical,center_column+i)=0;
            end
        end 
        %%part 1
        for horizon=1:2:length-i
            if  channel(center_row-i,center_column-i-horizon)==1
                channel(center_row-i,center_column-i-horizon)=0;
            end
        end

        for vertical=1:2:length-i
            if  channel(center_row-i-vertical,center_column-i)==1
                channel(center_row-i-vertical,center_column-i)=0;
            end
        end    
    end
else
     for i=2:2:floor(length/square(2))
        %%part 4
        for horizon=1:2:length-2*i
            if  channel(center_row+i,center_column+i+horizon)==1
                channel(center_row+i,center_column+i+horizon)=0;
            end
        end

        for vertical=1:2:length-2*i
            if  channel(center_row+i+vertical,center_column+i)==1
                channel(center_row+i+vertical,center_column+i)=0;
            end
        end
        %%part 3
        for horizon=1:2:length-2*i
            if  channel(center_row+i,center_column-i-horizon)==1
                channel(center_row+i,center_column-i-horizon)=0;
            end
        end

        for vertical=1:2:length-2*i
            if  channel(center_row+i+vertical,center_column-i)==1
                channel(center_row+i+vertical,center_column-i)=0;
            end
        end  
        %%part 2
        for horizon=1:2:length-2*i
            if  channel(center_row-i,center_column+i+horizon)==1
                channel(center_row-i,center_column+i+horizon)=0;
            end
        end

        for vertical=1:2:length-2*i
            if  channel(center_row-i-vertical,center_column+i)==1
                channel(center_row-i-vertical,center_column+i)=0;
            end
        end 
        %%part 1
        for horizon=1:2:length-2*i
            if  channel(center_row-i,center_column-i-horizon)==1
                channel(center_row-i,center_column-i-horizon)=0;
            end
        end

        for vertical=1:2:length-2*i
            if  channel(center_row-i-vertical,center_column-i)==1
                channel(center_row-i-vertical,center_column-i)=0;
            end
        end    
     end
end
end

