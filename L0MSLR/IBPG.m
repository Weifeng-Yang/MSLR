%  All parameters of this function are explained the same as 'main_Run_me' and 'ALGOchoose' functions
function [w,b,losscor,loss,losstest,timerun,bts,ats,rate,auc]=IBPG(var,testvar,y,ytest,b,w,maxiteropt,num,lamda,aa,stopindex,r)
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
for j=1:num+1
wbt(j)=(tk-1)/(tk);
end
LK=zeros(1,num+1);
L=ones(1,num+1);
wsize=sum(size(w{1}));
for i=1:num-1
    wsize=wsize+sum(size(w{i+1}));
end

TOL=(1e-6)*sqrt(wsize);
TOLgrad=(1e-6)*sqrt(wsize);

rate=[];
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
[var,~,y,~]=shuffle(var,0,y,1);
fprintf("%d\n",i);
randsor=randperm(num);
randlen=randi([floor(num/2),num],1);
randsor=[randsor,randsample([1:num], randlen,true)];
LtempK=LK;
LK=L;
wtempK=wk;
wk=w;
btempK=bk;
bk=b;
[w,b,gradcheck,L,at,bt]=IBPGupdate(var,w,z,num,bsize,b,y,index,aa,lamda,r,L,LtempK,randsor,wtempK,btempK,wbt);
[loss(i+1),~]=losscompute(var,w,num,b,y,bsize,lamda,1);
[losstest(i+1),losscor(i+1),auc(i+1)]=losscompute(testvar,w,num,b,ytest,testsize,lamda,2);


%% Check if termination condition is met
stopgrad=sum(gradcheck);
fprintf("IBPG\n");
for j=1:num
    fprintf("nonzero:%d\n",nnz(w{j}~=0));
end
bts{i}=bt;
ats{i}=at;
t2=clock;
timerun(i+1)=etime(t2,t1);
absloss=abs(loss(i+1)-loss(i));
rate(i)=absloss;
fprintf("criteria：%d\n",absloss);
fprintf("gradcheck:%d\n",stopgrad);
stop=stopcheck(TOLgrad,absloss/bsize,stopgrad,timerun,stopindex);
if(stop==1)
    fprintf("Number of terminations：%d\n",i);
    siter=i;
    pause(4);
    break;
end
tk=(1+sqrt(1+4*tk^2))/2;
for j=1:num+1
wbt(j)=(tk-1)/(tk);
end


end




end







