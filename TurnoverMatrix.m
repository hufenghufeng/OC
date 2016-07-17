function [ matrix ] = TurnoverMatrix( matrix )
%turn over a matrix 
%   a=[1,2;3,4]->[3,4;1,2]
    [rows,cols]=size(matrix);
    
    for i=1:floor(rows/2)
        temp=matrix(i,:);
        matrix(i,:)=matrix(cols+1-i,:);
        matrix(cols+1-i,:)=temp;
    end
    
end

