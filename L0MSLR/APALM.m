%%  Use APALM algorithm to implement L0_MSLR
function [w,b,losscor,loss,losstest,timerun,bts,auc]=APALM(var,testvar,y,ytest,b,w,maxiteropt,bt,num,lamda,aa,stopindex,r,tk,obj)
%% initialization algorithm
loss=[];
losscor=[];
losstest=[];
bts=[];
bsize=length(var);
testsize=length(testvar);
timerun=[0];
index=1;
btmax=0.999;

if(obj==1)
    tks=1;
    tk=(1+sqrt(1+4*tks^2))/2;
    bt=(tks-1)/tk;
elseif(obj==0)
    bt=0;
end


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
for j=1:num
      wv{j}=w{j}+bt*(w{j}-wk{j});
end
bv=b+bt*(b-bk);
wk=w;
bk=b;


%% Judging whether to extrapolate
ngaV=losscompute(var,wv,num,bv,y,bsize,lamda,1);
inci=chencknon(wv,aa,num);
if(loss(i)>ngaV && inci==0)
    w=wv;
    b=bv;
    if(obj==2)
    bt=min(btmax,bt*tk);
    elseif(obj==1)
    tks=tk;
    tk=(1+sqrt(1+4*tks^2))/2;
    bt=(tks-1)/tk;
    end
else
    w=wk;
    b=bk;
    if(obj==2)
    bt=bt/tk;
    elseif(obj==1)
    tks=tk;
    tk=(1+sqrt(1+4*tks^2))/2;
    bt=(tks-1)/tk;
    end
end

%% update parameters
[w,b]=APALMupdate(var,w,z,num,bsize,b,y,index,aa,lamda,r);
[loss(i+1),~]=losscompute(var,w,num,b,y,bsize,lamda,1);
[losstest(i+1),losscor(i+1),auc(i+1)]=losscompute(testvar,w,num,b,ytest,testsize,lamda,2);
bts(i)=bt;

%% Check if termination condition is met
fprintf("APALM\n");
for j=1:num
    fprintf("nonzero:%d\n",nnz(w{j}~=0));
end
t2=clock;
timerun(i+1)=etime(t2,t1);
absloss=abs(loss(i+1)-loss(i));
fprintf("criteria:%d\n",absloss);

stop=stopcheck(absloss,timerun,stopindex);
if(stop==1)
    fprintf("Number of terminations：%d\n",i);
    pause(4);
    break;
end

end


end







