clear all
load pressure.dat;

for i=1:49
   for j=1:49
      if pressure(2*i,2*j)~=-1 
          if (pressure(2*i+1,2*j)~=-1)&&(pressure(2*i+2,2*j)~=-1)
              verticalFlow(i,j)=pressure(2*i,2*j)-pressure(2*i+2,2*j);
          end
      end
   end
end

for i=1:49
   for j=1:49
      if pressure(2*i,2*j)~=-1 
          if (pressure(2*i,2*j+1)~=-1)&&(pressure(2*i,2*j+2)~=-1)
              horizontalFlow(i,j)=pressure(2*i,2*j)-pressure(2*i,2*j+2);
          end
      end
   end
end


for i=1:25
    for j=1:25
        yFlow(i,j)=verticalFlow(2*i-1,2*j-1);
        xFlow(i,j)=horizontalFlow(2*i-1,2*j-1);
    end
end

for i=1:13
    for j=1:13
        yyFlow(i,j)=yFlow(2*i-1,2*j-1);
        xxFlow(i,j)=xFlow(2*i-1,2*j-1);
    end
end

for i=1:7
    for j=1:7
        yyyFlow(i,j)=yyFlow(2*i-1,2*j-1);
        xxxFlow(i,j)=xxFlow(2*i-1,2*j-1);
    end
end


[x,y] = meshgrid(1:7,1:7);
quiver(x,y,xxxFlow,yyyFlow)
% [x,y] = meshgrid(1:13,1:13);
% quiver(x,y,xxFlow,yyFlow)
% for i=1:23
%    for j=1:23
%       if pressure(4*i+2,4*j+2)~=-1 
%           if (pressure(4*i+2+1,4*j+2)~=-1)&&(pressure(4*i+2+2,4*j+2)~=-1)
%               verticalFlow(i,j)=pressure(4*i+2,4*j+2)-pressure(4*i+2+2,4*j+2);
%           end
%       end
%    end
% end
% 
% for i=1:23
%    for j=1:23
%       if pressure(4*i+2,4*j+2)~=-1 
%           if (pressure(4*i+2,4*j+2+1)~=-1)&&(pressure(4*i+2,4*j+2+2)~=-1)
%               horizontalFlow(i,j)=pressure(4*i+2,4*j+2)-pressure(4*i+2,4*j+2+2);
%           end
%       end
%    end
% end