function [channel]=DrawLine(channel,x1,y1,x2,y2)
%% draw '0' lines in channel


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
    if(x1~=x2)
        k=(y2-y1)/(x2-x1);
        if (x2<x1)
            for i=x1:-1:x2
                if(y2>y1)
                    for j=round(k*(i-x1)+y1):1:round(k*(i-1-x1)+y1)
                        if channel(i,j)~=-1
                            channel=fillChannel(channel,i,j);
                        end
                    end
                else
                    for j=round(k*(i-x1)+y1):-1:round(k*(i-1-x1)+y1)
                        if channel(i,j)~=-1
                            channel=fillChannel(channel,i,j);
                        end
                    end
                end
            end            
        else
            for i=x1:x2
               if(y2>y1)
                    for j=round(k*(i-x1)+y1):1:round(k*(i+1-x1)+y1)
                        if channel(i,j)~=-1
                            channel=fillChannel(channel,i,j);
                        end
                    end
               else 
                    for j=round(k*(i-x1)+y1):-1:round(k*(i+1-x1)+y1)
                        if channel(i,j)~=-1
                            channel=fillChannel(channel,i,j);
                        end
                    end                   
               end
            end
        end
        
            
    else
        if(y1<y2)
            for i=y1:y2
                if channel(x1,i)~=-1            
                    channel=fillChannel(channel,x1,i);
                end
            end
        else
             for i=y1:-1:y2
                if channel(x1,i)~=-1            
                    channel=fillChannel(channel,x1,i);
                end
             end 
        end
    end

