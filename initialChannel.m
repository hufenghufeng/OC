function [ channel ] = initialChannel( index )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
size=101;
channel=zeros(size,size);


%fill all the grid with 1
for i=2:(size-1)
    for j=2:(size-1)
        channel(i,j)=1;
    end
end

% fill the all the -1 
for i=1:2:size
    for j=1:2:size
        channel(i,j)=-1;
    end
end

    switch index
        
        case 1
            % fill all the other grid with 2 or 3
            % west and north is 2
            % east and south is 3
            % 2 2
            % 2   3
            %   3 3
            for i=2:2:(size-1)
                channel(1,i)=2;
                channel(i,1)=2;
                channel(i,size)=3;
                channel(size,i)=3;
            end
        case 2
            channel=ReverseChannel(initialChannel(1));
        case 3
            %   3 3
            % 2   3
            % 2 2
            for i=2:2:(size-1)
                channel(1,i)=3;
                channel(i,1)=2;
                channel(i,size)=3;
                channel(size,i)=2;
            end
        case 4
            channel=ReverseChannel(initialChannel(3));
        case 5
            % 2  3  2
            % 2     2
            % 2  3  2
            for i=2:2:(size-1)
                channel(1,i)=3;
                channel(i,1)=2;
                channel(i,size)=2;
                channel(size,i)=3;
            end
        case 6
            channel=ReverseChannel(initialChannel(5));
        case 7
            %    3  3  2  2
            % 2             3
            % 2             3
            % 3             2
            % 3             2
            %    2  2  3  3
            for i=2:2:(size-1)/2
                channel(1,i)=3;
                channel(i,1)=2;
                channel(i,size)=3;
                channel(size,i)=2;
            end
            for i=(size-1)/2+2:2:size-1
                channel(1,i)=2;
                channel(i,1)=3;
                channel(i,size)=2;
                channel(size,i)=3;
            end 
        case 8
            channel=ReverseChannel(initialChannel(7));
        case 9
            %    3  2
            % 2     3
            % 3  2   
            for i=2:2:fix(2*size/3-1)
                channel(1,i)=3;
                channel(i,1)=2;
            end
            for i=fix(2*size/3-1)+2:2:size-1
                channel(1,i)=2;
                channel(i,1)=3;
            end
            for i=2:2:fix(size/3+1)
                channel(size,i)=3;
                channel(i,size)=2;
            end
            for i=fix(size/3+1)+2:2:size-1
                channel(size,i)=2;
                channel(i,size)=3;
            end
        case 10
            channel=ReverseChannel(initialChannel(9)); 
        case 11
            %    3  3  3  2
            % 2             2
            % 2             2
            % 2             2
            % 2             3
            %    3  3  3  3    
            for i=2:2:size-1
                channel(i,1)=2;
                channel(size,i)=3;
            end
            for i=2:2:fix(2*size/3-1)
                channel(1,i)=3;
                channel(i,size)=2;
            end
            for i=fix(2*size/3-1)+2:2:size-1
                channel(1,i)=2;
                channel(i,size)=3;
            end
        case 12
            channel=ReverseChannel(initialChannel(11));  
        case 13
            %    2  2  3  3
            % 2             3
            % 2             3
            % 3             2
            % 3             2
            %    3  3  2  2   
            for i=2:2:(size-1)/2
                channel(1,i)=2;
                channel(i,size)=3;
                channel(size,i)=3;
                channel(i,1)=2;
            end
            for i=(size-1)/2+2:2:size-1
                channel(1,i)=3;
                channel(i,size)=2;
                channel(size,i)=2;
                channel(i,1)=3;
            end  
        case 14
            channel=ReverseChannel(initialChannel(13));  
        case 15
            %    3  3  3  2
            % 2             2
            % 2             2
            % 2             2
            % 2             2
            %    3  3  3  2   
            for i=2:2:size-1
                channel(i,1)=2;
                channel(i,size)=2;
            end
            for i=2:2:fix(2*size/3-1)
                channel(1,i)=3;
                channel(size,i)=3;
            end
            for i=fix(2*size/3-1)+2:2:size-1
                channel(1,i)=2;
                channel(size,i)=2;
            end 
        case 16
            channel=ReverseChannel(initialChannel(15));  
        case 17
            %    3  3  3  3
            % 2             2
            % 2             2
            % 2             2
            % 2             2
            %    2  3  3  2

            for i=2:2:size-1
                channel(1,i)=3;
                channel(i,1)=2;
                channel(i,size)=2;
            end
            for i=2:2:(size-1)/4-1
                channel(size,i)=2;
            end
            for i=(size-1)/4+1:2:3*(size-1)/4-1
                channel(size,i)=3;
            end
            for i=3*(size-1)/4+1:2:size-1
                channel(size,i)=2;
            end
                
        case  18
            %    2  2  2  2
            % 3             3
            % 3             3
            % 3             3
            % 2             2
            %    2  2  2  2

            for i=2:2:size-1
                channel(1,i)=3;
                channel(size,i)=2;
            end
            for i=2:2:3*(size-1)/4-1
                channel(i,1)=3;
                channel(i,size)=3;
            end

            for i=3*(size-1)/4+1:2:size-1
                channel(i,1)=2;
                channel(i,size)=2;
            end
        case 19
            %    3  3  3  3
            % 2             2
            % 2     0  0    2
            % 2     0  0    2
            % 2             2
            %    3  3  3  3            
            
            channel=initialChannel(5);
            for i=45:57
                for j=23:77
                    if (channel(i,j)~=-1)
                        channel(i,j)=0;
                    end
                end
            end
        case 20
            channel=ReverseChannel(initialChannel(19));
        case 21
            %    3  3  2  2
            % 2             3
            % 2     0  0    3
            % 2     0  0    3
            % 2             3
            %    3  3  2  2 
            for i=2:2:size-1
                channel(i,1)=2;
                channel(i,size)=3;
            end
            for i=2:2:(size-1)/2
                channel(1,i)=3;
                channel(size,i)=3;
                channel(1,(size-1)/2+i)=2;
                channel(size,(size-1)/2+i)=2;
            end
            for i=45:57
                for j=23:77
                    if (channel(i,j)~=-1)
                        channel(i,j)=0;
                    end
                end
            end
        case 22 
            channel=ReverseChannel(initialChannel(21));
            
        case 23
            %    2  2  3  3
            % 2             3
            % 2     0  0    3
            % 2     0  0    3
            % 2             3
            %    2  2  3  3 
            for i=2:2:size-1
                channel(i,1)=2;
                channel(i,size)=3;
            end
            for i=2:2:(size-1)/2
                channel(1,i)=2;
                channel(size,i)=2;
                channel(1,(size-1)/2+i)=3;
                channel(size,(size-1)/2+i)=3;
            end
            for i=45:57
                for j=23:77
                    if (channel(i,j)~=-1)
                        channel(i,j)=0;
                    end
                end
            end 
        case 24
            channel=ReverseChannel(initialChannel(23));
        case 25
            %    3  3  3  3
            % 2             2
            % 2     0  0    2
            % 3     0  0    3
            % 3             3
            %    2  2  2  2
            for i=2:2:size-1
                channel(1,i)=3;
                channel(size,i)=2;
            end
            for i=2:2:(size-1)/2
                channel(i,1)=2;
                channel(i,101)=2;
                channel((size-1)/2+i,1)=3;
                channel((size-1)/2+i,101)=3;
            end
            for i=45:57
                for j=23:77
                    if (channel(i,j)~=-1)
                        channel(i,j)=0;
                    end
                end
            end
        case 26
            channel=ReverseChannel(initialChannel(25));
        case 27
            %    2  2  3  3
            % 2      1      3
            % 2     0  0    3
            % 2     0  0    3
            % 2      1      3
            %    2  2  3  3 
            for i=2:2:size-1
                channel(i,1)=2;
                channel(i,size)=3;
            end
            for i=2:2:(size-1)/2
                channel(1,i)=2;
                channel(size,i)=2;
                channel(1,(size-1)/2+i)=3;
                channel(size,(size-1)/2+i)=3;
            end
            for i=45:57
                for j=23:77
                    if (channel(i,j)~=-1)
                        channel(i,j)=0;
                    end
                end
            end  
            
            for i=2:2:30
                channel(i,51)=0;
                channel(size-1-i,51)=0;
            end
            
        case 29
            %
            %design for case 5
            %
            %
            
            channel=ReverseChannel(initialChannel(5));
            for i=100:-2:90
                channel(i,49)=0;
            end
            for i=50:2:64
                channel(89,i)=0;
            end
            for i=84:2:100
                channel(size,i)=3;
            end
        case 31
            %design for case 1
            %    2  2  2  2
            % 3  0        0 3
            % 3             3
            % 3             3
            % 3  0        0 3
            %    2  2  2  2 
            channel=ReverseChannel(initialChannel(5));
            channel=DrawLine(channel,2,2,24,25);
            channel=DrawLine(channel,2,100,35,85);
            
            channel=DrawLine(channel,100,2,84,18);
%             channel=DrawLine(channel,75,27,72,32);            
            channel=DrawLine(channel,100,100,75,85);
          
%             channel=DrawLine(channel,35,35,35,40);
%             channel=DrawLine(channel,35,67,35,62);
%             channel=DrawLine(channel,67,35,67,40);
%             channel=DrawLine(channel,67,67,67,62);            
        case 32
            %
            %design for case 2
            %
            %
            
            channel=ReverseChannel(initialChannel(5));
         
            channel=DrawLine(channel,2,2,24,25);
            channel=DrawLine(channel,2,100,35,85);
            
            channel=DrawLine(channel,100,2,84,18);
%             channel=DrawLine(channel,75,27,72,32);            
            channel=DrawLine(channel,100,100,75,85);


        case 33
            %
            %design for case 3            
             %    2  2  2  2
            % 3  0        0 3
            % 3    000000   3
            % 3    000000   3
            % 3  0        0 3
            %    2  2  2  2 
            channel=initialChannel(6);
            channel=DrawLine(channel,2,2,30,32);
            channel=DrawLine(channel,2,100,34,66);
            
            channel=DrawLine(channel,100,2,74,28);
%             channel=DrawLine(channel,75,27,72,32);
            
            channel=DrawLine(channel,100,100,72,70);

            for i=45:57
                for j=23:77
                    if (channel(i,j)~=-1)
                        channel(i,j)=0;
                    end
                end
            end            
%             channel=DrawLine(channel,35,35,35,40);
%             channel=DrawLine(channel,35,67,35,62);
%             channel=DrawLine(channel,67,35,67,40);
%             channel=DrawLine(channel,67,67,67,62); 
        case 35
            %
            %design for case 5
            %
            %
            
            channel=ReverseChannel(initialChannel(5));
            for i=100:-2:90
                channel(i,49)=0;
            end
%             channel=DrawLine(channel,100,50,90,64);
            for i=50:2:64
                channel(89,i)=0;
            end
            for i=84:2:100
                channel(size,i)=3;
            end            
            for i=84:2:100
                channel(1,i)=3;
            end            


            channel=DrawLine(channel,100,2,92,10);            
            channel=DrawLine(channel,2,22,30,38);
%                channel=DrawLine(channel,2,100,30,70); 
%              channel=DrawLine(channel,2,100,15,87);
%            channel=DrawLine(channel,85,24,70,30);
             channel=DrawLine(channel,25,82,35,70);
        case 45 
            %
            %design for case 5
            %
            %
            
            channel=ReverseChannel(initialChannel(5));
            wall_position=53;
            wall_height  =10;
            wall_length  =10;
            
              channel=DrawLine(channel,100,    wall_position,102-wall_height,    wall_position); 
%               channel=DrawLine(       channel,100,102-wall_position,102-wall_height,102-wall_position); 
              channel=DrawLine(channel,102-wall_height-1,     wall_position+1 ,102-wall_height-1,     wall_position+1+wall_length);
%               channel=DrawLine(       channel,102-wall_height-1,102-(wall_position+1),102-wall_height-1,102-(wall_position+1+wall_length));
            for i=82:2:100
                channel(size,i)=3;
            end            
            for i=82:2:100
                channel(1,i)=3;
            end            


            channel=DrawLine(channel,100,2,92,10);            
            channel=DrawLine(channel,2,22,30,38);
%                channel=DrawLine(channel,2,100,30,70); 
%              channel=DrawLine(channel,2,100,15,87);
%            channel=DrawLine(channel,85,24,70,30);
            channel=DrawLine(channel,25,82,35,70);
%              for i=40:2:50
%                  channel(i,1)=0;
%              end
        case 55 
            %
            %design for case 5
            %
            %
            
            channel=ReverseChannel(initialChannel(5));
            wall_position=53;
            wall_height  =10;
            wall_length  =10;
            
              channel=DrawLine(channel,100,    wall_position,102-wall_height,    wall_position); 
%               channel=DrawLine(       channel,100,102-wall_position,102-wall_height,102-wall_position); 
              channel=DrawLine(channel,102-wall_height-1,     wall_position+1 ,102-wall_height-1,     wall_position+1+wall_length);
%               channel=DrawLine(       channel,102-wall_height-1,102-(wall_position+1),102-wall_height-1,102-(wall_position+1+wall_length));
            for i=82:2:100
                channel(size,i)=3;
            end            
%             for i=82:2:100
%                 channel(1,i)=3;
%             end            


            channel=DrawLine(channel,100,2,92,10);            
            channel=DrawLine(channel,2,22,30,38);
            channel=DrawLine(channel,30,38,30,26);
%                channel=DrawLine(channel,2,100,30,70); 
%              channel=DrawLine(channel,2,100,15,87);
%            channel=DrawLine(channel,85,24,70,30);
            channel=DrawLine(channel,25,82,35,70);
        case 65 
            %
            %design for case 5
            %
            %
            
            channel=ReverseChannel(initialChannel(5));
            wall_position=53;
            wall_height  =10;
            wall_length  =10;
            
              channel=DrawLine(channel,100,    wall_position,102-wall_height,    wall_position); 
%               channel=DrawLine(       channel,100,102-wall_position,102-wall_height,102-wall_position); 
              channel=DrawLine(channel,102-wall_height-1,     wall_position+1 ,102-wall_height-1,     wall_position+1+wall_length);
%               channel=DrawLine(       channel,102-wall_height-1,102-(wall_position+1),102-wall_height-1,102-(wall_position+1+wall_length));
            for i=82:2:100
                channel(size,i)=3;
            end            
%             for i=82:2:100
%                 channel(1,i)=3;
%             end            


%             channel=DrawLine(channel,100,2,92,10); 
            channel=DrawLine(channel,100,2  ,100-24*cos(0.1*pi),2  +24*sin(0.1*pi));              
            channel=DrawLine(channel,2,22,30,38);
            channel=DrawLine(channel,30,38,30,26);
%                channel=DrawLine(channel,2,100,30,70); 
%              channel=DrawLine(channel,2,100,15,87);
%            channel=DrawLine(channel,85,24,70,30);
            channel=DrawLine(channel,25,82,35,70); 
        case 75 
            %
            %design for case 5
            %
            %
            
            channel=ReverseChannel(initialChannel(5));
%             wall_position=53;
%             wall_height  =10;
%             wall_length  =10;
%             
%               channel=DrawLine(channel,100,    wall_position,102-wall_height,    wall_position); 
% %               channel=DrawLine(       channel,100,102-wall_position,102-wall_height,102-wall_position); 
%               channel=DrawLine(channel,102-wall_height-1,     wall_position+1 ,102-wall_height-1,     wall_position+1+wall_length);
% %               channel=DrawLine(       channel,102-wall_height-1,102-(wall_position+1),102-wall_height-1,102-(wall_position+1+wall_length));
            for i=82:2:100
                channel(size,i)=3;
            end            
            for i=82:2:100
                channel(1,i)=3;
            end            


            channel=DrawLine(channel,100,2,92,10);            
            channel=DrawLine(channel,2,22,30,38);
%                channel=DrawLine(channel,2,100,30,70); 
%              channel=DrawLine(channel,2,100,15,87);
%            channel=DrawLine(channel,85,24,70,30);
            channel=DrawLine(channel,25,82,35,70);            
        case 41
            % design for case 1
            %   2 3 3
            % 2       2
            % 2       2
            % 2       2
            %   3 3 3              
            channel=initialChannel(5);
            channel=DrawLine(channel,100,2  ,100-30*cos(0.25*pi),2  +30*sin(0.25*pi));     
            channel=DrawLine(channel,2  ,2  ,2  +25*cos(0.25*pi),2  +25*sin(0.25 *pi));
            channel=DrawLine(channel,100,100,100-20*cos(0.35*pi),100-20*sin(0.35*pi));

            channel=DrawLine(channel,2  ,100,2  +35*cos(0.25*pi),100-35*sin(0.25*pi));            
            for i=2:2:28
                channel(size,i)=2;
            end
            for i=100:-2:96
                channel(i,29)=0;
            end
             
%             for i=100:-2:84
%                 channel(i,size)=3;
%             end
%             for i=90:100
%                 channel(84,i)=0;
%             end
%             channel=DrawLine(channel,100,2  ,100-25*cos(0.25*pi),2  +25*sin(0.25*pi));     
%             channel=DrawLine(channel,2  ,2  ,2  +25*cos(0.25*pi),2  +25*sin(0.25 *pi));
%             channel=DrawLine(channel,100,100,100-25*cos(0.25*pi),100-25*sin(0.25*pi));   
%             channel=DrawLine(channel,2  ,100,2  +25*cos(0.25*pi),100-25*sin(0.25*pi));  
        case 42
            % design for case 2

            channel=ReverseChannel(initialChannel(5));
            channel=DrawFourLine(channel,0.21,28,0.28,35,0.14,36,0.14,36);
            
        case 51
            % design for case 1
            %   2 3 3
            % 2       2
            % 2       2
            % 2       2
            %   3 3 3              
            channel=initialChannel(5);
            channel=DrawLine(channel,100,2  ,100-35*cos(0.25*pi),2  +35*sin(0.25*pi));     
            channel=DrawLine(channel,2  ,2  ,2  +35*cos(0.25*pi),2  +35*sin(0.25 *pi));
            channel=DrawLine(channel,100,100,100-25*cos(0.3*pi),100-25*sin(0.3*pi));

            channel=DrawLine(channel,2  ,100,2  +30*cos(0.3*pi),100-30*sin(0.3*pi));            
            for i=2:2:28
                channel(size,i)=2;
            end
            for i=100:-2:94
                channel(i,29)=0;
            end
            
            for i=2:2:28
                channel(1,i)=2;
            end
            for i=2:2:8
                channel(i,29)=0;
            end            
        case 52
            channel=ReverseChannel(initialChannel(5));
            channel=DrawLine(channel,100,2  ,100-30*cos(0.28*pi),2  +30*sin(0.28*pi));     
            channel=DrawLine(channel,2  ,2  ,2  +39*cos(0.28*pi),2  +39*sin(0.28*pi));
            channel=DrawLine(channel,100,100,100-36*cos(0.14*pi),100-36*sin(0.14*pi));   
            channel=DrawLine(channel,2  ,100,2  +36*cos(0.14*pi),100-36*sin(0.14*pi));
        case 62
            channel=ReverseChannel(initialChannel(5));
            channel=DrawLine(channel,100,2  ,100-30*cos(0.28*pi),2  +30*sin(0.28*pi));     
            channel=DrawLine(channel,2  ,2  ,2  +39*cos(0.28*pi),2  +39*sin(0.28*pi));
            channel=DrawLine(channel,100,100,100-36*cos(0.14*pi),100-36*sin(0.14*pi));   
            channel=DrawLine(channel,2  ,100,2  +38*cos(0.21*pi),100-38*sin(0.21*pi));            
%             channel=DrawLine(channel,round(2  +36*cos(0.14*pi)),round(100-36*sin(0.14*pi)),round(2  +36*cos(0.14*pi)),round(100-36*sin(0.14*pi))+6);
        case 54
            % design for case 4-bottom
            channel=ReverseChannel(initialChannel(5));
            channel=DrawLine(channel,100,2  ,100-31*cos(0.24*pi),2  +31*sin(0.24*pi));     
            channel=DrawLine(channel,2  ,2  ,2  +40*cos(0.25*pi),2  +40*sin(0.25*pi));
            channel=DrawLine(channel,100,100,100-36*cos(0.14*pi),100-36*sin(0.14*pi));   
            channel=DrawLine(channel,2  ,100,2  +36*cos(0.14*pi),100-36*sin(0.14*pi));
        case 58
            % design for case 4-bottom
            channel=ReverseChannel(initialChannel(5));
            channel=DrawLine(channel,100,2  ,100-33*cos(0.26*pi),2  +33*sin(0.26*pi));     
            channel=DrawLine(channel,2  ,2  ,2  +41*cos(0.24*pi),2  +41*sin(0.24*pi));
            channel=DrawLine(channel,100,100,100-36*cos(0.14*pi),100-36*sin(0.14*pi));   
            channel=DrawLine(channel,2  ,100,2  +34*cos(0.15*pi),100-34*sin(0.15*pi));
        case 64
            % design for case 4-bottom 0.006w
            channel=ReverseChannel(initialChannel(5));
            channel=DrawLine(channel,100,2  ,100-33*cos(0.26*pi),2  +33*sin(0.26*pi));     
            channel=DrawLine(channel,2  ,2  ,2  +40*cos(0.26*pi),2  +40*sin(0.26*pi));
            channel=DrawLine(channel,100,100,100-38*cos(0.14*pi),100-38*sin(0.14*pi));   
            channel=DrawLine(channel,2  ,100,2  +34*cos(0.15*pi),100-34*sin(0.15*pi)); 
        case 68
            % design for case 4-bottom 0.0062w
            channel=ReverseChannel(initialChannel(5));
            channel=DrawLine(channel,100,2  ,100-33*cos(0.25*pi),2  +33*sin(0.25*pi));     
            channel=DrawLine(channel,2  ,2  ,2  +40*cos(0.25*pi),2  +40*sin(0.25*pi));
            channel=DrawLine(channel,100,100,100-38*cos(0.14*pi),100-38*sin(0.14*pi));   
            channel=DrawLine(channel,2  ,100,2  +36*cos(0.16*pi),100-36*sin(0.16*pi));
        case 74
            % design for case 4-bottom 0.0063w
            % no filling 
            channel=ReverseChannel(initialChannel(5));
            channel=DrawLine(channel,100,2  ,100-33*cos(0.25*pi),2  +33*sin(0.25*pi));     
            channel=DrawLine(channel,2  ,2  ,2  +40*cos(0.25*pi),2  +40*sin(0.25*pi));
            channel=DrawLine(channel,100,100,100-36*cos(0.14*pi),100-36*sin(0.14*pi));   
            channel=DrawLine(channel,2  ,100,2  +36*cos(0.16*pi),100-36*sin(0.16*pi));
        case 78
            % design for case 4-bottom 0.006w
            channel=ReverseChannel(initialChannel(5));
            channel=DrawLine(channel,100,2  ,100-33*cos(0.25*pi),2  +33*sin(0.25*pi));     
            channel=DrawLine(channel,2  ,2  ,2  +40*cos(0.25*pi),2  +40*sin(0.25*pi));
            channel=DrawLine(channel,100,100,100-38*cos(0.14*pi),100-38*sin(0.14*pi));   
%             channel=DrawLine(channel,2  ,100,2  +41*cos(0.205*pi),100-41*sin(0.205*pi));
            channel=DrawHook(channel,4,0.205,41,2,0);
        case 46
            % design for case 1
            channel=initialChannel(5);
            for i=2:2:50
                channel(size,i)=2;
            end
            for i=50:2:100
                channel(i,1)=3;
            end
            for i=2:2:20
                channel(49,i)=0;
            end
            channel=DrawLine(channel,2  ,100,2  +25*cos(0.25*pi),100-25*sin(0.25*pi)); 
            channel=DrawLine(channel,2  ,2  ,2  +25*cos(0.25*pi),2  +25*sin(0.25 *pi));
            channel=DrawLine(channel,100,100,100-20*cos(0.35*pi),100-20*sin(0.35*pi));
        case 56
             % design for case 1
            %   2 3 3
            % 2       2
            % 2       2
            % 2       2
            %   3 3 3              
            channel=initialChannel(5);
            channel=DrawLine(channel,100,2  ,100-35*cos(0.1*pi),2  +35*sin(0.1*pi));     
            channel=DrawLine(channel,2  ,2  ,2  +30*cos(0.25*pi),2  +30*sin(0.25*pi));
            channel=DrawLine(channel,100,100,100-25*cos(0.3 *pi),100-25*sin(0.3 *pi));

            channel=DrawLine(channel,2  ,100,2  +30*cos(0.1*pi),100-30*sin(0.1*pi));            
            for i=2:2:28
                channel(size,i)=2;
            end
            for i=100:-2:92
                channel(i,29)=0;
            end
            for i=100:-2:80
                channel(1,i)=2;
            end           
            for i=2:2:8
                channel(i,79)=0;
            end            
        case 61
             % design for case 1
            %   2 3 3
            % 2       2
            % 2       2
            % 2       2
            %   3 3 3              
            channel=initialChannel(5);
%             channel=DrawLine(channel,100,2  ,100-25*cos(0.25*pi),2  +25*sin(0.25*pi));     
            channel=DrawLine(channel,2  ,2  ,2  +25*cos(0.25*pi),2  +25*sin(0.25 *pi));
            channel=DrawLine(channel,100,100,100-20*cos(0.35*pi),100-20*sin(0.35*pi));

            channel=DrawLine(channel,2  ,100,2  +35*cos(0.25*pi),100-35*sin(0.25*pi));            
            for i=2:2:28
                channel(size,i)=2;
            end
            for i=100:-2:96
                channel(i,29)=0;
            end 
        case 66
            % design for case 1
            %   2 3 3
            % 2       2
            % 2       2
            % 2       2
            %   3 3 3              
            channel=initialChannel(5);
            channel=DrawLine(channel,100,2  ,100-30*cos(0.1*pi),2  +30*sin(0.1*pi));     
            channel=DrawLine(channel,2  ,2  ,2  +25*cos(0.25*pi),2  +25*sin(0.25*pi));
            channel=DrawLine(channel,100,100,100-26*cos(0.27*pi),100-26*sin(0.27*pi));

            channel=DrawLine(channel,2  ,100,2  +34*cos(0.28*pi),100-34*sin(0.28*pi));            
            for i=2:2:26
                channel(size,i)=2;
            end
            for i=100:-2:94
                channel(i,27)=0;
            end
        case 71
             % design for case 1
            %   2 3 3
            % 2       2
            % 2       2
            % 2       2
            %   3 3 3              
            channel=initialChannel(5);
            channel=DrawLine(channel,100,2  ,100-30*cos(0.08*pi),2  +30*sin(0.08*pi));     
            channel=DrawLine(channel,2  ,2  ,2  +27*cos(0.25*pi),2  +27*sin(0.25*pi));
            channel=DrawLine(channel,100,100,100-26*cos(0.32*pi),100-26*sin(0.32*pi));

            channel=DrawLine(channel,2  ,100,2  +32*cos(0.28*pi),100-32*sin(0.28*pi));            
            for i=2:2:26
                channel(size,i)=2;
            end
            for i=100:-2:94
                channel(i,27)=0;
            end
            %% fill the output
            for i=80:2:100
                channel(size,i)=0;
            end
%             for i=16:2:26
%                 channel(1,i)=0;
%             end
            for i=72:2:86
                channel(1,i)=0;
            end
        case 76
             % design for case 1
            %   2 3 3
            % 2       2
            % 2       2
            % 2       2
            %   3 3 3              
            channel=initialChannel(5);
            channel=DrawLine(channel,100,2  ,100-30*cos(0.08*pi),2  +30*sin(0.08*pi));     
            channel=DrawLine(channel,2  ,2  ,2  +27*cos(0.25*pi),2  +27*sin(0.25*pi));
            channel=DrawLine(channel,100,100,100-28*cos(0.32*pi),100-28*sin(0.32*pi));
            channel=DrawLine(channel,2  ,100,2  +32*cos(0.28*pi),100-32*sin(0.28*pi));            
            for i=2:2:26
                channel(size,i)=2;
            end
            for i=100:-2:94
                channel(i,27)=0;
            end
            
            channel=DrawLine(channel,92,28,92,36);
            
            channel=DrawLine(channel,2  +round(32*cos(0.28*pi)),100-round(32*sin(0.28*pi))  ,2  +round(32*cos(0.28*pi))-12,100-round(32*sin(0.28*pi))  ); 
            channel=DrawLine(channel,2  +round(27*cos(0.25*pi)),2  +round(27*sin(0.25*pi))+2,2  +round(27*cos(0.25*pi))-12,2  +round(27*sin(0.25*pi))+2);
            channel=DrawLine(channel,100-round(28*cos(0.32*pi)),100-round(28*sin(0.32*pi))-1,100-round(28*cos(0.32*pi))+8 ,100-round(28*sin(0.32*pi))-1);            
            channel(6,57)=1;
        case 81
             % design for case 1
             % the part 2 and 4 are optimized
            %   2 3 3
            % 2       2
            % 2       2
            % 2       2
            %   3 3 3              
            channel=initialChannel(5);
            channel=DrawLine(channel,100,2  ,100-30*cos(0.08*pi),2  +30*sin(0.08*pi));     
            channel=DrawLine(channel,2  ,2  ,2  +30*cos(0.28*pi),2  +30*sin(0.28*pi));
            channel=DrawLine(channel,100,100,100-28*cos(0.32*pi),100-28*sin(0.32*pi));
            channel=DrawLine(channel,2  ,100,2  +33*cos(0.29*pi),100-33*sin(0.29*pi));            
            for i=2:2:26
                channel(size,i)=2;
            end
            for i=100:-2:94
                channel(i,27)=0;
            end
            
            channel=DrawLine(channel,92,28,92,36);
            
            channel=DrawLine(channel,2  +round(32*cos(0.28*pi)),100-round(32*sin(0.28*pi))  ,2  +round(32*cos(0.28*pi))-2,100-round(32*sin(0.28*pi))  ); 
            channel=DrawLine(channel,2  +round(27*cos(0.25*pi)),2  +round(27*sin(0.25*pi))+2,2  +round(27*cos(0.25*pi))-6,2  +round(27*sin(0.25*pi))+2);
            channel=DrawLine(channel,100-round(28*cos(0.32*pi)),100-round(28*sin(0.32*pi))-1,100-round(28*cos(0.32*pi))+8 ,100-round(28*sin(0.32*pi))-1);
        case 86
             % design for case 1
            %   2 3 3
            % 2       2
            % 2       2
            % 2       2
            %   3 3 3              
            channel=initialChannel(6);
            channel=DrawLine(channel,100,2  ,100-30*cos(0.16*pi),2  +30*sin(0.16*pi));     
            channel=DrawLine(channel,2  ,2  ,2  +35*cos(0.19*pi),2  +35*sin(0.19*pi));
            channel=DrawLine(channel,100,100,100-36*cos(0.09*pi),100-36*sin(0.09*pi));
            channel=DrawLine(channel,2  ,100,2  +35*cos(0.12*pi),100-35*sin(0.12*pi));
        case 91
             % design for case 1
            %   2 3 3
            % 2       2
            % 2       2
            % 2       2
            %   3 3 3              
            channel=initialChannel(6);
            channel=DrawLine(channel,100,2  ,100-30*cos(0.18*pi),2  +30*sin(0.18*pi));     
            channel=DrawLine(channel,2  ,2  ,2  +34*cos(0.17*pi),2  +34*sin(0.17*pi));
            channel=DrawLine(channel,100,100,100-38*cos(0.09*pi),100-38*sin(0.09*pi));
            channel=DrawLine(channel,2  ,100,2  +34*cos(0.12*pi),100-34*sin(0.12*pi));
        case 96
             % design for case 1,0.0034w
            %   2 3 3
            % 2       2
            % 2       2
            % 2       2
            %   3 3 3              
            channel=initialChannel(6);
            channel=DrawLine(channel,100,2  ,100-29*cos(0.18*pi),2  +29*sin(0.18*pi));     
            channel=DrawLine(channel,2  ,2  ,2  +35*cos(0.15*pi),2  +35*sin(0.15*pi));
            channel=DrawLine(channel,100,100,100-38*cos(0.09*pi),100-38*sin(0.09*pi));
            channel=DrawLine(channel,2  ,100,2  +35*cos(0.11*pi),100-35*sin(0.11*pi));            
        case 100
            channel=ReverseChannel(initialChannel(5));
            channel=DrawLine(channel,100,2  ,100-48*cos(0.26*pi),2  +48*sin(0.26*pi));     
            channel=DrawLine(channel,2  ,2  ,2  +48*cos(0.26*pi) ,2 +48*sin(0.26*pi));
            channel=DrawLine(channel,100,100,100-48*cos(0.26*pi),100-48*sin(0.26*pi));   
            channel=DrawLine(channel,2  ,100,2  +48*cos(0.26*pi),100-48*sin(0.26*pi));
%             figure(1)
%             contourf(channel);
%             channel=RemoveLine(channel,100,2  ,100-27*cos(0.23*pi),2  +27*sin(0.23*pi));     
%             channel=RemoveLine(channel,2  ,2  ,2  +34*cos(0.3*pi) ,2  +34*sin(0.3 *pi));
%             channel=RemoveLine(channel,100,100,100-36*cos(0.14*pi),100-36*sin(0.14*pi));   
%             channel=RemoveLine(channel,2  ,100,2  +36*cos(0.14*pi),100-36*sin(0.14*pi)); 
%             figure(2)
%             contourf(channel);
        case 103
            %
            %design for case 3            
             %    2  2  2  2
            % 3  0        0 3
            % 3    000000   3
            % 3    000000   3
            % 3  0        0 3
            %    2  2  2  2 
            channel=initialChannel(6);
            channel=DrawLine(channel,100,2  ,100-40*cos(0.27 *pi),2  +40*sin(0.27 *pi));     
            channel=DrawLine(channel,2  ,2  ,2  +42*cos(0.265*pi),2  +42*sin(0.265*pi));
            channel=DrawLine(channel,100,100,100-43*cos(0.27 *pi),100-43*sin(0.27 *pi));   
            channel=DrawLine(channel,2  ,100,2  +44*cos(0.26 *pi),100-44*sin(0.26 *pi));

%             channel=DrawLine(channel,round(100-40*cos(0.27 *pi)),round(2  +40*sin(0.27 *pi)),round(100-40*cos(0.27 *pi)),round(2  +40*sin(0.27 *pi))-8);     
%             channel=DrawLine(channel,round(2  +42*cos(0.265*pi)),round(2  +42*sin(0.265*pi)),round(2  +42*cos(0.265*pi)),round(2  +42*sin(0.265*pi))-8);
%             channel=DrawLine(channel,round(100-43*cos(0.27 *pi)),round(100-43*sin(0.27 *pi)),round(100-43*cos(0.27 *pi)),round(100-43*sin(0.27 *pi))+8);   
%             channel=DrawLine(channel,round(2  +44*cos(0.26 *pi)),round(100-44*sin(0.26 *pi)),round(2  +44*cos(0.26 *pi)),round(100-44*sin(0.26 *pi))+8);            
            for i=45:57
                for j=23:77
                    if (channel(i,j)~=-1)
                        channel(i,j)=0;
                    end
                end
            end
        case 173
             %
            %design for case 3            
             %    2  2  2  2
            % 3  0        0 3
            % 3    000000   3
            % 3    000000   3
            % 3  0        0 3
            %    2  2  2  2 
            channel=initialChannel(6);
            channel=DrawLine(channel,100,2  ,100-44*cos(0.275*pi),2  +44*sin(0.275*pi));     
            channel=DrawLine(channel,2  ,2  ,2  +44*cos(0.275*pi),2  +44*sin(0.275*pi));
            channel=DrawLine(channel,100,100,100-45*cos(0.265*pi),100-45*sin(0.265*pi));   
            channel=DrawLine(channel,2  ,100,2  +44*cos(0.26 *pi),100-44*sin(0.26 *pi));

%             channel=DrawLine(channel,round(100-40*cos(0.27 *pi)),round(2  +40*sin(0.27 *pi)),round(100-40*cos(0.27 *pi)),round(2  +40*sin(0.27 *pi))-8);     
%             channel=DrawLine(channel,round(2  +42*cos(0.265*pi)),round(2  +42*sin(0.265*pi)),round(2  +42*cos(0.265*pi)),round(2  +42*sin(0.265*pi))-8);
%             channel=DrawLine(channel,round(100-43*cos(0.27 *pi)),round(100-43*sin(0.27 *pi)),round(100-43*cos(0.27 *pi)),round(100-43*sin(0.27 *pi))+8);   
%             channel=DrawLine(channel,round(2  +44*cos(0.26 *pi)),round(100-44*sin(0.26 *pi)),round(2  +44*cos(0.26 *pi)),round(100-44*sin(0.26 *pi))+8);            
            for i=45:57
                for j=23:77
                    if (channel(i,j)~=-1)
                        channel(i,j)=0;
                    end
                end
            end           
        case 193
             %
            %design for case 3            
             %    2  2  2  2
            % 3  0        0 3
            % 3    000000   3
            % 3    000000   3
            % 3  0        0 3
            %    2  2  2  2 
            channel=initialChannel(6);
            channel=DrawLine(channel,100,2  ,100-45*cos(0.275*pi),2  +45*sin(0.275*pi));     
            channel=DrawLine(channel,2  ,2  ,2  +46*cos(0.255*pi),2  +46*sin(0.255*pi));
            channel=DrawLine(channel,100,100,100-46*cos(0.255*pi),100-46*sin(0.255*pi));   
            channel=DrawLine(channel,2  ,100,2  +46*cos(0.255*pi),100-46*sin(0.255*pi));

%             channel=DrawLine(channel,round(100-40*cos(0.27 *pi)),round(2  +40*sin(0.27 *pi)),round(100-40*cos(0.27 *pi)),round(2  +40*sin(0.27 *pi))-8);     
%             channel=DrawLine(channel,round(2  +42*cos(0.265*pi)),round(2  +42*sin(0.265*pi)),round(2  +42*cos(0.265*pi)),round(2  +42*sin(0.265*pi))-8);
%             channel=DrawLine(channel,round(100-43*cos(0.27 *pi)),round(100-43*sin(0.27 *pi)),round(100-43*cos(0.27 *pi)),round(100-43*sin(0.27 *pi))+8);   
%             channel=DrawLine(channel,round(2  +44*cos(0.26 *pi)),round(100-44*sin(0.26 *pi)),round(2  +44*cos(0.26 *pi)),round(100-44*sin(0.26 *pi))+8);            
            for i=45:57
                for j=23:77
                    if (channel(i,j)~=-1)
                        channel(i,j)=0;
                    end
                end
            end   
            for i=81:101
                for j=43:61
                    if (channel(i,j)~=-1)
                        channel(i,j)=0;
                    end
                end
            end   
            for i=1:21
                for j=41:59
                    if (channel(i,j)~=-1)
                        channel(i,j)=0;
                    end
                end
            end            
            channel(1,39)=0;
            channel(1,61)=0;
            channel(101,42)=0;
            channel(101,62)=0;
        case 500
            channel=initialChannel(6);
            for i=2:2:100
                channel(i,51)=0;
            end
            for i=2:2:100
                channel(51,i)=0;
            end
            for i=2:2:50
                channel(i,1)=3;
                channel(101,i)=3;
            end
            for i=52:2:100
                channel(i,1)=2;
            end
            for i=2:2:18
                for j=61:2:79
                    channel(i,j)=0;
                end
            end
            for i=82:2:100
                for j=61:2:87
                    channel(i,j)=0;
                end
            end 

            for i=62:2:80
                for j=43:2:59
                    channel(i,j)=0;
                end
            end     
            for i=24:2:40
                for j=43:2:59
                    channel(i,j)=0;
                end
            end 
            for i=43:2:57
                for j=24:2:40
                    channel(i,j)=0;
                end
            end
            for i=43:2:57
                for j=60:2:80
                    channel(i,j)=0;
                end
            end 
            
            for i=1:19
                for j=43:59
                    if channel(i,j)~=-1
                        channel(i,j)=0;
                    end
                end
            end
            
             for i=45:61
                for j=1:17
                    if channel(i,j)~=-1
                        channel(i,j)=0;
                    end
                end
            end           
            

            for i=69:2:99
                for j=2:2:101-i
                    channel(i,j)=0;
                end
            end
            
            for i=81:2:99
                for j=2:2:101-i
                    channel(102-j,102-i)=0;
                end
            end            
            channel=TurnoverMatrix(channel);
        case 501
            channel=initialChannel(6);
            for i=2:2:100
                channel(i,51)=0;
            end
            for i=2:2:100
                channel(51,i)=0;
            end
            for i=2:2:50
                channel(i,1)=3;
                channel(101,i)=3;
            end
            for i=52:2:100
                channel(i,1)=2;
            end
            for i=2:2:18
                for j=61:2:79
                    channel(i,j)=0;
                end
            end
            for i=82:2:100
                for j=61:2:87
                    channel(i,j)=0;
                end
            end 

            for i=62:2:80
                for j=43:2:59
                    channel(i,j)=0;
                end
            end     
            for i=24:2:40
                for j=43:2:59
                    channel(i,j)=0;
                end
            end 
            for i=43:2:57
                for j=24:2:40
                    channel(i,j)=0;
                end
            end
            for i=43:2:57
                for j=60:2:80
                    channel(i,j)=0;
                end
            end 
            
            for i=21:2:41
                for j=2:2:20
                    channel(i,j)=0;
                end
            end  
            
             for i=2:2:18
                for j=21:2:39
                    channel(i,j)=0;
                end
             end 
            
            for i=1:19
                for j=45:57
                    if channel(i,j)~=-1
                        channel(i,j)=0;
                    end
                end
            end
            
             for i=45:61
                for j=1:17
                    if channel(i,j)~=-1
                        channel(i,j)=0;
                    end
                end
             end  
            
            for i=87:101
                for j=45:57
                    if channel(i,j)~=-1
                        channel(i,j)=0;
                    end
                end
            end            

            for i=69:2:99
                for j=2:2:101-i
                    channel(i,j)=0;
                end
            end
            
            for i=81:2:99
                for j=2:2:101-i
                    channel(102-j,102-i)=0;
                end
            end 
            
            
            channel=TurnoverMatrix(channel);  
            for i=80:2:100
                channel(size,i)=0;
            end
            for i=2:2:18
                channel(size,i)=0;
            end            
            for i=90:2:100
                channel(1,i)=0;
            end  
            
        case 502
            channel=initialChannel(6);
            for i=2:2:100
                channel(i,51)=0;
            end
            for i=2:2:100
                channel(51,i)=0;
            end
            for i=2:2:50
                channel(i,1)=3;
                channel(101,i)=3;
            end
            for i=52:2:100
                channel(i,1)=2;
            end
            for i=2:2:18
                for j=61:2:79
                    channel(i,j)=0;
                end
            end
            for i=82:2:100
                for j=61:2:87
                    channel(i,j)=0;
                end
            end 

            for i=62:2:80
                for j=43:2:49
                    channel(i,j)=0;
                end
            end     
            
            for i=62:2:78
                for j=51:2:59
                    channel(i,j)=0;
                end
            end 
            
            for i=24:2:40
                for j=43:2:49
                    channel(i,j)=0;
                end
            end 

            for i=26:2:40
                for j=51:2:59
                    channel(i,j)=0;
                end
            end             
            
            for i=43:2:49
                for j=24:2:40
                    channel(i,j)=0;
                end
            end
            
            for i=51:2:57
                for j=28:2:40
                    channel(i,j)=0;
                end
            end
            
            for i=43:2:57
                for j=62:2:80
                    channel(i,j)=0;
                end
            end 
            
            for i=21:2:41
                for j=2:2:20
                    channel(i,j)=0;
                end
            end  
            
             for i=2:2:18
                for j=21:2:39
                    channel(i,j)=0;
                end
             end 
            
            for i=1:19
                for j=45:57
                    if channel(i,j)~=-1
                        channel(i,j)=0;
                    end
                end
            end
            
             for i=47:61
                for j=1:17
                    if channel(i,j)~=-1
                        channel(i,j)=0;
                    end
                end
             end  
            
            for i=87:101
                for j=45:57
                    if channel(i,j)~=-1
                        channel(i,j)=0;
                    end
                end
            end            

            for i=83:101
                for j=51:57
                    if channel(i,j)~=-1
                        channel(i,j)=0;
                    end
                end
            end
            
            for i=73:2:99
                for j=2:2:101-i
                    channel(i,j)=0;
                end
            end
            
%             for i=81:2:99
%                 for j=2:2:101-i
%                     channel(102-j,102-i)=0;
%                 end
%             end 
            
            
            channel=TurnoverMatrix(channel);  
            for i=80:2:100
                channel(size,i)=0;
            end
            for i=2:2:18
                channel(size,i)=0;
            end            
            for i=88:2:100
                channel(1,i)=0;
            end     
        case 503
            channel=initialChannel(6);
            for i=2:2:100
                channel(i,51)=0;
            end
            for i=2:2:100
                channel(51,i)=0;
            end
            for i=2:2:50
                channel(i,1)=3;
                channel(101,i)=3;
            end
            for i=52:2:100
                channel(i,1)=2;
            end
            for i=2:2:18
                for j=61:2:79
                    channel(i,j)=0;
                end
            end
            for i=82:2:100
                for j=61:2:87
                    channel(i,j)=0;
                end
            end 

            for i=62:2:80
                for j=43:2:49
                    channel(i,j)=0;
                end
            end     
            
            for i=62:2:78
                for j=51:2:59
                    channel(i,j)=0;
                end
            end 
            
            for i=24:2:40
                for j=43:2:49
                    channel(i,j)=0;
                end
            end 

            for i=26:2:40
                for j=51:2:59
                    channel(i,j)=0;
                end
            end             
            
            for i=43:2:49
                for j=24:2:40
                    channel(i,j)=0;
                end
            end
            
            for i=51:2:57
                for j=28:2:40
                    channel(i,j)=0;
                end
            end
            
            for i=43:2:57
                for j=62:2:80
                    channel(i,j)=0;
                end
            end 
            
            for i=21:2:41
                for j=2:2:20
                    channel(i,j)=0;
                end
            end  
            
             for i=2:2:18
                for j=21:2:39
                    channel(i,j)=0;
                end
             end 
            
            for i=1:19
                for j=45:57
                    if channel(i,j)~=-1
                        channel(i,j)=0;
                    end
                end
            end
            
             for i=47:61
                for j=1:17
                    if channel(i,j)~=-1
                        channel(i,j)=0;
                    end
                end
             end  
            
            for i=87:101
                for j=45:57
                    if channel(i,j)~=-1
                        channel(i,j)=0;
                    end
                end
            end            

            for i=83:101
                for j=51:57
                    if channel(i,j)~=-1
                        channel(i,j)=0;
                    end
                end
            end
            
            for i=73:2:99
                for j=2:2:101-i
                    channel(i,j)=0;
                end
            end
            
%             for i=81:2:99
%                 for j=2:2:101-i
%                     channel(102-j,102-i)=0;
%                 end
%             end 
            
            
            channel=TurnoverMatrix(channel);  
            for i=80:2:100
                channel(size,i)=0;
            end
            for i=2:2:18
                channel(size,i)=0;
            end            
            for i=88:2:100
                channel(1,i)=0;
            end 
            
            for i=2:4
                for j=68:72
                    if channel(i,j)~=-1
                        channel(i,j)=1;
                    end
                end
            end
        %% new pattern of IO
        case 201     
             %   2  2   3  3
            % 3       0      2
            % 3       0      2
            %    0 0 0 0 0 0
            % 2       0      3
            % 2       0      3
            %    3  3   2  2  
            channel=initialChannel(3);
            for i=2:2:(size-1)/2
                channel(1,i)=2;    channel(1,(size-1)/2+i)=3;
                channel(i,1)=3;    channel((size-1)/2+i,1)=2;
                channel(size,i)=3; channel(size,(size-1)/2+i)=2;
                channel(i,size)=2; channel((size-1)/2+i,size)=3;
            end
            
            for i=2:2:size-1
                channel(i,(size+1)/2)=0;
                channel((size+1)/2,i)=0;
            end
            
        case 202
             %   3  3   2  2
            % 2       0      3
            % 2       0      3
            %    0 0 0 0 0 0
            % 3       0      2
            % 3       0      2
            %    2  2   3  3        
            channel=initialChannel(3);
            for i=2:2:(size-1)/2
                channel(1,i)=3;    channel(1,(size-1)/2+i)=2;
                channel(i,1)=2;    channel((size-1)/2+i,1)=3;
                channel(size,i)=2; channel(size,(size-1)/2+i)=3;
                channel(i,size)=3; channel((size-1)/2+i,size)=2;
            end
            
            for i=2:2:size-1
                channel(i,(size+1)/2)=0;
                channel((size+1)/2,i)=0;
            end

        case 203
             %   3  3   3  3
            % 2       0      2
            % 2       0      2
            %    0 0 0 0 0 0
            % 2       0      3
            % 2       0      3
            %    3  3   2  2  
            channel=initialChannel(3);
            for i=2:2:(size-1)/2
                channel(1,i)=3;    channel(1,(size-1)/2+i)=3;
                channel(i,1)=2;    channel((size-1)/2+i,1)=2;
                channel(size,i)=3; channel(size,(size-1)/2+i)=2;
                channel(i,size)=2; channel((size-1)/2+i,size)=3;
            end
            
            for i=2:2:size-1
                channel(i,(size+1)/2)=0;
                channel((size+1)/2,i)=0;
            end

        case 204
             %   2  2   2  2
            % 3       0      3
            % 3       0      3
            %    0 0 0 0 0 0
            % 3       0      2
            % 3       0      2
            %    2  2   3  3        
            channel=initialChannel(3);
            for i=2:2:(size-1)/2
                channel(1,i)=2;    channel(1,(size-1)/2+i)=2;
                channel(i,1)=3;    channel((size-1)/2+i,1)=3;
                channel(size,i)=2; channel(size,(size-1)/2+i)=3;
                channel(i,size)=3; channel((size-1)/2+i,size)=2;
            end
            
            for i=2:2:size-1
                channel(i,(size+1)/2)=0;
                channel((size+1)/2,i)=0;
            end     
            
        case 205     
             %   2  2   3  3
            % 3       0      2
            % 3       0      2
            %    0 0 0 0 0 0
            % 3       0      3
            % 3       0      3
            %    2  2   2  2  
            channel=initialChannel(3);
            for i=2:2:(size-1)/2
                channel(1,i)=2;    channel(1,(size-1)/2+i)=3;
                channel(i,1)=3;    channel((size-1)/2+i,1)=3;
                channel(size,i)=2; channel(size,(size-1)/2+i)=2;
                channel(i,size)=2; channel((size-1)/2+i,size)=3;
            end
            
            for i=2:2:size-1
                channel(i,(size+1)/2)=0;
                channel((size+1)/2,i)=0;
            end
            
        case 206
             %   3  3   2  2
            % 2       0      3
            % 2       0      3
            %    0 0 0 0 0 0
            % 2       0      2
            % 2       0      2
            %    3  3   3  3        
            channel=initialChannel(3);
            for i=2:2:(size-1)/2
                channel(1,i)=3;    channel(1,(size-1)/2+i)=2;
                channel(i,1)=2;    channel((size-1)/2+i,1)=2;
                channel(size,i)=3; channel(size,(size-1)/2+i)=3;
                channel(i,size)=3; channel((size-1)/2+i,size)=2;
            end
            
            for i=2:2:size-1
                channel(i,(size+1)/2)=0;
                channel((size+1)/2,i)=0;
            end

        case 207     
             %   2  2   2  2
            % 3       0      3
            % 3       0      3
            %    0 0 0 0 0 0
            % 2       0      3
            % 2       0      3
            %    3  3   2  2  
            channel=initialChannel(3);
            for i=2:2:(size-1)/2
                channel(1,i)=2;    channel(1,(size-1)/2+i)=2;
                channel(i,1)=3;    channel((size-1)/2+i,1)=2;
                channel(size,i)=3; channel(size,(size-1)/2+i)=2;
                channel(i,size)=3; channel((size-1)/2+i,size)=3;
            end
            
            for i=2:2:size-1
                channel(i,(size+1)/2)=0;
                channel((size+1)/2,i)=0;
            end
            
        case 208
             %   3  3   2  2
            % 2       0      3
            % 2       0      3
            %    0 0 0 0 0 0
            % 3       0      2
            % 3       0      2
            %    2  2   3  3        
            channel=initialChannel(3);
            for i=2:2:(size-1)/2
                channel(1,i)=3;    channel(1,(size-1)/2+i)=3;
                channel(i,1)=2;    channel((size-1)/2+i,1)=3;
                channel(size,i)=2; channel(size,(size-1)/2+i)=3;
                channel(i,size)=2; channel((size-1)/2+i,size)=2;
            end
            
            for i=2:2:size-1
                channel(i,(size+1)/2)=0;
                channel((size+1)/2,i)=0;
            end

        case 209     
             %   2  2   3  3
            % 3       0      2
            % 3       0      2
            %    0 0 0 0 0 0
            % 2       0      2
            % 2       0      2
            %    3  3   3  3  
            channel=initialChannel(3);
            for i=2:2:(size-1)/2
                channel(1,i)=2;    channel(1,(size-1)/2+i)=3;
                channel(i,1)=3;    channel((size-1)/2+i,1)=2;
                channel(size,i)=3; channel(size,(size-1)/2+i)=3;
                channel(i,size)=2; channel((size-1)/2+i,size)=2;
            end
            
            for i=2:2:size-1
                channel(i,(size+1)/2)=0;
                channel((size+1)/2,i)=0;
            end
            
        case 210
             %   3  3   2  2
            % 2       0      3
            % 2       0      3
            %    0 0 0 0 0 0
            % 3       0      3
            % 3       0      3
            %    2  2   2  2        
            channel=initialChannel(3);
            for i=2:2:(size-1)/2
                channel(1,i)=3;    channel(1,(size-1)/2+i)=2;
                channel(i,1)=2;    channel((size-1)/2+i,1)=3;
                channel(size,i)=2; channel(size,(size-1)/2+i)=2;
                channel(i,size)=3; channel((size-1)/2+i,size)=3;
            end
            
            for i=2:2:size-1
                channel(i,(size+1)/2)=0;
                channel((size+1)/2,i)=0;
            end
         case 211  
             % with line
             %   2  2   3  3
            % 3       0      2
            % 3       0      2
            %    0 0 0 0 0 0
            % 2       0      3
            % 2       0      3
            %    3  3   2  2  
            channel=initialChannel(3);
            for i=2:2:(size-1)/2
                channel(1,i)=2;    channel(1,(size-1)/2+i)=3;
                channel(i,1)=3;    channel((size-1)/2+i,1)=2;
                channel(size,i)=3; channel(size,(size-1)/2+i)=2;
                channel(i,size)=2; channel((size-1)/2+i,size)=3;
            end
            
            for i=2:2:size-1
                channel(i,(size+1)/2)=0;
                channel((size+1)/2,i)=0;
            end
            channel=DrawLine(channel,100,2  ,100-26*cos(0.3*pi),2  +26*sin(0.3*pi));     
            channel=DrawLine(channel,2  ,2  ,2  +30*cos(0.22*pi),2  +30*sin(0.22*pi));
            channel=DrawLine(channel,100,100,100-30*cos(0.2*pi),100-30*sin(0.2*pi));
            channel=DrawLine(channel,2  ,100,2  +34*cos(0.24*pi),100-34*sin(0.24*pi));  
            
            channel=fillMidArea(channel,19);
            channel=fillOutputArea(channel,25);
          case 212  
             % with line
             %   2  2   3  3
            % 3       0      2
            % 3       0      2
            %    0 0 0 0 0 0
            % 2       0      3
            % 2       0      3
            %    3  3   2  2  
            channel=initialChannel(3);
            for i=2:2:(size-1)/2
                channel(1,i)=2;    channel(1,(size-1)/2+i)=3;
                channel(i,1)=3;    channel((size-1)/2+i,1)=2;
                channel(size,i)=3; channel(size,(size-1)/2+i)=2;
                channel(i,size)=2; channel((size-1)/2+i,size)=3;
            end
            
            for i=2:2:size-1
                channel(i,(size+1)/2)=0;
                channel((size+1)/2,i)=0;
            end
            channel=DrawLine(channel,100,2  ,100-26*cos(0.3*pi),2  +26*sin(0.3*pi));     
            channel=DrawLine(channel,2  ,2  ,2  +31*cos(0.22*pi),2  +31*sin(0.22*pi));
            channel=DrawLine(channel,100,100,100-30*cos(0.2*pi),100-30*sin(0.2*pi));
            channel=DrawLine(channel,2  ,100,2  +37*cos(0.24*pi),100-37*sin(0.24*pi));   
            
            channel=fillMidArea(channel,19);
            channel=fillOutputArea(channel,25);    

        case 223
             %   3  3   2  2
            % 2       0      3
            % 2       0      3
            %    0 0 0 0 0 0
            % 3       0      2
            % 3       0      2
            %    2  2   3  3        
            channel=initialChannel(3);
            for i=2:2:(size-1)/2
                channel(1,i)=3;    channel(1,(size-1)/2+i)=2;
                channel(i,1)=2;    channel((size-1)/2+i,1)=3;
                channel(size,i)=2; channel(size,(size-1)/2+i)=3;
                channel(i,size)=3; channel((size-1)/2+i,size)=2;
            end
            
            for i=2:2:size-1
                channel(i,(size+1)/2)=0;
                channel((size+1)/2,i)=0;
            end   
             channel=fillMidArea(channel,19);
            channel=fillOutputArea(channel,25);   
            
            channel=DrawLine(channel,100,2  ,100-28*cos(0.26*pi),2  +28*sin(0.26*pi));     
            channel=DrawLine(channel,2  ,2  ,2  +34*cos(0.24*pi),2  +34*sin(0.24*pi));
            channel=DrawLine(channel,100,100,100-34*cos(0.24*pi),100-34*sin(0.24*pi));
            channel=DrawLine(channel,2  ,100,2  +40*cos(0.22*pi),100-40*sin(0.22*pi));            
        case 221
              % with line
             %   2  2   3  3
            % 3       0      2
            % 3       0      2
            %    0 0 0 0 0 0
            % 2       0      3
            % 2       0      3
            %    3  3   2  2  
            channel=initialChannel(3);
            for i=2:2:(size-1)/2
                channel(1,i)=2;    channel(1,(size-1)/2+i)=3;
                channel(i,1)=3;    channel((size-1)/2+i,1)=2;
                channel(size,i)=3; channel(size,(size-1)/2+i)=2;
                channel(i,size)=2; channel((size-1)/2+i,size)=3;
            end
            
            for i=2:2:size-1
                channel(i,(size+1)/2)=0;
                channel((size+1)/2,i)=0;
            end
             channel=fillMidArea(channel,19);
            channel=fillOutputArea(channel,25);   
            
            channel=DrawLine(channel,100,2  ,100-28*cos(0.26*pi),2  +28*sin(0.26*pi));     
            channel=DrawLine(channel,2  ,2  ,2  +34*cos(0.24*pi),2  +34*sin(0.24*pi));
            channel=DrawLine(channel,100,100,100-34*cos(0.24*pi),100-34*sin(0.24*pi));
            channel=DrawLine(channel,2  ,100,2  +40*cos(0.22*pi),100-40*sin(0.22*pi));
        case 241
              % with line
             %   2  2   3  3
            % 3       0      2
            % 3       0      2
            %    0 0 0 0 0 0
            % 2       0      3
            % 2       0      3
            %    3  3   2  2  
            channel=initialChannel(3);
            for i=2:2:(size-1)/2
                channel(1,i)=2;    channel(1,(size-1)/2+i)=3;
                channel(i,1)=3;    channel((size-1)/2+i,1)=2;
                channel(size,i)=3; channel(size,(size-1)/2+i)=2;
                channel(i,size)=2; channel((size-1)/2+i,size)=3;
            end
            
            for i=2:2:size-1
                channel(i,(size+1)/2)=0;
                channel((size+1)/2,i)=0;
            end
             channel=fillMidArea(channel,19);
            channel=fillOutputArea(channel,25); 
            
              channel=DrawLine(channel,100,2  ,100-26*cos(0.24*pi),2  +26*sin(0.24*pi));     
            channel=DrawLine(channel,2  ,2  ,2  +32*cos(0.24*pi),2  +32*sin(0.24*pi));
            channel=DrawLine(channel,100,100,100-34*cos(0.24*pi),100-34*sin(0.24*pi));
            channel=DrawLine(channel,2  ,100,2  +38*cos(0.24*pi),100-38*sin(0.24*pi));
            
        case 242
              % with line
             %   2  2   3  3
            % 3       0      2
            % 3       0      2
            %    0 0 0 0 0 0
            % 2       0      3
            % 2       0      3
            %    3  3   2  2  
            channel=initialChannel(3);
            for i=2:2:(size-1)/2
                channel(1,i)=2;    channel(1,(size-1)/2+i)=3;
                channel(i,1)=3;    channel((size-1)/2+i,1)=2;
                channel(size,i)=3; channel(size,(size-1)/2+i)=2;
                channel(i,size)=2; channel((size-1)/2+i,size)=3;
            end
            
            for i=2:2:size-1
                channel(i,(size+1)/2)=0;
                channel((size+1)/2,i)=0;
            end
             channel=fillMidArea(channel,15);
            channel=fillOutputArea(channel,25);   
            
            channel=DrawLine(channel,100,2  ,100-46*cos(0.25*pi),2  +46*sin(0.25*pi));     
            channel=DrawLine(channel,2  ,2  ,2  +46*cos(0.25*pi),2  +46*sin(0.25*pi));
            channel=DrawLine(channel,100,100,100-46*cos(0.25*pi),100-46*sin(0.25*pi));
            channel=DrawLine(channel,2  ,100,2  +46*cos(0.25*pi),100-46*sin(0.25*pi)); 
            
         case 243
              % with line
             %   2  2   3  3
            % 3       0      2
            % 3       0      2
            %    0 0 0 0 0 0
            % 2       0      3
            % 2       0      3
            %    3  3   2  2  
            channel=initialChannel(3);
            for i=2:2:(size-1)/2
                channel(1,i)=2;    channel(1,(size-1)/2+i)=3;
                channel(i,1)=3;    channel((size-1)/2+i,1)=2;
                channel(size,i)=3; channel(size,(size-1)/2+i)=2;
                channel(i,size)=2; channel((size-1)/2+i,size)=3;
            end
            
            for i=2:2:size-1
                channel(i,(size+1)/2)=0;
                channel((size+1)/2,i)=0;
            end
             channel=fillMidArea(channel,19);
            channel=fillOutputArea(channel,25); 
            
              channel=DrawLine(channel,100,2  ,100-30*cos(0.24*pi),2  +30*sin(0.24*pi));     
            channel=DrawLine(channel,2  ,2  ,2  +34*cos(0.24*pi),2  +34*sin(0.24*pi));
            channel=DrawLine(channel,100,100,100-34*cos(0.24*pi),100-34*sin(0.24*pi));
            channel=DrawLine(channel,2  ,100,2  +40*cos(0.24*pi),100-40*sin(0.24*pi));      
        case 231
             %
            %design for case 3            
             %    2  2  2  2
            % 3  0        0 3
            % 3    000000   3
            % 3    000000   3
            % 3  0        0 3
            %    2  2  2  2 
            channel=initialChannel(6);
            channel=DrawLine(channel,100,2  ,100-44*cos(0.255*pi),2  +44*sin(0.255*pi));     
            channel=DrawLine(channel,2  ,2  ,2  +46*cos(0.255*pi),2  +46*sin(0.255*pi));
            channel=DrawLine(channel,100,100,100-46*cos(0.255*pi),100-46*sin(0.255*pi));   
            channel=DrawLine(channel,2  ,100,2  +46*cos(0.255*pi),100-46*sin(0.255*pi));
 
             for i=2:2:size-1
                channel(i,(size+1)/2)=0;
                channel((size+1)/2,i)=0;
             end
             
             for i=47:2:53
                for j=82:2:86
                    channel(i,j)=0;
                end
             end 
             
            for i=45:57
                for j=23:77
                    if (channel(i,j)~=-1)
                        channel(i,j)=0;
                    end
                end
            end 
            
        case 232
             % for compare, not important 
            %design for case 3            
             %    2  2  2  2
            % 3  0        0 3
            % 3    000000   3
            % 3    000000   3
            % 3  0        0 3
            %    2  2  2  2 
            channel=initialChannel(6);
            channel=DrawLine(channel,100,2  ,100-44*cos(0.255*pi),2  +44*sin(0.255*pi));     
            channel=DrawLine(channel,2  ,2  ,2  +46*cos(0.255*pi),2  +46*sin(0.255*pi));
            channel=DrawLine(channel,100,100,100-46*cos(0.255*pi),100-46*sin(0.255*pi));   
            channel=DrawLine(channel,2  ,100,2  +46*cos(0.255*pi),100-46*sin(0.255*pi));
 
             for i=2:2:size-1
                channel(i,(size+1)/2)=0;
                channel((size+1)/2,i)=0;
             end
             
             for i=47:2:53
                for j=82:2:86
                    channel(i,j)=0;
                end
             end 
             
            for i=45:57
                for j=23:77
                    if (channel(i,j)~=-1)
                        channel(i,j)=0;
                    end
                end
            end 
            channel=fillOutputArea(channel,19); 
            case 501
                % just for show
            channel=initialChannel(6);
            for i=2:2:100
                channel(i,51)=0;
            end
            for i=2:2:100
                channel(51,i)=0;
            end
            for i=2:2:50
                channel(i,1)=3;
                channel(101,i)=3;
            end
            for i=52:2:100
                channel(i,1)=2;
            end
            for i=2:2:18
                for j=61:2:79
                    channel(i,j)=0;
                end
            end
            for i=82:2:100
                for j=61:2:87
                    channel(i,j)=0;
                end
            end 

            for i=62:2:80
                for j=43:2:59
                    channel(i,j)=0;
                end
            end     
            for i=24:2:40
                for j=43:2:59
                    channel(i,j)=0;
                end
            end 
            for i=43:2:57
                for j=24:2:40
                    channel(i,j)=0;
                end
            end
            for i=43:2:57
                for j=60:2:80
                    channel(i,j)=0;
                end
            end 
            
%             for i=1:19
%                 for j=43:59
%                     if channel(i,j)~=-1
%                         channel(i,j)=0;
%                     end
%                 end
%             end
%             
%              for i=45:61
%                 for j=1:17
%                     if channel(i,j)~=-1
%                         channel(i,j)=0;
%                     end
%                 end
%             end           
            

            for i=69:2:99
                for j=2:2:101-i
                    channel(i,j)=0;
                end
            end
            
            for i=81:2:99
                for j=2:2:101-i
                    channel(102-j,102-i)=0;
                end
            end            
            channel=TurnoverMatrix(channel);
            
        %% new pattern of IO
        case 301     
             %   2  2   3  3
            % 3       0      2
            % 3       0      2
            %    0 0 0 0 0 0
            % 2       0      3
            % 2       0      3
            %    3  3   2  2  
            channel=initialChannel(3);
            for i=2:2:(size-1)/2
                channel(1,i)=2;    channel(1,(size-1)/2+i)=3;
                channel(i,1)=3;    channel((size-1)/2+i,1)=2;
                channel(size,i)=3; channel(size,(size-1)/2+i)=2;
                channel(i,size)=2; channel((size-1)/2+i,size)=3;
            end
            
            for i=2:2:size-1
                channel(i,(size+1)/2)=0;
                channel((size+1)/2,i)=0;
            end
             channel=fillMidArea(channel,19);
            channel=fillOutputArea(channel,25);   
            
             channel=DrawLine(channel,100,2  ,100-32*cos(0.25*pi),2  +32*sin(0.25*pi));     
            channel=DrawLine(channel,2  ,2  ,2  +32*cos(0.25*pi),2  +32*sin(0.25*pi));
            channel=DrawLine(channel,100,100,100-32*cos(0.25*pi),100-32*sin(0.25*pi));
            channel=DrawLine(channel,2  ,100,2  +32*cos(0.25*pi),100-32*sin(0.25*pi));            
        case 302
             %   3  3   2  2
            % 2       0      3
            % 2       0      3
            %    0 0 0 0 0 0
            % 3       0      2
            % 3       0      2
            %    2  2   3  3        
            channel=initialChannel(3);
            for i=2:2:(size-1)/2
                channel(1,i)=3;    channel(1,(size-1)/2+i)=2;
                channel(i,1)=2;    channel((size-1)/2+i,1)=3;
                channel(size,i)=2; channel(size,(size-1)/2+i)=3;
                channel(i,size)=3; channel((size-1)/2+i,size)=2;
            end
            
            for i=2:2:size-1
                channel(i,(size+1)/2)=0;
                channel((size+1)/2,i)=0;
            end
             channel=fillMidArea(channel,19);
            channel=fillOutputArea(channel,25);   
            
             channel=DrawLine(channel,100,2  ,100-32*cos(0.25*pi),2  +32*sin(0.25*pi));     
            channel=DrawLine(channel,2  ,2  ,2  +32*cos(0.25*pi),2  +32*sin(0.25*pi));
            channel=DrawLine(channel,100,100,100-32*cos(0.25*pi),100-32*sin(0.25*pi));
            channel=DrawLine(channel,2  ,100,2  +32*cos(0.25*pi),100-32*sin(0.25*pi)); 
        case 303
             %   3  3   3  3
            % 2       0      2
            % 2       0      2
            %    0 0 0 0 0 0
            % 2       0      3
            % 2       0      3
            %    3  3   2  2  
            channel=initialChannel(3);
            for i=2:2:(size-1)/2
                channel(1,i)=3;    channel(1,(size-1)/2+i)=3;
                channel(i,1)=2;    channel((size-1)/2+i,1)=2;
                channel(size,i)=3; channel(size,(size-1)/2+i)=2;
                channel(i,size)=2; channel((size-1)/2+i,size)=3;
            end
            
            for i=2:2:size-1
                channel(i,(size+1)/2)=0;
                channel((size+1)/2,i)=0;
            end
             channel=fillMidArea(channel,19);
            channel=fillOutputArea(channel,25);   
            
             channel=DrawLine(channel,100,2  ,100-32*cos(0.25*pi),2  +32*sin(0.25*pi));     
            channel=DrawLine(channel,2  ,2  ,2  +32*cos(0.25*pi),2  +32*sin(0.25*pi));
            channel=DrawLine(channel,100,100,100-32*cos(0.25*pi),100-32*sin(0.25*pi));
            channel=DrawLine(channel,2  ,100,2  +32*cos(0.25*pi),100-32*sin(0.25*pi)); 
        case 304
             %   2  2   2  2
            % 3       0      3
            % 3       0      3
            %    0 0 0 0 0 0
            % 3       0      2
            % 3       0      2
            %    2  2   3  3        
            channel=initialChannel(3);
            for i=2:2:(size-1)/2
                channel(1,i)=2;    channel(1,(size-1)/2+i)=2;
                channel(i,1)=3;    channel((size-1)/2+i,1)=3;
                channel(size,i)=2; channel(size,(size-1)/2+i)=3;
                channel(i,size)=3; channel((size-1)/2+i,size)=2;
            end
            
            for i=2:2:size-1
                channel(i,(size+1)/2)=0;
                channel((size+1)/2,i)=0;
            end     
              channel=fillMidArea(channel,19);
            channel=fillOutputArea(channel,25);   
            
             channel=DrawLine(channel,100,2  ,100-32*cos(0.25*pi),2  +32*sin(0.25*pi));     
            channel=DrawLine(channel,2  ,2  ,2  +32*cos(0.25*pi),2  +32*sin(0.25*pi));
            channel=DrawLine(channel,100,100,100-32*cos(0.25*pi),100-32*sin(0.25*pi));
            channel=DrawLine(channel,2  ,100,2  +32*cos(0.25*pi),100-32*sin(0.25*pi));            
        case 305     
             %   2  2   3  3
            % 3       0      2
            % 3       0      2
            %    0 0 0 0 0 0
            % 3       0      3
            % 3       0      3
            %    2  2   2  2  
            channel=initialChannel(3);
            for i=2:2:(size-1)/2
                channel(1,i)=2;    channel(1,(size-1)/2+i)=3;
                channel(i,1)=3;    channel((size-1)/2+i,1)=3;
                channel(size,i)=2; channel(size,(size-1)/2+i)=2;
                channel(i,size)=2; channel((size-1)/2+i,size)=3;
            end
            
            for i=2:2:size-1
                channel(i,(size+1)/2)=0;
                channel((size+1)/2,i)=0;
            end
             channel=fillMidArea(channel,19);
            channel=fillOutputArea(channel,25);   
            
             channel=DrawLine(channel,100,2  ,100-32*cos(0.25*pi),2  +32*sin(0.25*pi));     
            channel=DrawLine(channel,2  ,2  ,2  +32*cos(0.25*pi),2  +32*sin(0.25*pi));
            channel=DrawLine(channel,100,100,100-32*cos(0.25*pi),100-32*sin(0.25*pi));
            channel=DrawLine(channel,2  ,100,2  +32*cos(0.25*pi),100-32*sin(0.25*pi));             
        case 306
             %   3  3   2  2
            % 2       0      3
            % 2       0      3
            %    0 0 0 0 0 0
            % 2       0      2
            % 2       0      2
            %    3  3   3  3        
            channel=initialChannel(3);
            for i=2:2:(size-1)/2
                channel(1,i)=3;    channel(1,(size-1)/2+i)=2;
                channel(i,1)=2;    channel((size-1)/2+i,1)=2;
                channel(size,i)=3; channel(size,(size-1)/2+i)=3;
                channel(i,size)=3; channel((size-1)/2+i,size)=2;
            end
            
            for i=2:2:size-1
                channel(i,(size+1)/2)=0;
                channel((size+1)/2,i)=0;
            end
             channel=fillMidArea(channel,19);
            channel=fillOutputArea(channel,25);   
            
             channel=DrawLine(channel,100,2  ,100-32*cos(0.25*pi),2  +32*sin(0.25*pi));     
            channel=DrawLine(channel,2  ,2  ,2  +32*cos(0.25*pi),2  +32*sin(0.25*pi));
            channel=DrawLine(channel,100,100,100-32*cos(0.25*pi),100-32*sin(0.25*pi));
            channel=DrawLine(channel,2  ,100,2  +32*cos(0.25*pi),100-32*sin(0.25*pi)); 
        case 307     
             %   2  2   2  2
            % 3       0      3
            % 3       0      3
            %    0 0 0 0 0 0
            % 2       0      3
            % 2       0      3
            %    3  3   2  2  
            channel=initialChannel(3);
            for i=2:2:(size-1)/2
                channel(1,i)=2;    channel(1,(size-1)/2+i)=2;
                channel(i,1)=3;    channel((size-1)/2+i,1)=2;
                channel(size,i)=3; channel(size,(size-1)/2+i)=2;
                channel(i,size)=3; channel((size-1)/2+i,size)=3;
            end
            
            for i=2:2:size-1
                channel(i,(size+1)/2)=0;
                channel((size+1)/2,i)=0;
            end
             channel=fillMidArea(channel,19);
            channel=fillOutputArea(channel,25);   
            
             channel=DrawLine(channel,100,2  ,100-32*cos(0.25*pi),2  +32*sin(0.25*pi));     
            channel=DrawLine(channel,2  ,2  ,2  +32*cos(0.25*pi),2  +32*sin(0.25*pi));
            channel=DrawLine(channel,100,100,100-32*cos(0.25*pi),100-32*sin(0.25*pi));
            channel=DrawLine(channel,2  ,100,2  +32*cos(0.25*pi),100-32*sin(0.25*pi));             
        case 308
             %   3  3   2  2
            % 2       0      3
            % 2       0      3
            %    0 0 0 0 0 0
            % 3       0      2
            % 3       0      2
            %    2  2   3  3        
            channel=initialChannel(3);
            for i=2:2:(size-1)/2
                channel(1,i)=3;    channel(1,(size-1)/2+i)=3;
                channel(i,1)=2;    channel((size-1)/2+i,1)=3;
                channel(size,i)=2; channel(size,(size-1)/2+i)=3;
                channel(i,size)=2; channel((size-1)/2+i,size)=2;
            end
            
            for i=2:2:size-1
                channel(i,(size+1)/2)=0;
                channel((size+1)/2,i)=0;
            end
             channel=fillMidArea(channel,19);
            channel=fillOutputArea(channel,25);   
            
             channel=DrawLine(channel,100,2  ,100-32*cos(0.25*pi),2  +32*sin(0.25*pi));     
            channel=DrawLine(channel,2  ,2  ,2  +32*cos(0.25*pi),2  +32*sin(0.25*pi));
            channel=DrawLine(channel,100,100,100-32*cos(0.25*pi),100-32*sin(0.25*pi));
            channel=DrawLine(channel,2  ,100,2  +32*cos(0.25*pi),100-32*sin(0.25*pi)); 
        case 309     
             %   2  2   3  3
            % 3       0      2
            % 3       0      2
            %    0 0 0 0 0 0
            % 2       0      2
            % 2       0      2
            %    3  3   3  3  
            channel=initialChannel(3);
            for i=2:2:(size-1)/2
                channel(1,i)=2;    channel(1,(size-1)/2+i)=3;
                channel(i,1)=3;    channel((size-1)/2+i,1)=2;
                channel(size,i)=3; channel(size,(size-1)/2+i)=3;
                channel(i,size)=2; channel((size-1)/2+i,size)=2;
            end
            
            for i=2:2:size-1
                channel(i,(size+1)/2)=0;
                channel((size+1)/2,i)=0;
            end
              channel=fillMidArea(channel,19);
            channel=fillOutputArea(channel,25);   
            
             channel=DrawLine(channel,100,2  ,100-32*cos(0.25*pi),2  +32*sin(0.25*pi));     
            channel=DrawLine(channel,2  ,2  ,2  +32*cos(0.25*pi),2  +32*sin(0.25*pi));
            channel=DrawLine(channel,100,100,100-32*cos(0.25*pi),100-32*sin(0.25*pi));
            channel=DrawLine(channel,2  ,100,2  +32*cos(0.25*pi),100-32*sin(0.25*pi));            
        case 310
             %   3  3   2  2
            % 2       0      3
            % 2       0      3
            %    0 0 0 0 0 0
            % 3       0      3
            % 3       0      3
            %    2  2   2  2        
            channel=initialChannel(3);
            for i=2:2:(size-1)/2
                channel(1,i)=3;    channel(1,(size-1)/2+i)=2;
                channel(i,1)=2;    channel((size-1)/2+i,1)=3;
                channel(size,i)=2; channel(size,(size-1)/2+i)=2;
                channel(i,size)=3; channel((size-1)/2+i,size)=3;
            end
            
            for i=2:2:size-1
                channel(i,(size+1)/2)=0;
                channel((size+1)/2,i)=0;
            end            
             channel=fillMidArea(channel,19);
            channel=fillOutputArea(channel,25);   
            
             channel=DrawLine(channel,100,2  ,100-32*cos(0.25*pi),2  +32*sin(0.25*pi));     
            channel=DrawLine(channel,2  ,2  ,2  +32*cos(0.25*pi),2  +32*sin(0.25*pi));
            channel=DrawLine(channel,100,100,100-32*cos(0.25*pi),100-32*sin(0.25*pi));
            channel=DrawLine(channel,2  ,100,2  +32*cos(0.25*pi),100-32*sin(0.25*pi));             
        otherwise
                warning('unknown initial channel type');
    end
end

function channel=DrawFourLine(channel,theta1,line_length1,theta2,line_length2,theta3,line_length3, theta4,line_length4)
    channel=DrawLine(channel,100,2,100-line_length1*cos(theta1*pi),2+line_length1*sin(theta1*pi));     
    channel=DrawLine(channel,2,2,2+line_length2*cos(theta2*pi),2+line_length2*sin(theta2*pi));
   
    channel=DrawLine(channel,2,100,2+line_length4*cos(theta4*pi),100-line_length4*sin(theta4*pi));
    channel=DrawLine(channel,100,100,100-line_length3*cos(theta3*pi),100-line_length3*sin(theta3*pi));

end

function channel=DrawLine(channel,x1,y1,x2,y2)
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
end

function channel=RemoveLine(channel,x1,y1,x2,y2)
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
    if(x1~=x2)
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
                if channel(x1,i+1)~=-1&&channel(x1,i+1)~=2&&channel(x1,i+1)~=3
                   channel(x1,i+1)=1;
                end
                if channel(x1,i-1)~=-1&&channel(x1,i-1)~=2&&channel(x1,i-1)~=3
                   channel(x1,i-1)=1;
                end               
            end
        else
             for i=y1:-1:y2
                if channel(x1,i)~=-1&&channel(x1,i)~=2&&channel(x1,i)~=3            
                    channel(x1,i)=1;
                end
                if channel(x1,i+1)~=-1&&channel(x1,i+1)~=2&&channel(x1,i+1)~=3
                   channel(x1,i+1)=1;
                end
                if channel(x1,i-1)~=-1&&channel(x1,i-1)~=2&&channel(x1,i-1)~=3
                   channel(x1,i-1)=1;
                end 
             end 
        end
    end    
end