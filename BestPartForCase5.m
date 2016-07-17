function [best] = BestPartForCase5(test_case,channel,set_energy,wall_position,wall_length,wall_height)
%find the best of the northeast part eg.T3
%   ____________
%  | T1  |  T3  |
%  |_____|______|
%  | T2  |  T4  |
%  |_____|______|
%  ...________...
%  | __| | |__  |
%  |_____|______|
%  |     |      |
%  ..._ _|_ __...
%
index=1;
show_flag=1;
% set_energy=0.0038;
best.cost1=10000;
best.cost2=10000;
best.cost3=10000;
best.cost4=10000;
fid=fopen('case_name','w');
fprintf(fid,test_case);
fclose(fid);

% channel=RemoveLine(channel,100,2 ,92,10);     
% channel=RemoveLine(channel,2  ,22,30,38);
% channel=RemoveLine(channel,25 ,82,35,70); 
% 
% channel=RemoveLine(channel,101,wall_position,101-wall_height,wall_position);     
% channel=RemoveLine(channel,101-wall_height-1,wall_position+1,101-wall_height-1,wall_position+1+wall_length);

%   channel=initialChannel(6);
  
  for i=80:100
      for j=40:80
          if(channel(i,j)==0)
                channel(i,j)=1;
          end
      end
  end
  
filled_channel=channel;

for i=2:2:100
    filled_channel(101,i)=2;
    filled_channel(1  ,i)=2; 
end
figure(1)
DrawChannel(filled_channel);



for wall_position=47:2:53
    for wall_length=8:2:16
       for IO_position=80:2:86  
          for wall_height=6:2:10
              %% draw lines
              channel=DrawLine(filled_channel,100,    wall_position,102-wall_height,    wall_position); 
%               channel=DrawLine(       channel,100,102-wall_position,102-wall_height,102-wall_position); 
              channel=DrawLine(       channel,102-wall_height-1,     wall_position+1 ,102-wall_height-1,     wall_position+1+wall_length);
%               channel=DrawLine(       channel,102-wall_height-1,102-(wall_position+1),102-wall_height-1,102-(wall_position+1+wall_length)); 
              
%               channel=DrawLine(       channel,2,    wall_position,wall_height,    wall_position); 
% %               channel=DrawLine(       channel,2,102-wall_position,wall_height,102-wall_position); 
%               channel=DrawLine(       channel,wall_height+1,     wall_position+1 ,wall_height+1,     wall_position+1+wall_length);
%               channel=DrawLine(       channel,wall_height+1,102-(wall_position+1),wall_height+1,102-(wall_position+1+wall_length)); 
              %% draw IO
              for i=IO_position:2:100
                  channel(101,i)=3;
                  channel(1  ,i)=3;
%                   channel(101,102-i)=3;
%                   channel(1  ,102-i)=3;
              end
              %% show channel
                if show_flag==1
                    figure(2) 
                    DrawChannel(channel);
                end              
              %% try !
                dlmwrite('channel1.dat',channel,'\t');
                !./do_simulate.sh

                load cooling_energy.dat
                load Pin.dat  

                Pin(1)=Pin(1)*sqrt(set_energy/cooling_energy);
                dlmwrite('Pin.dat',Pin,'\t');
                fprintf('the cooling energy is 0.0065w\n')
                !./do_simulate.sh 

                load output1.txt
                load output2.txt


                output1=TurnoverMatrix(output1);
                output2=TurnoverMatrix(output2); 

        %         figure(3)
        %          [C,h]=contourf(output2,50);
        %          set(h,'ShowText','on','TextStep',get(h,'LevelStep')*5);

                Tmax.top(index)   =max(max(output1));
                Tmax.bottom(index)=max(max(output2));
                Tmax.max(index)   =max(Tmax.top(index),Tmax.bottom(index));

                Tmax1(index)=max(max(max(output1(51:101,1 :50 ))),max(max(output2(51:101, 1:50 ))));
                Tmax2(index)=max(max(max(output1(1 :50 ,1 :50 ))),max(max(output2(1 :50 , 1:50 ))));
                Tmax3(index)=max(max(max(output1(51:101,41:101))),max(max(output2(51:101,41:101))));
                Tmax4(index)=max(max(max(output1(1 :50 ,51:101))),max(max(output2( 1:50 ,51:101))));

                if Tmax1(index)<best.cost1
                    best.cost1        = Tmax1(index);
                    best.wall_position=wall_position;
                    best.wall_length  =wall_length;
                    best.IO_position  =IO_position;
                    best.wall_height  =wall_height;
                end
                if Tmax2(index)<best.cost2
                    best.cost2= Tmax2(index);
                    best.wall_position=wall_position;
                    best.wall_length  =wall_length;
                    best.IO_position  =IO_position;
                    best.wall_height  =wall_height;
                end
                if Tmax3(index)<best.cost3
                    best.cost3= Tmax3(index);
                    best.wall_position3=wall_position;
                    best.wall_length3  =wall_length;
                    best.IO_position3  =IO_position;
                    best.wall_height3  =wall_height;
                end
                if Tmax4(index)<best.cost4
                    best.cost4= Tmax4(index);
                    best.wall_position=wall_position;
                    best.wall_length  =wall_length;
                    best.IO_position  =IO_position;
                    best.wall_height  =wall_height;
                end


                if(Tmax.top(index)>Tmax.bottom(index))
                    [row_top,col_top]=find(output1==Tmax.max(index));
                    fprintf('the Tmax is :%f\n',Tmax.max(index));
                    fprintf('the top row is :\n');
                    disp(row_top);
                    fprintf('the top col is :\n'); 
                    disp(col_top);
                    fprintf('\n');
                else 
                    [row_bottom,col_bottom]=find(output2==Tmax.max(index));
                    fprintf('the Tmax is :%f\n',Tmax.max(index));
                    fprintf('the bottom row is :\n');
                    disp(row_bottom);
                    fprintf('the bottom col is :\n'); 
                    disp(col_bottom);
                    fprintf('\n');
                end
                fprintf('the index is: %d\n',index);
                index=index+1;
           end
       end
    end
end
fprintf('\nthe best of 3 is :%f,wall_position:%d,wall_length:%d,wall_height:%d,IO_position:%d\n',best.cost3,best.wall_position3, best.wall_length3,best.wall_height3, best.IO_position3);

    figure(3)
    [C,h]=contourf(output1,50);
    set(h,'ShowText','on','TextStep',get(h,'LevelStep')*5);
%     figure(4)
%     [C,h]=contourf(output2,50);
%     set(h,'ShowText','on','Textindex',get(h,'Levelindex')*5);


fprintf('\nthe best of 3 is :%f,wall_position:%d,wall_length:%d,wall_height:%d,IO_position:%d\n',best.cost3,best.wall_position3, best.wall_length3,best.wall_height3, best.IO_position3);


end



