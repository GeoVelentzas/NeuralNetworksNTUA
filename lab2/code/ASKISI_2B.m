clear all;  close all; clc;
global IW distances tc;


%********************** MAKE YOUR CHOICES HERE ****************************
%Choose gridSize = n x m 
n = 10; m = 10;

%Choose more Parameters
tuneND = 1;   orderLR = 0.9;   orderSteps = 250;   tuneLR = 0.01; 

%Choose tuning coefficient form 2 to 5
tc = 3;
%**************************************************************************



%**************************************************************************
%GroupData pattern
GroupData;  PATTERNS = GroupPatterns; clear GroupPatterns;

%extraction of critical variables
D = size(PATTERNS,1);
minMax = [min(PATTERNS,[],2) max(PATTERNS,[],2)]; 
%**************************************************************************    



%***************************** SOM CREATION *******************************
gridSize = [n m];
somCreate(minMax,gridSize);
%**************************************************************************



%*********************** PARAMETERS AND TRAINING **************************
somTrainParameters(orderLR,orderSteps,tuneLR);
somTrain(PATTERNS);
%**************************************************************************



%********************* VISUALIZING THE RESULTS ****************************
for i=1:size(PATTERNS,2)
    plot3(PATTERNS(1,i),PATTERNS(2,i),PATTERNS(3,i),'k+'); hold on; 
end

for i=1:size(IW,1);
    plot3(IW(i,1),IW(i,2),IW(i,3),'ro'); hold on;
end
zlim([1 2]);
axis square; box on;


figure;somShow(IW,gridSize);
%**************************************************************************


group1 = sum(PATTERNS(3,:)==1);
group2 = sum(PATTERNS(3,:)==2);


weights1 = sum(IW(:,3)<1.3);
weights2 = sum(IW(:,3)>1.7);

%biased to class1 if more than 1
disp('biased more than 1.2 times to group1 if more than 0.25 and to group2 if less than -0.25')
bias = log2((weights1/weights2)/(group1/group2))







