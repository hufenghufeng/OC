function [ ] = GenerateOutput( channel, setCoolingEnergy )
%run simulation under given cooling energy and channel. 
%   
    dlmwrite('channel1.dat',channel,'\t');
    !./do_simulate.sh
    
    load cooling_energy.dat
    load Pin.dat
    
    if cooling_energy<0.00001
        fprintf(stderr,'\nwrong channel, cooling energy is almost 0!');
    end
    
    Pin(1)=Pin(1)*sqrt(setCoolingEnergy/cooling_energy);
    dlmwrite('Pin.dat',Pin,'\t');
    !./do_simulate.sh     
end

