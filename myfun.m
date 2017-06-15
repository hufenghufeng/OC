function [ x0 ] = myfun( x )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    format long 
    x
    disp(num2str(x));         
    load Pin.dat;
    Pin(1)=x*1000;
    dlmwrite('Pin.dat',Pin,'\t');
    x0=x;
end

