function [testCase,dTConst,TmaxConst,CE,channelIndex,stepNum ] = Configure( index )
% configure case-name height dTConst TmaxConst CE initialIndex step number
% from file
%   
[configure.casename, configure.height, configure.dTConst, configure.TmaxConst, configure.CE, configure.index, configure.stepNum]=textread('configure-case.txt','%s %d %f %f %f %d %d',6);

            testCase    =char(configure.casename(index ));
            height      =configure.height(index );
            dTConst     =configure.dTConst(index );
            TmaxConst   =configure.TmaxConst(index );
            CE          =configure.CE(index );
            channelIndex=configure.index(index );
            stepNum     =configure.stepNum(index );
            
            fid=fopen('case_name','w');
            fprintf(fid,testCase);
            fclose(fid);
            
            dlmwrite('height.dat',height,'\t');
            dlmwrite('cooling_energy.dat',CE,'\t');
            
            fprintf('\n*****************************\n');
            fprintf('case: %d\n',index);
            fprintf('case: %s\n',testCase);
            fprintf('height:%d\n',height);
            fprintf('dTConst:%f\n',dTConst);
            fprintf('TmaxConst:%f\n',TmaxConst);
            fprintf('CE:%f\n',CE);
            fprintf('channel index:%d\n',channelIndex);
            fprintf('step number:%d\n',stepNum);
            %fprintf(' case: %d\n case name:%s\n height:%d\n dTConst:%f\n TmaxConst:%f\n CE:%f\n channel index:%d\n step number:%d\n',index,configure.casename,configure.height,configure.dTConst,configure.TmaxConst, configure.CE, configure.index, configure.stepNum)
            fprintf('\n*****************************\n');
end

