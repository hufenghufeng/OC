function [ num ] = Adjacent_1_Num(row,col,channel)
%   return the number of adjacent 1 of the block (row,col)
%   the size of the matrix is set 101*101
    size=101;
    num=0;
    %left
    if(row>1)
           if(channel(row-1,col)>0)
               num=num+1;
           end
    end
    %right
    if(row<size)
        if(channel(row+1,col)>0)
            num=num+1;
        end
    end
    %up
    if(col>1)
        if(channel(row,col-1)>0)
            num=num+1;
        end
    end
    %down
    if(col<size)
        if(channel(row,col+1)>0)
            num=num+1;
        end
    end
    
               
end

