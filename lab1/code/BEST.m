function [AC PR RE] = BEST( TrainData,TrainDataTargets,TestData,TestDataTargets, NoOfLayers)
%In this function we accept as inputs the Matrices of train dada, train
%data targets, test data, test dada targets, and the number of layers (one
%or two) we want to examine. The output is the Matrices of acuuracy ,
%precision and recall for every model we examined.


%*************FOR ONE HIDDEN LAYER EXAMINE FOR 5 TO 30 NODES **************
if  NoOfLayers == 1
    for i = 5:30;
    net = newff(TrainData,TrainDataTargets,i,{'tansig','tansig'},'traingdx','learngdm');
    net.divideParam.trainRatio = 0.8;
    net.divideParam.valRatio = 0.2;
    net.divideParam.testRatio = 0;
    net.trainParam.epochs = 300;
    net=train(net,TrainData,TrainDataTargets);
    TestDataOutput=sim(net,TestData);
    maxout = max(TestDataOutput);
    for k=1:size(TestDataOutput,2);
        TestDataOutput(:,k) = double(TestDataOutput(:,k) == maxout(k));
    end
    clear k; clear maxout;
    [AC(i),PR(:,i),RE(:,i)]= eval_Accuracy_Precision_Recall(TestDataOutput,TestDataTargets);
    end

end
%**************************************************************************



%******* FOR TWO HIDDEN LAYERS EXAMINE 5 TO 30 NODES FOR EACH LAYER *******
if  NoOfLayers == 2
    for i = 5:5:30
        for j = 5:5:30
        net = newff(TrainData,TrainDataTargets,[i j],{'tansig','tansig','tansig'},'traingdx','learngdm');
        net.divideParam.trainRatio = 0.8;
        net.divideParam.valRatio = 0.2;
        net.divideParam.testRatio = 0;
        net.trainParam.epochs = 300;
        net=train(net,TrainData,TrainDataTargets);
        TestDataOutput=sim(net,TestData);
        maxout = max(TestDataOutput);
        for k=1:size(TestDataOutput,2);
            TestDataOutput(:,k) = double(TestDataOutput(:,k) == maxout(k));
        end
        clear k; clear maxout;
        [AC(i,j),PR(:,i,j),RE(:,i,j)]= eval_Accuracy_Precision_Recall(TestDataOutput,TestDataTargets);
        end
        clear TestOutputData;
    end
%**************************************************************************
    
    
end

