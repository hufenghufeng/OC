function DrawChannel(channel)
            draw_channel=channel;
            for i=1:101
                for j=1:101
                    switch channel(i,j)
                        case 2
                            draw_channel(i,j)=0;%% 0 IS dark blue
                        case 1
                            draw_channel(i,j)=8;
                        case 3
                            draw_channel(i,j)=20;%% 20 is red ,perfect
                        case -1
                            draw_channel(i,j)=17;%% 25 is dark red
                        otherwise
                            draw_channel(i,j)=25;%% orange
                    end
                end
            end
            xx=[1:102];
            yy=[1:102];
            draw_channel(102,:)=0;
            draw_channel(:,102)=0;
            h=pcolor(xx,yy,draw_channel);    
            set(h, 'EdgeColor', 'none');
end

