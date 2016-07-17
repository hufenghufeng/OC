function [ channel] = recoverChannel( channel,initChannel,r,c )
% recover filled channel
%   
    [row,col]=size(channel);
    num=0;
    if(r<=0||r>row||c<=0||c>col)
        fprintf('\nwrong location in isUnfillable!\n')
    end
    if(r>2&&c>2&&r<row-2&&c<col-2)
        if isEven(r)&&isEven(c)
            channel(r,c)=1;
            if channel(r-2,c)==1
                channel(r-1,c)=1;
            end
            if channel(r+2,c)==1;
                channel(r+1,c)=1;
            end
            if channel(r,c+2)==1
                channel(r,c+1)=1;
            end
            if channel(r,c-2)==1
                channel(r,c-1)=1;
            end            
        else
            if isEven(r)&&~isEven(c)
                channel(r,c)=1;
                
            else if ~isEven(r)&&isEven(c)
                    channel(r,c)=1;                  
                end
            end
        end
        % four corner
    else if (((r==2)&&(c==2))||((r==2)&&(c==col-1))||((r==row-1)&&(c==2))||((r==row-1)&&(c==col-1)))
            channel(r,c)=1;
            if (r==2)&&(c==2)
                channel(r,1)=initChannel(r,1);
                channel(1,c)=initChannel(1,c);
            end
            
            if (r==2)&&(c==col-1)
                channel(r,col)  =initChannel(r,col);
                channel(1,col-1)=initChannel(1,col-1);
            end
            
            if (r==row-1)&&(c==2)
                channel(r,1)= initChannel(r,1);
                channel(r+1,c)=initChannel(r+1,c);
            end
            
            if (r==row-1)&&(c==col-1)
                channel(r,col)= initChannel(r,col);
                channel(row,c)= initChannel(row,c);
            end
            % four boundry
        else if r==1
                channel(r,c)=initChannel(r,c);
            else if r==row 
                    channel(r,c)=initChannel(r,c);
                else if c==1
                        channel(r,c)=initChannel(r,c);
                    else if c==col
                           channel(r,c)=initChannel(r,c); 
                            % four next boundry
                        else if r==2
                                if isEven(c)
                                    channel(r,c)=1;
                                    channel(1,c)=initChannel(1,c);
                                    if channel(r+2,c)==1;
                                        channel(r+1,c)=1;
                                    end
                                    if channel(r,c+2)==1
                                        channel(r,c+1)=1;
                                    end
                                    if channel(r,c-2)==1
                                        channel(r,c-1)=1;
                                    end  
                                else
                                    if channel(r,c+1)~=0&&channel(r,c-1)~=0
                                        channel(r,c)=1;
                                    end
                                end
                            else if r==row-1
                                    if isEven(c)
                                        channel(r,c)=1;
                                        channel(r+1,c)=initChannel(r+1,c);
                                        if channel(r-2,c)==1
                                            channel(r-1,c)=1;
                                        end
                                        if channel(r,c+2)==1
                                            channel(r,c+1)=1;
                                        end
                                        if channel(r,c-2)==1
                                            channel(r,c-1)=1;
                                        end      
                                    else
                                        if channel(r,c+1)~=0&&channel(r,c-1)~=0
                                            channel(r,c)=1;
                                        end
                                    end
                                else if c==2
                                        if isEven(r)
                                            channel(r,c)=1;
                                            channel(r,c-1)=initChannel(r,c-1);
                                            if channel(r-2,c)==1
                                                channel(r-1,c)=1;
                                            end
                                            if channel(r+2,c)==1;
                                                channel(r+1,c)=1;
                                            end
                                            if channel(r,c+2)==1
                                                channel(r,c+1)=1;
                                            end  
                                        else
                                            if channel(r+1,c)~=0&&channel(r-1,c)~=0
                                                channel(r,c)=1;
                                            end
                                        end
                                    else if c==col-1
                                            if isEven(r)
                                                channel(r,c)=1;
                                                channel(r,c+1)=initChannel(r,c+1);
                                                if channel(r-2,c)==1
                                                    channel(r-1,c)=1;
                                                end
                                                if channel(r+2,c)==1;
                                                    channel(r+1,c)=1;
                                                end
                                                if channel(r,c-2)==1
                                                    channel(r,c-1)=1;
                                                end     
                                            else
                                                if channel(r+1,c)~=0&&channel(r-1,c)~=0
                                                    channel(r,c)=1;
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end

end


function [flag]=isEven(a)
    if mod(a,2)==0
        flag=1;
    else
        flag=0;
    end
end
