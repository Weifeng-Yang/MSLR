% When iter=0, ngmar as a data set will be broken into training set and test set and scrambled, 
% when iter=1, ngmar as a data set will only be scrambled.
% The remaining parameters are explained the same as the 'main_Run_me' function
function [var,testvar,y,ytest]=shuffle(ngmar,trainsplit,tar,iter)
var={};
y=[];
ytest=[];
testvar={};
if (iter==0)
    ytest=[];
    randIndex = randperm(size(ngmar,1));
    len=length(randIndex);
    split=ceil(trainsplit*len);
    train_index=randIndex(1:split);
    test_index=randIndex(split+1:len);
    sizetemp=size(ngmar);
    sizetemp(1)=1;
    ngmar=reshape(ngmar,[size(ngmar,1),prod(size(ngmar))/size(ngmar,1)]);
    for i=1:length(train_index)
    var{i}=squeeze(tensor(reshape(ngmar(train_index(i),:),sizetemp)));
    y(i)=tar(train_index(i));
    end
    for i=1:len-length(train_index)
        testvar{i}=squeeze(tensor(reshape(ngmar(test_index(i),:),sizetemp)));
        ytest(i)=tar(test_index(i));
    end
elseif(iter==1)
    randIndex = randperm(size(ngmar,2));
    for i=1:length(randIndex)
    var{i}=ngmar{randIndex(i)};
    y(i)=tar(randIndex(i));
    end
end
end
