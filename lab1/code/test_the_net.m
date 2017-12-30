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