clear all;  clc;
global IW distances tc;


%********************** MAKE YOUR CHOICES HERE ****************************
%Choose Patterns (1:CrossPatterns, 2(or otherwise):RingPatterns)
choose_pattern = 2;

%Choose gridSize = n x m 
n = 250; m = 1;

%Choose more Parameters
tuneND = 1;   orderLR = 0.9;   orderSteps = 250;   tuneLR = 0.01; 

%Choose tuning coefficient form 2 to 5
tc = 3;
%**************************************************************************



%**************************************************************************
%conditionally chosen pattern
if choose_pattern == 1
    CrossData;  PATTERNS = CrossPatterns; clear CrossPatterns;
else
    RingData;   PATTERNS = RingPatterns;  clear RingPatterns;
end
%extraction of critical variables
D = size(PATTERNS,1);
minMax = [ min(PATTERNS) ; max(PATTERNS) ];
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
figure; plot2DSomData(IW,distances,PATTERNS);
%**************************************************************************

    




















   