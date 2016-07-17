function [row_temp,col_temp]=Adjacent_1_Location(row,col,channel)
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here
%   the size of the matrix is set 101*101
    size=101;
    
    %left
    if(row>1)
           if(channel(row-1,col)>0)
               row_temp=row-1;
               col_temp=col;
           end
    end
    %right
    if(row<size)
        if(channel(row+1,col)>0)
               row_temp=row+1;
               col_temp=col;
        end
    end
    %up
    if(col>1)
        if(channel(row,col-1)>0)
               row_temp=row;
               col_temp=col-1;
        end
    end
    %down
    if(col<size)
        if(channel(row,col+1)>0)
               row_temp=row;
               col_temp=col+1;
        end
    end

end

