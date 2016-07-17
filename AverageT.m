function [ Tavg ] = AverageT( test_case )
%AverageT :get the average T without the influence flowing liquid
%   generate all the four input channel
%   get the average

    fid=fopen('case_name','w');
    fprintf(fid,test_case);
    fclose(fid);

    Ttotal=zeros(101);
    for i=1:4
        channel=GenerateChannel(i);
         %% initial output Tmap
        dlmwrite('channel1.dat',channel,'\t');
        !./do_simulate.sh
        
        load output1.txt
        load output2.txt
        
        output1=TurnoverMatrix(output1);
        output2=TurnoverMatrix(output2);
        
        Ttotal=Ttotal+log(output1-300);
        Ttotal=Ttotal+log(output2-300);
    end
    Tavg=Ttotal;
end

