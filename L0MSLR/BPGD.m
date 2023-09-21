%  All parameters of this function are explained the same as 'main_Run_me' and 'ALGOchoose' functions

function [w,b,losscor,loss,losstest,timerun,bts,rate,auc]=BPGD(var,testvar,y,ytest,b,w,maxiteropt,num,lamda,aa,stopindex,r)
%% initialization algorithm
loss=[];
losscor=[];
losstest=[];
bts=[];
tk=1;
wbt=zeros(1,num+1);
LK=zeros(1,num+1);
L=ones(1,num+1);
for j=1:num+1
wbt(j)=(tk-1)/(tk);
end
bsize=length(var);
testsize=length(testvar);
timerun=[0];
index=1;
wsize=sum(size(w{1}));
for i=1:num-1
    wsize=wsize+sum(size(w{i+1}));
end


TOL=(1e-6)*sqrt(wsize);
TOLgrad=(1e-6)*sqrt(wsize);
fprintf("TOL:%d\n",TOL);
rate=[];
wk=w;
bk=b;


[loss(1),~]=losscompute(var,w,num,b,y,bsize,lamda,1);
[losstest(1),losscor(1),auc(1)]=losscompute(testvar,w,num,b,ytest,testsize,lamda,2);



t1=clock;

for i=1:maxiteropt
%% update parameters
[var,~,y,~]=shuffle(var,0,y,1);
fprintf("%d\n",i);
if(i>1)
for j=1:num   
    wbt(j)=min(wbt(j),0.9999*(r-1)/(2*r+2)*sqrt(LK(j)/L(j)));
    wv{j}=w{j}+wbt(j)*(w{j}-wk{j});
end
wbt(num+1)=min(wbt(num+1),0.9999*(r-1)/(2*r+2)*sqrt(LK(num+1)/L(num+1)));
bv=b+wbt(num+1)*(b-bk);
else
    wv=w;
    bv=b;
end
wk=w;
bk=b;
LK=L;
[w,b,gradcheck,L]=BPGDupdate(var,wv,num,bsize,bv,y,index,lamda,r);
[loss(i+1),~]=losscompute(var,w,num,b,y,bsize,lamda,1);
if(loss(i+1)>loss(i))
    [w,b,gradcheck,L]=BPGDupdate(var,wk,num,bsize,bk,y,index,lamda,r);
end
[losstest(i+1),losscor(i+1),auc(i+1)]=losscompute(testvar,w,num,b,ytest,testsize,lamda,2);


%% Check if termination condition is met
stopgrad=sum(gradcheck);
for j=1:num
    fprintf("nonzero:%d\n",nnz(w{j}~=0));
end
bts{i}=wbt;
t2=clock;
timerun(i+1)=etime(t2,t1);
absloss=abs(loss(i+1)-loss(i));
rate(i)=absloss;
fprintf("BPGD:criteria:%d\n",absloss);
fprintf("gradcheck:%d\n",stopgrad);
stop=stopcheck(TOLgrad,absloss/bsize,check,stopgrad,timerun,stopindex);
if(stop==1)
    fprintf("终止次数：%d\n",i);
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







