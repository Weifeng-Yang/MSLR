%% When iter=0, ngmar will use K-fold cross validation.
%% When iter=1, ngmar as a data set will only be scrambled.
%% The remaining parameters are explained the same as the 'main_Run_me' function
function [var,testvar,y,ytest]=shuffle(ngmar,tar,iter,kfold,j,randIndex)
var={};
y=[];
ytest=[];
testvar={};
if (iter==0)
        ytest=[];
        len=length(randIndex);
        splitceil=ceil(j/kfold*len);
        splitfloor=floor((j-1)/kfold*len);
        test_index=randIndex(splitfloor+1:splitceil);
        train_index=setdiff(randIndex,test_index);
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
    for i=1:length(randIndex)
    var{i}=ngmar{randIndex(i)};
    y(i)=tar(randIndex(i));
    end
end
end
