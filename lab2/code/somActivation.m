function [a]=somActivation(pattern,neighborDist)
global N distances;

%initialization
a=zeros(N,1);

%compute output from somoutput
winner_table = somOutput(pattern);

%find the winner as the row with value "1"
winner = find(winner_table == 1);

%find the neighbors as the closest to the winner
neighbors = find(distances(:,winner) <= neighborDist);

%make their value to be "0.5"   (also winner get this value now!!)
a(neighbors)=0.5;

%make the value of the winner "1"
a(winner)=1;

   
end



