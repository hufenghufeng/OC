function [ channel ] = fillSolid( channel,row,col )
%If the coldest area is a TSV, fill the surroundding area
%
% divide into the four area
%   \ 1  /
%    \  /
%  2  \/  4 
%     /\
%    /  \
%   / 3  \
%  in 1,3 fill by :
%     0
%     -1
%     0
%  in 2,4 fill by : 0 -1 0


% which part？
% row>col && row> size-col ::1
% row>col && row< size-col ::2

% row<col && row> size-col ::4
% row<col && row< size-col ::3

% don't deal with the TSV in boundry
[totalRol,totalCol]=size(channel);
SIZE=totalRol;

    if (row>col && row>SIZE-col)||(row<col && row<SIZE-col)
        if (1<row && row< SIZE)
            channel(row+1,col)=0;
            channel(row-1,col)=0;
            channel=CheckConnect(row+1,col+1,channel);
            channel=CheckConnect(row+1,col-1,channel);
            channel=CheckConnect(row-1,col+1,channel);
            channel=CheckConnect(row-1,col-1,channel);  
        end
    else
        if (1<col && col<SIZE)
            channel(row,col-1)=0;
            channel(row,col+1)=0;
            channel=CheckConnect(row+1,col+1,channel);
            channel=CheckConnect(row+1,col-1,channel);
            channel=CheckConnect(row-1,col+1,channel);
            channel=CheckConnect(row-1,col-1,channel);  
        end
    end
    
    if row==1
            channel(row+1,col)=0;
            if col~=SIZE
                channel=CheckConnect(row+1,col+1,channel);
            end
            if col~=1
                channel=CheckConnect(row+1,col-1,channel);
            end
    else if row==SIZE
            channel(row-1,col)=0;
            if col~=SIZE
                channel=CheckConnect(row-1,col+1,channel);
            end
            if col~=1
                channel=CheckConnect(row-1,col-1,channel);
            end
        end
    end
    
    if col==1
        channel(row,col+1)=0;
        if row~=SIZE
            channel=CheckConnect(row+1,col+1,channel);
        end
        if row~=1
            channel=CheckConnect(row-1,col+1,channel);
        end
    else if col==SIZE
        channel(row,col-1)=0;
        if row~=SIZE
            channel=CheckConnect(row+1,col-1,channel);
        end
        if row~=1
            channel=CheckConnect(row-1,col-1,channel);
        end
        end
    end
    
end

