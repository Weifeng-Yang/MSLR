%%  Use GIST algorithm to implement LR or SLR 
function [w,b,losscor,loss,losstest,timerun,bts,auc]=GIST(var,testvar,y,ytest,b,w,maxiteropt,lamda,aa,stopindex,r,flag)
%% initialization algorithm
loss=[];
losscor=[];
losstest=[];
bts=0;
[w,var,testvar,~,tao]=renorm(w,var,testvar,r,aa);
tao=tao/r;
bsize=length(var);
lamda=sum(lamda);
t=1.1;
taomax=2*tao;
testsize=length(testvar);

timerun=[0];
index=1;




[loss(1),~]=ONElosscompute(var,w,y,bsize,b,lamda,1);
[losstest(1),losscor(1),auc(1)]=ONElosscompute(testvar,w,ytest,testsize,b,lamda,2);
t1=clock;


for i=1:maxiteropt
%% update parameters

randIndex = randperm(length(var));
[var,~,y,~]=shuffle(var,y,1,[],[],randIndex);
fprintf("%d\n",i);
[w,b,loss(i+1)]=GISTupdate(var,w,b,bsize,y,index,lamda,tao,flag);
tao=min(tao*t,taomax);

[losstest(i+1),losscor(i+1),auc(i+1)]=ONElosscompute(testvar,w,ytest,testsize,b,lamda,2);

%% Check if termination condition is met
if(flag==1)
    fprintf("L1GIST\n");
elseif(flag==0)
    fprintf("GIST\n");
end
fprintf("nonzero:%d\n",nnz(w));
absloss=abs(loss(i+1)-loss(i));
fprintf("criteria:%d\n",absloss);
t2=clock;
timerun(i+1)=etime(t2,t1);
stop=stopcheck(absloss,timerun,stopindex);
if(stop==1)
    fprintf("Number of terminations：%d\n",i);
    pause(4);
    break;
end
end


end







