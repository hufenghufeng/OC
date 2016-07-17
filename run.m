tic
fid=fopen('mode.dat','w');
fprintf(fid,'1');
fclose(fid);
fid=fopen('step_num.dat','w');
fprintf(fid,'500');
fclose(fid);
%fillFourPart;
 findchannel;
%NewHBSS

% firstPhase=resultObj.deltaTMax;
% firstIndex=1:length(resultObj.deltaTMax);
% save firstPhase firstPhase;
% NewHBSS
fid=fopen('mode.dat','w');
fprintf(fid,'2');
fclose(fid);
fid=fopen('step_num.dat','w');
fprintf(fid,'350');
fclose(fid);
%NewHBSS
%fillFourPart;
findchannel;
% % secondPhase=resultObj.deltaTMax;
% % secondIndex=1:length(resultObj.deltaTMax);
% % load('firstPhase.mat')
% secondIndex=index_axis+firstIndex(firstIndex.length);
%figure(20);
% plot([firstPhase secondPhase]);
% NewHBSS
toc;