function [ r,c ] = FindNTmin( Tmap ,n)
%find n points of the Tmin
%  
    [r,c]=size(Tmap);
    TArray(:,1)=Tmap(:);
    TArray(:,2)=1:r*c;
    
    TArray=sortrows(TArray);
    
    TminList=TArray(1:n,2);
    
    [r,c]=ind2sub(size(Tmap),TminList);
end

