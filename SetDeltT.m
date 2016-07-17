function [ pressure ,DTreturn] = SetDeltT( test_case,DTset,channel)
%Return the pressure correspondding to the DeltaT and Thred you set
%  set Tthred by yourself 
     Tthred=0.1;

     dlmwrite('channel1.dat',channel,'\t');    
     
     fid=fopen('case_name','w');
     fprintf(fid,test_case);
     fclose(fid);
     
%%  Get Pmin and Pmax (the search domain)
     load Pin.dat
     Pnow=Pin(1);    
     DTnow=GetDeltaT(Pnow);
     % linear estimate
        Ptry =(DTnow/DTset)*Pnow;
        DTtry=GetDeltaT(Ptry);

        if((abs(DTtry-DTset))<Tthred)
          pressure = Ptry;
          DTreturn = DTtry;
          fprintf('\n DeltaT is :%f',GetDeltaT(pressure));
          return;
        else
          if(DTtry>DTset)
              Pmin=Ptry;
              Pmax=Pmin+1;
              while(1)
                 Pmax=Pmax+300;
                 DT=GetDeltaT(Pmax);
                 if ((abs(DT-DTset))<Tthred)
                     pressure = Pmax;
                     DTreturn = DT;
                     fprintf('\n DeltaT is :%f',GetDeltaT(pressure));
                     return;
                 end
                 if (DT< DTset)
                     break
                 end
              end            
          else
              Pmax=Ptry;
              Pmin=Pmax-1;
              while(1)
                  Pmin=Pmin-300;
                  DT=GetDeltaT(Pmin);
                  if ((abs(DT-DTset))<Tthred)
                     pressure = Pmin;
                     DTreturn = DT;
                     fprintf('\n DeltaT is :%f',GetDeltaT(pressure));
                     return;
                  end
                  if (DT>DTset)
                      break;
                  end
              end
          end
        end
        fprintf('\nPmin:%f, Pmax:%f\n',Pmin,Pmax);
%% Finally,get pressure        
      pressure=SearchPressure(Pmin,Pmax,DTset,Tthred);
      DTreturn=GetDeltaT(pressure);
      fprintf('\n DeltaT is :%f',DTreturn);
end

function DeltaT= GetDeltaT(pressure)
     load Pin.dat
     Pin(1)=pressure;
     dlmwrite('Pin.dat',Pin,'\t');     
     !./do_simulate.sh
     load output1.txt
     load output2.txt
     DeltaT=max(max(max(output1))-min(min(output1)),max(max(output2))-min(min(output2)));  
end

function [Pset] = SearchPressure(Pmin,Pmax,dTset,Tthred)
%Given the deltaT you want and the search domain, return the Pressure that:
%   abs(dt-dTset))<Tthreshold
%   you need to set the case name in file 'case_name'

    Pmid=(Pmin+Pmax)/2;
    dt  =GetDeltaT(Pmid);
    if((abs(dt-dTset))<Tthred)
        Pset = Pmid;
        return;
    else
        if (dt<dTset)
            Pset = SearchPressure(Pmin,Pmid,dTset,Tthred);
            return
        else
            Pset = SearchPressure(Pmid,Pmax,dTset,Tthred);
            return 
        end
    end
end