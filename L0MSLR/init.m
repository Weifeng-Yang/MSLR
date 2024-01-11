%% Initialization parameters

function X=init(var,num,aaa)
ngmar=var{1};
for i=1:num
    aa=aaa(i);
    randIndex = randperm(size(ngmar,i));
    randIndex=randIndex(1:ceil(min(aa,size(ngmar,i))));
    Xs=randn(size(ngmar,i),1)';
    Xs1=zeros(size(ngmar,i),1);
    Xs1(randIndex)=Xs(randIndex);
    X{i}=Xs1';
end
end