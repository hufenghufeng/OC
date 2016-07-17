function [channel] = CheckConnect( row,col,channel )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
   if(channel(row,col)>0)
        if(Adjacent_1_Num(row,col,channel)==0)
            channel(row,col)=0;
        else if(Adjacent_1_Num(row,col,channel)==1) 
                channel(row,col)=0;
                [row_temp,col_temp]=Adjacent_1_Location(row,col,channel);
                channel=CheckConnect(row_temp,col_temp,channel);
            end
        end
   end
            

end

