close all;
%*****CREATE THE NEURAL NETWORK, DEFINE PARAMETERS,TRAIN AND SIMULATE******
net = newff(TrainData,TrainDataTargets,[20 21],{'tansig','tansig','tansig'},'traingdx','learngdm');
net.divideParam.trainRatio = 0.8;                   %train Ratio
net.divideParam.valRatio = 0.2;                     %valuation Ratio
net.divideParam.testRatio = 0.0;                    %test ratio
net.trainParam.epochs = 300;                        %max number of epochs
net = train(net,TrainData,TrainDataTargets);        %train the network
%**************************************************************************


%****************************TEST IT***************************************
TestDataOutput = sim(net,TestData);                 %test it with the Test Data
%**************************************************************************


%******CHOSE THE HIGHEST VALUE FROM EVERY CLASS AND FORCE ITS VALUE******** 
%******TO ONE WHILE FORCING ALL THE OTHER VALUES OF THE CLASS TO ZERO******
maxout = max(TestDataOutput);
for i=1:size(TestDataOutput,2);
    TestDataOutput(:,i) = double(TestDataOutput(:,i) == maxout(i));
end
clear i; clear maxout;
%**************************************************************************



%*********** EVALUATE THE ACCURACY, PRECISION AND RECALL ******************
[accuracy,precision,recall]= ...
    eval_Accuracy_Precision_Recall(TestDataOutput,TestDataTargets);
%**************************************************************************


figure;
subplot(2,6,[1 7]); bar(accuracy); ylim([0 1]); 
title(['accuracy = ',num2str(round(1000*accuracy)/10),'%']);
subplot(2,6,[3 6]); bar(precision); title('precision');
subplot(2,6,[9 12]); bar(recall); title('recall');




