function somTrain (PATTERNS)
global maxNeighborDist tuneND orderLR tuneLR orderSteps tc;


%Computation of neighbor distance vector 
ND_vector = exp(linspace(log(maxNeighborDist),log(tuneND),orderSteps));
%Computation of learning rate vector
LR_vector = exp(linspace(log(orderLR),log(tuneLR),orderSteps));




%************************ Ordering phase ***********************************
w = waitbar(0, 'Ordering-Please Wait...'); 
for i=1:orderSteps                     %for every step
    learningRate = LR_vector(i);       %take the learning rate of this step
    neighborDist = ND_vector(i);       %and the neighbor distance
    
	for j=1:size(PATTERNS,2)
		pattern = PATTERNS(:,j);      %take one pattern from all
		somUpdate(pattern,learningRate,neighborDist); %and update the som
    end
waitbar(i/orderSteps);
end
close(w);
%**************************************************************************
    


%************************** Tuning phase ***********************************
w = waitbar(0, 'Tuning-Please Wait...');
for i = 1:tc*orderSteps                     %for tc times ordering steps
	for j = 1:size(PATTERNS,2)              %for every pattern
		pattern = PATTERNS(:,j);            %take one of them
		somUpdate(pattern,tuneLR,tuneND);   %and update the som
    end
waitbar(i/(tc*orderSteps));
end
close(w);
%**************************************************************************





