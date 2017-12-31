clear all; close all; clc;
global IW distances tc gridSize a winner_neurons positions;



%% ********************            3A              ************************
%**************************************************************************
%load the given mat file
load('NIPS500.mat');

%every document is a pattern and the weights of each docmument the vector
PATTERNS = tfidf(Patterns)';

%visualization of weights per document
%bar3(PATTERNS);
%**************************************************************************






%% ********************            3B              ************************
%********************** MAKE YOUR CHOICES HERE ****************************
%Choose gridSize = n x m 
n = 7; m = 8;

%Choose more Parameters
tuneND = 1;   orderLR = 0.9;   orderSteps = 250;   tuneLR = 0.01;
%Choose tuning coefficient form 2 to 5
tc = 2;
%**************************************************************************



%**************************************************************************
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
figure;somShow(IW,gridSize);
%**************************************************************************



%% ********************            3C              ************************

%********************************* (i) ************************************
%find how many times each neuron was a winner through patterns
winners = zeros(n*m,1);
for i=1:size(PATTERNS,2)
    wins = somOutput(PATTERNS(:,i));
    winners = winners + wins;
end

%find the percentance
wp = (winners/size(PATTERNS,2))*100;

%show the results
figure; bar(wp);
title(' % percentance of documents for each neuron ')
xlim([1 n*m]);
%**************************************************************************


%**********************************(ii)************************************
IW2 = IW;
meg = zeros(n*m,2);
for i = 1:(n*m)
    meg(i,1) = find(IW(i,:) == max(IW(i,:)));
    IW2(i,meg(i,1)) = -Inf;
    meg(i,2) = find(IW2(i,:) == max(IW2(i,:)));
end


figure;
for i = 1:(n*m)
    text(positions(1,i),positions(2,i),['',terms(meg(i,1)),terms(meg(i,2)),'']);
    hold on
end
    
xlim([min(positions(1,:))-1 max(positions(1,:))+1])
ylim([min(positions(2,:))-1 max(positions(2,:))+1])
title('3 ii');
%**************************************************************************



%******************************** iii *************************************
%T = char(terms);
%machin = (T(:,1)=='m')&(T(:,2)=='a')&(T(:,3)=='c')&(T(:,4)=='h')&(T(:,5)=='i')&(T(:,6)=='n');
%learn = (T(:,1)=='l')&(T(:,2)=='e')&(T(:,3)=='a')&(T(:,4)=='r')&(T(:,5)=='n');

M = max(IW(:,135));
ind_machin = find(IW(:,135)>M*0.5);

L = max(IW(:,2));
ind_learn = find(IW(:,2)>L*0.5);

figure; hold on; box on;

for i =1:length(ind_machin)
    text(positions(1,ind_machin(i)),positions(2,ind_machin(i)),'X');
end

for i =1:length(ind_learn)
    text(positions(1,ind_learn(i)),positions(2,ind_learn(i)),'0');
end

xlim([min(positions(1,:))-1 max(positions(1,:))+1])
ylim([min(positions(2,:))-1 max(positions(2,:))+1])
title('3 iii');
%**************************************************************************


%****************************** 3iv ***************************************
ind_all = find((IW(:,135)>M*0.5)&(IW(:,2)>L*0.5));
Megisti = max(IW(:));

MO = (IW(ind_all,:)/Megisti)*100;

figure;
bar3(ind_all,MO)
axis square
shading interp
title('% for all weights of chosen neurons')

figure;
bar(ind_all,(MO(:,2:133:135)))
title('% weights for "learn" and "machin" ');
legend('learn','machin')




%********************************** 3v ************************************
for i = 1:size(MO,1)
    [sorted_MO(i,:) indexes(i,:) ]= sort(MO(i,:),'descend');
    sorted_terms{i,:} = terms(indexes(i,:));
end

figure;
bar3(ind_all,sorted_MO)
axis square
shading interp
title('sorted % weights of chosen neurons')

%**************************************************************************














