function [ flag ] = Equal( lh,rh )
% Judge if two floating number is equal, eg abs(lh-rh)<0.00001
%   
    if(abs(lh-rh)<0.05)
        flag=1;
    else
        flag=0;
    end
end

