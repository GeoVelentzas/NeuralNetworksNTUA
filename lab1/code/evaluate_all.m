%*****************CLEAR ALL AND LOAD THE DATASET***************************
clear all; close all; clc;
load dataset;
%**************************************************************************


%*********COMPUTE THE NUMBER OF EXPERIENCES TO KEEP PER CLASS**************
sumT = sum(TrainDataTargets,2);
minvalue = min(sumT);
%**************************************************************************


%***********COMPUTE THE INDEXES TO KEEP FROM THE DATA MATRICES*************
indexesToKeep=[];
for i=1:12
    indexesToKeep =[indexesToKeep find(TrainDataTargets(i,:),minvalue)];
end
clear i; clear minvalue; clear sumT;
permutation = randperm(size(indexesToKeep,2));      %for a better training
indexesToKeep = indexesToKeep(permutation);         %we need to anakatepsoume
TrainDataTargets=TrainDataTargets(:,indexesToKeep); %the sequence of experiences
TrainData = TrainData(:,indexesToKeep);             %in the training data set
clear permutation; clear indexesToKeep;             % and training data targets
%**************************************************************************


%*************KEEP ONLY THE INFORMATION YOU NEED***************************
[TrainData,ps] = removeconstantrows(TrainData);     %remove constant rows in the TrD
TestData = removeconstantrows('apply',TestData,ps); %and apply in the TeD
clear ps;
[TrainData,ps] = processpca(TrainData,0.001);       %remove correlated components
TestData = processpca('apply',TestData,ps);         %in TrD and apply in the TeD
clear ps;
%**************************************************************************


%*****NORMALISE ALL THE LINES OF THE TRAIN DATA FROM -1 TO 1 IF NEEDED*****
%**********AND APPLY THE SAME RULES CREATED IN THE TEST DATA***************
[TrainData,ps] = mapminmax(TrainData);
TestData  = mapminmax('apply',TestData,ps);
clear ps;
TrainDataTargets = mapminmax(TrainDataTargets);
TestDataTargets = mapminmax(TestDataTargets);
%**************************************************************************


%******* COMPUTE FOR DIFFERENT NUMBER OF NODES USING BEST FUNCTION*********
[AC PR RE] = BEST(TrainData,TrainDataTargets,TestData,TestDataTargets,1);
%**************************************************************************


%*********************** SHOW THE ACCURACY ********************************
if size(AC,1)==1
    bar(AC); title('accuracy');
else
    bar3(AC);title('acurracy');
    xlabel('1st layer'); ylabel('2nd layer');
end
%**************************************************************************







