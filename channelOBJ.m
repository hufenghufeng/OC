classdef channelOBJ
    %create for fill four part in the same time 
    %   
    
    properties
        channel;
        TSVMark;
        TSVMark1;
        TSVMark2;
        TSVMark3;
        TSVMark4;
        channelMark;
        channelMark1;
        channelMark2;
        channelMark3;
        channelMark4;
    end
    
    methods        
        function lo=channelOBJ(channel)
            lo.channel=channel;
            lo.TSVMark=channel;
            lo.channelMark=channel;
            lo.TSVMark1=channel(52:101,1:50);
            lo.TSVMark2=channel(1:50,1:50);
            lo.TSVMark3=channel(52:101,52:101);
            lo.TSVMark4=channel(1:50,52:101);
            lo.channelMark1=channel(52:101,1:50);
            lo.channelMark2=channel(1:50,1:50);
            lo.channelMark3=channel(52:101,52:101);
            lo.channelMark4=channel(1:50,52:101);
        end
        
        % random choose N cells to fill
        function [R,C,obj]=randomChoose(obj,N)
            SIZE=101;
            counter=1;
            while counter<N+1
               row=randi(SIZE);
               col=randi(SIZE);
               if obj.channel(row,col)>0
                   R(counter)=row;
                   C(counter)=col;
                   counter=counter+1;
               end
            end
        end
        
        function [R,C,obj]=topNForFill(obj,topTmap,N)
            % if N==2, then you choose one cell to fill;
            Tmap1=topTmap;
            TArray(:,1)=Tmap1(:);
            TArray(:,2)=1:101*101;
            TArray(:,3)=obj.TSVMark(:);
            TArray(:,4)=obj.channelMark(:);
            TArray=sortrows(TArray);  
            
            counter=1;
            for i=1:101*101
                if (TArray(i,3)~=0)&&(TArray(i,4)~=0)
                    [R(counter),C(counter)]=ind2sub(size(Tmap1),TArray(i,2));
                    obj.TSVMark(R(counter),C(counter))=0;              
                    obj.channelMark(R(counter),C(counter))=0;
                    counter=counter+1;
                end
                if counter>N
                    break;
                end
            end
        end
        
        function [R,C,obj]=RandomNForFill(obj,Tmap,N)
            % if N==2, then you choose one cell to fill;
            Tmap1=topTmap;
            TArray(:,1)=Tmap1(:);
            TArray(:,2)=1:101*101;
            TArray(:,3)=obj.TSVMark(:);
            TArray(:,4)=obj.channelMark(:);
            TArray=sortrows(TArray);  
            % choose probability array
            p=zero(20,1);
            for i=1:20
               p(i)=exp(-i); 
            end
            p=p/sum(p);
            
            counter=1;
            for i=1:101*101
                if (TArray(i,3)~=0)&&(TArray(i,4)~=0)
                    if(rand()<p(counter))
                        [R(counter),C(counter)]=ind2sub(size(Tmap1),TArray(i,2));
                        obj.TSVMark(R(counter),C(counter))=0;              
                        obj.channelMark(R(counter),C(counter))=0;
                        counter=counter+1;
                        p(counter:20)=p(counter:20)/sum(p(counter:20));
%                         for j=counter:20
%                             p(j)=p(j)/sum(p(counter:20));
%                         end
                    end
                end
                if counter>N
                    break;
                end
            end            
        end
        
        function [R,C,resultObj]=ChooseOneForRecover(obj,resultObj)
            recoverArray=[];
            R=[];
            C=[];
            % construct recoverArray
            for i=1:length(resultObj.filledR)
                if(resultObj.filledF(i)==1)
                    recoverArray=[recoverArray;resultObj.filledT(i),resultObj.filledR(i),resultObj.filledC(i),i];
                else if (resultObj.filledF(i)==0)
                        tempJudge=isUnfillable(obj.channel,resultObj.filledR(i),resultObj.filledC(i));
                        fprintf('\njudge is %d\n',tempJudge);
                        if tempJudge==1
                            resultObj.filledF(i)=1;
                            recoverArray=[recoverArray;resultObj.filledT(i),resultObj.filledR(i),resultObj.filledC(i),i];
                        else
                            resultObj.filledF(i)=-1;
                        end
                    end
                end
            end
            % add column of probability
            recoverArray=sortrows(recoverArray,-1);
            [rowSize,colSize]=size(recoverArray);
            p=zeros(rowSize,1);
            for i=1:rowSize
                p(i)=1.2^(-i);
            end
            p=p/sum(p);
            %recoverArray=[recoverArray,p];
            % choose one (R,C) randomly
            for i=1:rowSize
                a=rand();
                if a<p(i)
                    R=recoverArray(i,2);
                    C=recoverArray(i,3);
                    resultObj.filledF(recoverArray(i,4))=-1;
                    return;
                end
            end
        end
                
        function [R1,C1,obj]=topNForFill1(obj,topTmap)
            N=1;
            Tmap1=topTmap(52:101,1:50);
            TArray1(:,1)=Tmap1(:);
            TArray1(:,2)=1:2500;
            TArray1(:,3)=obj.TSVMark1(:);
            TArray1(:,4)=obj.channelMark1(:);
            TArray1=sortrows(TArray1);  
            
            counter=1;
            for i=1:2500
                if (TArray1(i,3)~=0)&&(TArray1(i,4)~=0)
                    [R1(counter),C1(counter)]=ind2sub(size(Tmap1),TArray1(i,2));
                    obj.TSVMark1(R1(counter),C1(counter))=0;              
                    obj.channelMark1(R1(counter),C1(counter))=0;
                    counter=counter+1;
                end
                if counter>N
                    break;
                end
            end
            R1=R1+51;
        end
        
        function [R2,C2,obj]=topNForFill2(obj,topTmap)
            N=1;
            Tmap2=topTmap(1:50,1:50);
            TArray2(:,1)=Tmap2(:);
            TArray2(:,2)=1:2500;
            TArray2(:,3)=obj.TSVMark2(:);
            TArray2(:,4)=obj.channelMark2(:);
            TArray2=sortrows(TArray2);  
            
            counter=1;
            for i=1:2500
                if (TArray2(i,3)~=0)&&(TArray2(i,4)~=0)
                    [R2(counter),C2(counter)]=ind2sub(size(Tmap2),TArray2(i,2));
                    obj.TSVMark2(R2(counter),C2(counter))=0;
                    obj.channelMark2(R2(counter),C2(counter))=0;                  
                    counter=counter+1;
                end
                if counter>N
                    break;
                end
            end
        end 
        
        function [R3,C3,obj]=topNForFill3(obj,topTmap)
            N=1;
            Tmap3=topTmap(52:101,52:101);
            TArray3(:,1)=Tmap3(:);
            TArray3(:,2)=1:2500;
            TArray3(:,3)=obj.TSVMark3(:);
            TArray3(:,4)=obj.channelMark3(:);
            TArray3=sortrows(TArray3);  
            
            counter=1;
            for i=1:2500
                if (TArray3(i,3)~=0)&&(TArray3(i,4)~=0)
                    [R3(counter),C3(counter)]=ind2sub(size(Tmap3),TArray3(i,2));
                    obj.TSVMark3(R3(counter),C3(counter))=0;
                    obj.channelMark3(R3(counter),C3(counter))=0;
                    counter=counter+1;
                end
                if counter>N
                    break;
                end
            end
            R3=R3+51;
            C3=C3+51;
        end        
        
        function [R4,C4,obj]=topNForFill4(obj,topTmap)
            N=1;
            Tmap4=topTmap(1:50,52:101);
            TArray4(:,1)=Tmap4(:);
            TArray4(:,2)=1:2500;
            TArray4(:,3)=obj.TSVMark4(:);
            TArray4(:,4)=obj.channelMark4(:);
            TArray4=sortrows(TArray4);  
            
            counter=1;
            for i=1:2500
                if (TArray4(i,3)~=0)&&(TArray4(i,4)~=0)
                    [R4(counter),C4(counter)]=ind2sub(size(Tmap4),TArray4(i,2));
                    obj.TSVMark4(R4(counter),C4(counter))=0;
                    obj.channelMark4(R4(counter),C4(counter))=0;
                    counter=counter+1;
                end
                if counter>N
                    break;
                end
            end
            C4=C4+51;
        end  
        
        function obj=FillPart1(obj,R1,C1)
            for i=1:length(R1)
               obj.channel=fillChannel(obj.channel,R1(i),C1(i));
            end
        end

        function obj=FillPart2(obj,R2,C2)
            for i=1:length(R2)
               obj.channel=fillChannel(obj.channel,R2(i),C2(i));
            end
        end

        function obj=FillPart3(obj,R3,C3)
            for i=1:length(R3)
               obj.channel=fillChannel(obj.channel,R3(i),C3(i));
            end
        end  
        
        function obj=FillPart4(obj,R4,C4)
            for i=1:length(R4)
               obj.channel=fillChannel(obj.channel,R4(i),C4(i));
            end
        end 
        
        function obj=UpdateChannel(obj,tempChannel)
           obj.channel=tempChannel; 
        end
    end    
end

