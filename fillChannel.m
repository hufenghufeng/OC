function [ channel ] = fillChannel( channel,row,col )
%UNTITLED4 Summary of this function goes here

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

    if(channel(row,col)~=-1)
        if((row<101)&&(row>1)&&(col>1)&&(col<101))
            if(channel(row,col)==-1)
                channel(row+1,col)=0;
                channel(row-1,col)=0;
                channel(row,col+1)=0;
                channel(row,col-1)=0;
                %check neighbor
                channel=CheckConnect(row+1,col+1,channel);
                channel=CheckConnect(row-1,col+1,channel);
                channel=CheckConnect(row+1,col-1,channel);
                channel=CheckConnect(row-1,col-1,channel);
            else
                channel(row,col)=0;
                %check neighbor
                channel=CheckConnect(row,col+1,channel);
                channel=CheckConnect(row-1,col,channel);
                channel=CheckConnect(row,col-1,channel);
                channel=CheckConnect(row+1,col,channel);        
            end

        end

        if((row==1)&&(col>1)&&(col<101))
            if(channel(row,col)==-1)
                        channel(row+1,col)=0;
                        channel(row,col+1)=0;
                        channel(row,col-1)=0;
                %check neighbor
                channel=CheckConnect(row+1,col+1,channel);
              %  CheckConnect(row-1,col+1);
                channel=CheckConnect(row+1,col-1,channel);
              %  CheckConnect(row-1,col-1);                
            else
                channel(row,col)=0;
                        %check neighbor
                channel=CheckConnect(row+1,col,channel);
            end
        end

        if((row==101)&&(col>1)&&(col<101))
            if(channel(row,col)==-1)
        %        channel(row+1,col)=0;
                channel(row-1,col)=0;
                channel(row,col+1)=0;
                channel(row,col-1)=0;
                        %check neighbor
                %CheckConnect(row+1,col+1);
                channel=CheckConnect(row-1,col+1,channel);
                %CheckConnect(row+1,col-1);
                channel=CheckConnect(row-1,col-1,channel);
            else
                channel(row,col)=0;
                        %check neighbor
                channel=CheckConnect(row-1,col,channel);
            end
        end

        if((col==1)&&(row>1)&&(row<101))
            if(channel(row,col)==-1)
                channel(row+1,col)=0;
                channel(row-1,col)=0;
                channel(row,col+1)=0;
        %        channel(row,col-1)=0;
                %check neighbor
                channel=CheckConnect(row+1,col+1,channel);
                channel=CheckConnect(row-1,col+1,channel);
               % CheckConnect(row+1,col-1);
               % CheckConnect(row-1,col-1);

            else
                channel(row,col)=0;
                %check neighbor
                channel=CheckConnect(row,col+1,channel);  
            end
        end


        if((col==101)&&(row>1)&&(row<101))
            if(channel(row,col)==-1)
                channel(row+1,col)=0;
                channel(row-1,col)=0;
        %        channel(row,col+1)=0;
                channel(row,col-1)=0;
                        %check neighbor
              %  CheckConnect(row+1,col+1);
              %  CheckConnect(row-1,col+1);
                channel=CheckConnect(row+1,col-1,channel);
                channel=CheckConnect(row-1,col-1,channel);
            else
                channel(row,col)=0;
                        %check neighbor
                channel=CheckConnect(row,col-1,channel);
            end
        end



        if((row==1)&&(col)==1)
            channel(row+1,col)=0;
            channel(row,col+1)=0;

            channel=CheckConnect(row+1,col+1,channel);
        end

        if((row==1)&&(col==101))
            channel(row+1,col)=0;
            channel(row,col-1)=0;

            channel=CheckConnect(row+1,col-1,channel);
        end

        if((row==101)&&(col==1))
            channel(row,col+1)=0;
            channel(row-1,col)=0;

            channel=CheckConnect(row-1,col+1,channel);
        end

        if((row==101)&&(col==101))
            channel(row,col-1)=0;
            channel(row-1,col)=0;

            channel=CheckConnect(row-1,col-1,channel);
        end
    else
%     %% The cold aarea is a TSV !
%         if (row>col && row>SIZE-col)||(row<col && row<SIZE-col)
%             if (1<row && row< SIZE)
%                 channel(row+1,col)=0;
%                 channel(row-1,col)=0;
%                 channel=CheckConnect(row+1,col+1,channel);
%                 channel=CheckConnect(row+1,col-1,channel);
%                 channel=CheckConnect(row-1,col+1,channel);
%                 channel=CheckConnect(row-1,col-1,channel);  
%             end
%         else
%             if (1<col && col<SIZE)
%                 channel(row,col-1)=0;
%                 channel(row,col+1)=0;
%                 channel=CheckConnect(row+1,col+1,channel);
%                 channel=CheckConnect(row+1,col-1,channel);
%                 channel=CheckConnect(row-1,col+1,channel);
%                 channel=CheckConnect(row-1,col-1,channel);  
%             end
%         end
        channel=fillSolid(channel,row,col);
    end
end


