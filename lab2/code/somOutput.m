function [output] = somOutput(pattern)
global IW;

%compute negdistances between weights and patterns
Z = negdist(IW,pattern);  

%do "1" the greatest and "0" all the others
output = compet(Z);  


end

