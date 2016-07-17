classdef SA
    % annealing parameters and actions
    %   Detailed explanation goes here
    
    properties
        initialAcceptRatio  %initial acceptance probability
        deltaTavg  % average change in deltaT
        Kmoves     % number of moves to try in each step
        Rcool      % ratio for the cooling schedule
        Rreject    % ratio of rejects at which to stop annealing
        Nmax       % absolute max number if annealing steps
        
        T          % initial temperature 
        Tcold      % final annealing temperature
    end
    
    methods
        function lo=SA(P0,Davg,Kmov,Rcol,Rrej,N)
            lo.initialAcceptRatio=P0;
            lo.deltaTavg=Davg;
            lo.Kmoves=Kmov;
            lo.Rcool=Rcol;
            lo.Rreject=Rrej;
            lo.Nmax=N;
            
            lo.T    =-Davg/log(P0);
            lo.Tcold=-Davg/log((1-Rrej)/2);
        end     
        
        % drop the T of annealing by Rcool
        function [obj]=DropSAT(obj)
            obj.T=obj.T*obj.Rcool;
        end
        
        % whether stopAnnealing        
        function [flag]=StopAnnealing(obj,rejectedStepOfT,totalStepOfT)
            if(rejectedStepOfT/totalStepOfT>obj.Rreject)
               flag=1; 
            else
               flag=0;
            end
        end
        
        % random choose action, fill or unfill
        function [flag]=RandomChooseAction(obj,p)
            % p:the probability for fill
            % flag=1: fill
            % flag=0: unfill
            a=rand();
            if  a<p 
                flag=1;
            else
                flag=0;
            end
        end
        
               
    end
    
end

