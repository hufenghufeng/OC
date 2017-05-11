function [ channel ] = RemoveLoops( channel )
%remove dead loops in channel network by
%   Detailed explanation goes here
    [R,C]=size(channel);
    index=zeros(R,C);
    mark=zeros(R,C);
    %   give every liquid cell the index
    % array as stack, put node with 0 in
    Q=[];
    cnt=1;
    for i=1:R
        for j=1:C
            if channel(i,j)>0
                index(i,j)=cnt;
                cnt=cnt+1;
            end
        end
    end

    % topology martix ,or named neighboring matrix
    nm=zeros(cnt+2,cnt+2);
    % 处理入口,出口
    for i=1:R
        for j=1:C
            if channel(i,j)==2
                mark(i,j)=1;
                nm(cnt+1,index(i,j))=1;
                Q=[Q;i,j];
            end
            if channel(i,j)==3               
                nm(index(i,j),cnt+2)=1;
            end
        end
    end
    
    while ~isempty(Q)
        n=Q(1,:);
        Q(1,:)=[];
        i=n(1);
        j=n(2);
        
        % down
        if i<R
            if channel(i+1,j)>0 
                if nm(index(i+1,j),index(i,j))==0
                    nm(index(i,j),index(i+1,j))=1;
                end                
            end
            [Q,mark,nm]=goToNextCrossing(channel,mark,index,nm,Q,i+1,j);
        end
        % up
        if i>1
            if channel(i-1,j)>0 
                if nm(index(i-1,j),index(i,j))==0
                    nm(index(i,j),index(i-1,j))=1;
                end                
            end
            [Q,mark,nm]=goToNextCrossing(channel,mark,index,nm,Q,i-1,j);
        end
        % left
        if j>1
            if channel(i,j-1)>0 
                if nm(index(i,j-1),index(i,j))==0
                    nm(index(i,j),index(i,j-1))=1;
                end                
            end
            [Q,mark,nm]=goToNextCrossing(channel,mark,index,nm,Q,i,j-1);
        end       
        % right
        if j<C
            if channel(i,j+1)>0 
                if nm(index(i,j+1),index(i,j))==0
                    nm(index(i,j),index(i,j+1))=1;
                end                
            end
            [Q,mark,nm]=goToNextCrossing(channel,mark,index,nm,Q,i,j+1);
        end        
    end
    loop=[];
    
    loop=detectLoops(nm);
    % fill loops in channel
    for i=1:1:length(loop)
        [rdest,cdest]=find(index==loop(i));
        channel=fillLiquid(channel,rdest,cdest);
    end
    
    % remove isolate circle
    mark=channel;
    for i=1:R
        for j=1:C
            if channel(i,j)==2 || channel(i,j)==3
                mark=DFS(channel,mark,i,j);
            end
        end
    end
    
    for i=1:R
        for j=1:C
            if channel(i,j)>0 && mark(i,j)>0
                channel(i,j)=0;
            end
        end
    end    
    
    % remove dead end
    for i=1:R
        for j=1:C
            if channel(i,j)==1 
                channel=CheckConnect(i,j,channel);
            end
        end
    end
end

%%
function [flag]=isFolk(channel,i,j)
    flag=false;
    [r,c]=size(channel);
    neighborNum=0;
    
    if channel(i,j)>0 
        % down
        if i<r
            if channel(i+1,j)>0 
                neighborNum=neighborNum+1;
            end
        end
        % up
        if i>1
            if channel(i-1,j)>0  
                neighborNum=neighborNum+1;
            end
        end
        % left
        if j>1
            if channel(i,j-1)>0 
                neighborNum=neighborNum+1;
            end
        end       
        % right
        if j<c
            if channel(i,j+1)>0 
                neighborNum=neighborNum+1;
            end
        end
    end 
    if neighborNum>2
        flag=true;
    end
end
%%
function [Q,mark,nm]=goToNextCrossing(channel,mark,index,nm,Q,i,j)
    [r,c]=size(channel);
    if channel(i,j)==2 
        if isFolk(channel,i,j)
            Q=[Q;i,j];
            return;
        end
        % down
        if i<r
            if channel(i+1,j)>0
                
                if nm(index(i+1,j),index(i,j))==0
                    nm(index(i,j),index(i+1,j))=1;
                end
                
                if isFolk(channel,i+1,j)==true
                    if mark(i+1,j)==0
                        Q=[Q;i+1,j];
                    end
                    return
                else
                    [Q,mark,nm]=goToNextCrossing(channel,mark,index,nm,Q,i+1,j);
                end
            end
        end
        % up
        if i>1
            if channel(i-1,j)>0
                
                if nm(index(i-1,j),index(i,j))==0
                    nm(index(i,j),index(i-1,j))=1;
                end
                
                if isFolk(channel,i-1,j)==true
                    if mark(i-1,j)==0
                        Q=[Q;i-1,j];
                    end
                    return
                else
                    [Q,mark,nm]=goToNextCrossing(channel,mark,index,nm,Q,i-1,j);
                end
            end
        end
        % left
        if j>1
            if channel(i,j-1)>0
                
                if nm(index(i,j-1),index(i,j))==0
                    nm(index(i,j),index(i,j-1))=1;
                end
                
                if isFolk(channel,i,j-1)==true
                    if mark(i,j-1)==0
                        Q=[Q;i,j-1];
                    end
                    return
                else
                    [Q,mark,nm]=goToNextCrossing(channel,mark,index,nm,Q,i,j-1);
                end
            end
        end       
        % right
        if j<c
            if channel(i,j+1)>0
                
                if nm(index(i,j+1),index(i,j))==0
                    nm(index(i,j),index(i,j+1))=1;
                end
                
                if isFolk(channel,i,j+1)==true
                    if mark(i,j+1)==0
                        Q=[Q;i,j+1];
                    end
                    return
                else
                    [Q,mark,nm]=goToNextCrossing(channel,mark,index,nm,Q,i,j+1);
                end
            end
        end
    else
    
        if channel(i,j)>0 && mark(i,j)==0  
            mark(i,j)=1;
            if isFolk(channel,i,j)
                Q=[Q;i,j];
                return;
            end            
            
            % down
            if i<r
                if channel(i+1,j)>0&&nm(index(i+1,j),index(i,j))~=1

                    if nm(index(i+1,j),index(i,j))==0
                        nm(index(i,j),index(i+1,j))=1;
                    end

                    if isFolk(channel,i+1,j)==true
                        if mark(i+1,j)==0
                            Q=[Q;i+1,j];
                        end
                        return
                    else
                        [Q,mark,nm]=goToNextCrossing(channel,mark,index,nm,Q,i+1,j);
                    end
                end
            end
            % up
            if i>1
                if channel(i-1,j)>0&&nm(index(i-1,j),index(i,j))~=1

                    if nm(index(i-1,j),index(i,j))==0
                        nm(index(i,j),index(i-1,j))=1;
                    end

                    if isFolk(channel,i-1,j)==true
                        if mark(i-1,j)==0
                            Q=[Q;i-1,j];
                        end
                        return
                    else
                        [Q,mark,nm]=goToNextCrossing(channel,mark,index,nm,Q,i-1,j);
                    end
                end
            end
            % left
            if j>1
                if channel(i,j-1)>0&&nm(index(i,j-1),index(i,j))~=1

                    if nm(index(i,j-1),index(i,j))==0
                        nm(index(i,j),index(i,j-1))=1;
                    end

                    if isFolk(channel,i,j-1)==true
                        if mark(i,j-1)==0
                            Q=[Q;i,j-1];
                        end
                        return
                    else
                        [Q,mark,nm]=goToNextCrossing(channel,mark,index,nm,Q,i,j-1);
                    end
                end
            end       
            % right
            if j<c
                if channel(i,j+1)>0&&nm(index(i,j+1),index(i,j))~=1

                    if nm(index(i,j+1),index(i,j))==0
                        nm(index(i,j),index(i,j+1))=1;
                    end

                    if isFolk(channel,i,j+1)==true
                        if mark(i,j+1)==0
                            Q=[Q;i,j+1];
                        end
                        return
                    else
                        [Q,mark,nm]=goToNextCrossing(channel,mark,index,nm,Q,i,j+1);
                    end
                end
            end
        end
    end     
end

%%
function [loop]=detectLoops(nm)
    [R,C]=size(nm);
    
    S=[];
    S=[S,R-1];
    Q=[];
    loop=[];   
    while ~isempty(S) || ~isempty(Q)~=0
        while ~isempty(S)
            n=S(1);
            S(1)=[];
            % 去掉以n为尾的边
            for j=1:1:R
                if nm(n,j)>0
                    nm(n,j)=0;
                    % 入度不为0压入Q，入度为0压入S
                    flag=0;
                    for k=1:R
                        if nm(k,j)>0
                            flag=1;
                            Q=[Q,j];
                            break
                        end
                    end
                    if flag==0
                        S=[S,j];
                    end
                end
            end
        end
        
        while ~isempty(Q)
            m=Q(1);
            % to do : isolated channel
            Q(1)=[];
            [res,pos]=inLoop(nm,m);
            if res==true
                loop=[loop,pos];
            end
            S=[S,m];
            % 去掉以m为头的边
            for j=1:1:R
                if nm(j,m)>0
                    nm(j,m)=0;
                end
            end
        end
    end    
end

%%
function [res,position]=inLoop(nm,begin)
    [r,c]=size(nm);
    position=-1;
    res=false;
    for i=1:1:r
        if nm(begin,i)>0
            res=backToBegin(nm,i,begin);
            if res==true
                position=i;
                return
            end
        end
    end
end

%%
function [result]=backToBegin(nm,begin,dest)
    [r,c]=size(nm);
    result=false;
    for i=1:1:c
       if nm(begin,i)>0 
           if i==dest
               result=true;
               return 
           end
           if result==false
               result=backToBegin(nm,i,dest);
           end
       end
    end
end

%% 
function [channel]=fillLiquid(channel,i,j)
    [r,c]=size(channel);
    if i>0 && i<=r && j>0 && j<c && channel(i,j)==1
        channel(i,j)=0;
        
        % down
        if i<r
            channel=CheckConnect(i+1,j,channel); 
        end
        % up
        if i>1
            channel=CheckConnect(i-1,j,channel); 
        end
        % left
        if j>1
            channel=CheckConnect(i,j-1,channel); 
        end       
        % right
        if j<c
            channel=CheckConnect(i,j+1,channel); 
        end
    end
end

%%
function [channel] = CheckConnect( row,col,channel )
%fill dead end channel recursively
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

function [row_temp,col_temp]=Adjacent_1_Location(row,col,channel)
% return the location of adjancent liquid cells
%   return only one of the location
    [R,C]=size(channel);
    
    %left
    if(row>1)
           if(channel(row-1,col)>0)
               row_temp=row-1;
               col_temp=col;
           end
    end
    %right
    if(row<R)
        if(channel(row+1,col)>0)
               row_temp=row+1;
               col_temp=col;
        end
    end
    %up
    if(col>1)
        if(channel(row,col-1)>0)
               row_temp=row;
               col_temp=col-1;
        end
    end
    %down
    if(col<C)
        if(channel(row,col+1)>0)
               row_temp=row;
               col_temp=col+1;
        end
    end
end


function [ num ] = Adjacent_1_Num(row,col,channel)
%   return the number of adjacent 1 of the block (row,col)
    [R,C]=size(channel);
    num=0;
    %left
    if(row>1)
           if(channel(row-1,col)>0)
               num=num+1;
           end
    end
    %right
    if(row<R)
        if(channel(row+1,col)>0)
            num=num+1;
        end
    end
    %up
    if(col>1)
        if(channel(row,col-1)>0)
            num=num+1;
        end
    end
    %down
    if(col<C)
        if(channel(row,col+1)>0)
            num=num+1;
        end
    end              
end


function [mark]=DFS(channel,mark,row,col)
     [R,C]=size(channel);   
     if channel(row,col)>0 && mark(row,col)>0
        mark(row,col)=0;
        %left
        if(row>1)
               if(channel(row-1,col)>0)
                   mark=DFS(channel,mark,row-1,col);
               end
        end
        %right
        if(row<R)
            if(channel(row+1,col)>0)
                mark=DFS(channel,mark,row+1,col);
            end
        end
        %up
        if(col>1)
            if(channel(row,col-1)>0)
                mark=DFS(channel,mark,row,col-1);
            end
        end
        %down
        if(col<C)
            if(channel(row,col+1)>0)
                mark=DFS(channel,mark,row,col+1);
            end
        end 
     end
end