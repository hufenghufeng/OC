function [ flag ] = isUnfillable( channel,r,c )
% Whether a filled channel can be recovered 
%   
    [row,col]=size(channel);
    num=0;
    flag=0;
    if(r<=0||r>row||c<=0||c>col)
        fprintf('\nwrong location in isUnfillable!\n')
    end
    if(r>2&&c>2&&r<row-2&&c<col-2)
        if isEven(r)&&isEven(c)
            num=channel(r-2,c)+channel(r+2,c)+channel(r,c+2)+channel(r,c-2);
            if num>=2
                flag=1;
            else
                flag=0;
            end
        else
            if isEven(r)&&~isEven(c)
                num=channel(r,c+1)+channel(r,c-1);
                if num==2
                    flag=1;
                else
                    flag=0;
                end
            else if ~isEven(r)&&isEven(c)
                    num=channel(r+1,c)+channel(r-1,c);
                    if num==2
                        flag=1;
                    else
                        flag=0;
                    end                    
                end
            end
        end
        % four corner
    else if (((r==2)&&(c==2))||((r==2)&&(c==col-1))||((r==row-1)&&(col==2))||((r==row-1)&&(c==col-1)))
            flag=1;
            return;
            % four boundry
        else if r==1
                if channel(r+1,c)==1
                    flag=1;
                else
                    flag=0;
                end
            else if r==row 
                    if channel(r-1,c)==1
                        flag=1;
                    else
                        flag=0;
                    end
                else if c==1
                        if channel(r,c+1)==1
                            flag=1;
                        else
                            flag=0;
                        end
                    else if c==col
                            if channel(r,col-1)==1
                                flag=1;
                            else
                                flag=0;
                            end
                            % four next boundry
                        else if r==2
                                if isEven(c)
                                    num=channel(r+2,c)+channel(r,c+2)+channel(r,c-2);
                                    if num>=1
                                        flag=1;
                                    else
                                        flag=0;
                                    end
                                else
                                    num=channel(r,c+1)+channel(r,c-1);
                                    if num==2
                                        flag=1;
                                    else
                                        flag=0;
                                    end
                                end
                            else if r==row-1
                                    if isEven(c)
                                        num=channel(r-2,c)+channel(r,c+2)+channel(r,c-2);
                                        if num>=1
                                            flag=1;
                                        else
                                            flag=0;
                                        end 
                                    else
                                        num=channel(r,c+1)+channel(r,c-1);
                                        if num==2
                                            flag=1;
                                        else
                                            flag=0;
                                        end
                                    end                                        
                                else if c==2
                                        if isEven(r)
                                            num=channel(r-2,c)+channel(r+2,c)+channel(r,c+2);
                                            if num>=1
                                                flag=1;
                                            else
                                                flag=0;
                                            end 
                                        else
                                            num=channel(r+1,c)+channel(r-1,c);
                                            if num==2
                                                flag=1;
                                            else
                                                flag=0;
                                            end
                                        end                                             
                                    else if c==col-1
                                            if isEven(r)
                                                num=channel(r-2,c)+channel(r+2,c)+channel(r,c-2);                                           
                                                if num>=1
                                                    flag=1;
                                                else
                                                    flag=0;
                                                end     
                                            else
                                                num=channel(r+1,c)+channel(r-1,c);
                                                if num==2
                                                    flag=1;
                                                else
                                                    flag=0;
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



            