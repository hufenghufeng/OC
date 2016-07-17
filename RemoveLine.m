function [channel]=RemoveLine(channel,x1,y1,x2,y2)
%% remove the line from the channel
    if(x1<1||x1>101)
        warning('draw line error:the point is not in channel');
    end
    if(x2<1||x2>101)
        warning('draw line error:the point is not in channel');
    end
    if(y1<1||y1>101)
        warning('draw line error:the point is not in channel');
    end
    if(y2<1||y2>101)
        warning('draw line error:the point is not in channel');
    end
    if y1==y2
       for i=x1:sign(x2-x1):x2
           if channel(i,y1)~=-1&&channel(i,y1)~=2&&channel(i,y1)~=3
               channel(i,y1)=1;
           end
           if channel(i,y1+1)~=-1&&channel(i,y1+1)~=2&&channel(i,y1+1)~=3
               channel(i,y1+1)=1;
            end
           if channel(i,y1-1)~=-1&&channel(i,y1-1)~=2&&channel(i,y1-1)~=3
               channel(i,y1-1)=1;
           end 
       end
    end
    
    if(x1~=x2)&&(y1~=y2)
        k=(y2-y1)/(x2-x1);
        if (x2<x1)
            for i=x1:-1:x2
                for j=round(k*(i-x1)+y1):sign(y2-y1):round(k*(i-1-x1)+y1)
                    if channel(i,j)~=-1&&channel(i,j)~=2&&channel(i,j)~=3
                        channel(i,j)=1;
                    end
                    if channel(i+1,j+1)~=-1&&channel(i+1,j+1)~=2&&channel(i+1,j+1)~=3
                        channel(i+1,j+1)=1;
                    end
                    if channel(i+1,j-1)~=-1&&channel(i+1,j-1)~=2&&channel(i+1,j-1)~=3
                        channel(i+1,j-1)=1;
                    end                    
                    if channel(i+1,j)~=-1&&channel(i+1,j)~=2&&channel(i+1,j)~=3
                        channel(i+1,j)=1;
                    end                    
                    if channel(i,j+1)~=-1&&channel(i,j+1)~=2&&channel(i,j+1)~=3
                        channel(i,j+1)=1;
                    end

                    if channel(i,j-1)~=-1&&channel(i,j-1)~=2&&channel(i,j-1)~=3
                        channel(i,j-1)=1;
                    end
                    if channel(i-1,j)~=-1&&channel(i-1,j)~=2&&channel(i-1,j)~=3
                        channel(i-1,j)=1;
                     end
                    if channel(i-1,j-1)~=-1&&channel(i-1,j-1)~=2&&channel(i-1,j-1)~=3
                        channel(i-1,j-1)=1;
                    end
                    if channel(i-1,j+1)~=-1&&channel(i-1,j+1)~=2&&channel(i-1,j+1)~=3
                        channel(i-1,j+1)=1;
                    end
                   
                end
            end            
        else
            for i=x1:x2
                for j=round(k*(i-x1)+y1):sign(y2-y1):round(k*(i+1-x1)+y1)
                    if channel(i,j)~=-1&&channel(i,j)~=2&&channel(i,j)~=3
                        channel(i,j)=1;
                    end
                    if channel(i+1,j+1)~=-1&&channel(i+1,j+1)~=2&&channel(i+1,j+1)~=3
                        channel(i+1,j+1)=1;
                    end
                    if channel(i,j+1)~=-1&&channel(i,j+1)~=2&&channel(i,j+1)~=3
                        channel(i,j+1)=1;
                    end
                    if channel(i+1,j)~=-1&&channel(i+1,j)~=2&&channel(i+1,j)~=3
                        channel(i+1,j)=1;
                    end
                    if channel(i,j-1)~=-1&&channel(i,j-1)~=2&&channel(i,j-1)~=3
                        channel(i,j-1)=1;
                    end
                     if channel(i-1,j)~=-1&&channel(i-1,j)~=2&&channel(i-1,j)~=3
                        channel(i-1,j)=1;
                     end
                    if channel(i-1,j-1)~=-1&&channel(i-1,j-1)~=2&&channel(i-1,j-1)~=3
                        channel(i-1,j-1)=1;
                    end
                    if channel(i-1,j+1)~=-1&&channel(i-1,j+1)~=2&&channel(i-1,j+1)~=3
                        channel(i-1,j+1)=1;
                    end
                     if channel(i+1,j-1)~=-1&&channel(i+1,j-1)~=2&&channel(i+1,j-1)~=3
                        channel(i+1,j-1)=1;
                    end  
                end
            end
        end
        
            
    else
        if(y1<y2)
            for i=y1:y2
                if channel(x1,i)~=-1&&channel(x1,i)~=2&&channel(x1,i)~=3            
                    channel(x1,i)=1;
                end
                if channel(x1+1,i)~=-1&&channel(x1+1,i)~=2&&channel(x1+1,i)~=3
                   channel(x1+1,i)=1;
                end
                if channel(x1-1,i)~=-1&&channel(x1-1,i)~=2&&channel(x1-1,i)~=3
                   channel(x1-1,i)=1;
                end               
            end
        else
             for i=y1:-1:y2
                if channel(x1,i)~=-1&&channel(x1,i)~=2&&channel(x1,i)~=3            
                    channel(x1,i)=1;
                end
                if channel(x1+1,i)~=-1&&channel(x1+1,i)~=2&&channel(x1+1,i)~=3
                   channel(x1+1,i)=1;
                end
                if channel(x1-1,i)~=-1&&channel(x1-1,i)~=2&&channel(x1-1,i)~=3
                   channel(x1-1,i)=1;
                end               
             end 
        end
    end    
end
