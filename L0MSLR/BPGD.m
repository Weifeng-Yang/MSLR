%%  Use BPGD algorithm to implement MLR or MSLR 
function [w,b,losscor,loss,losstest,timerun,bts,auc]=BPGD(var,testvar,y,ytest,b,w,maxiteropt,num,lamda,stopindex,r,flag)
%% initialization algorithm
loss=[];
losscor=[];
losstest=[];
bts=[];

bsize=length(var);
testsize=length(testvar);
timerun=[0];
index=1;
tk=1;

wbt=(tk-1)/(tk);

LK=zeros(1,num+1);
L=ones(1,num+1);
wsize=sum(size(w{1}));
for i=1:num-1
    wsize=wsize+sum(size(w{i+1}));
end


wk=w;
bk=b;
[loss(1),~]=losscompute(var,w,num,b,y,bsize,lamda,1);
[losstest(1),losscor(1),auc(1)]=losscompute(testvar,w,num,b,ytest,testsize,lamda,2);
for i=1:num
    z{i}=zeros(size(w{i},2),1);
end

t1=clock;
for i=1:maxiteropt
%% update parameters    
randIndex = randperm(length(var));
[var,~,y,~]=shuffle(var,y,1,[],[],randIndex);
fprintf("%d\n",i);
randsor=randperm(num);
LtempK=LK;
LK=L;
wtempK=wk;
wk=w;
btempK=bk;
bk=b;
[w,b,L,bt]=BPGDupdate(var,w,num,bsize,b,y,index,lamda,r,L,LtempK,randsor,wtempK,btempK,wbt,flag);
[loss(i+1),~]=losscompute(var,w,num,b,y,bsize,lamda,1);
if(loss(i+1)>loss(i))
    [w,b,L]=BPGDupdate(var,w,num,bsize,b,y,index,lamda,r,L,LtempK,randsor,wtempK,btempK,0,flag);
end
[loss(i+1),~]=losscompute(var,w,num,b,y,bsize,lamda,1);
[losstest(i+1),losscor(i+1),auc(i+1)]=losscompute(testvar,w,num,b,ytest,testsize,lamda,2);


%% Check if termination condition is met
if(flag==1)
    fprintf("L1BPGD\n");
elseif(flag==0)
    fprintf("BPGD\n");
end
for j=1:num
    fprintf("nonzero:%d\n",nnz(w{j}~=0));
end
bts{i}=bt;
t2=clock;
timerun(i+1)=etime(t2,t1);
absloss=abs(loss(i+1)-loss(i));
fprintf("criteria：%d\n",absloss);
stop=stopcheck(absloss,timerun,stopindex);
if(stop==1)
    fprintf("Number of terminations：%d\n",i);
    pause(4);
    break;
end
tk=(1+sqrt(1+4*tk^2))/2;
wbt=(tk-1)/(tk);



end




end







