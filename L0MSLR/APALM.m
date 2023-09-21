%  All parameters of this function are explained the same as 'main_Run_me' and 'ALGOchoose' functions

function [w,b,losscor,loss,losstest,timerun,bts,rate,auc]=APALM(var,testvar,y,ytest,b,w,maxiteropt,bt,num,lamda,aa,stopindex,r,tk,obj)
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
end


wsize=sum(size(w{1}));
for i=1:num-1
    wsize=wsize+sum(size(w{i+1}));
end

TOL=(1e-6)*sqrt(wsize);
TOLgrad=(1e-6)*sqrt(wsize);
fprintf("TOL:%d\n",TOL);
wk=w;
bk=b;

[loss(1),~]=losscompute(var,w,num,b,y,bsize,lamda,1);
[losstest(1),losscor(1),auc(1)]=losscompute(testvar,w,num,b,ytest,testsize,lamda,2);
for i=1:num
    z{i}=zeros(size(w{i},2),1);
end


t1=clock;
for i=1:maxiteropt
[var,~,y,~]=shuffle(var,0,y,1);

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
if(loss(i)>=ngaV && inci==0)
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
[w,b,gradcheck]=paraupdate(var,w,z,num,bsize,b,y,index,aa,lamda,r);
[loss(i+1),~]=losscompute(var,w,num,b,y,bsize,lamda,1);
[losstest(i+1),losscor(i+1),auc(i+1)]=losscompute(testvar,w,num,b,ytest,testsize,lamda,2);
bts(i)=bt;

%% Check if termination condition is met
stopgrad=sum(gradcheck);
for j=1:num
    fprintf("nonzero:%d\n",nnz(w{j}~=0));
end
t2=clock;
timerun(i+1)=etime(t2,t1);
absloss=abs(loss(i+1)-loss(i));
rate(i)=absloss;
fprintf("APALM:criteria:%d\n",absloss);
fprintf("gradcheck:%d\n",stopgrad);
stop=stopcheck(TOLgrad,absloss/bsize,check,stopgrad,timerun,stopindex);
if(stop==1)
    fprintf("终止次数：%d\n",i);
    siter=i;
    pause(4);
    break;
end

end


end







