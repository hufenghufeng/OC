function [  ] = ShowCaseResults(case_name,height,pressure,channel_file)
%show results 

fid=fopen('case_name','w');
fprintf(fid,case_name);
fclose(fid);

dlmwrite('Pin.dat',[pressure height],'\t');

load channel_file
channel=;

figure(1)



end

