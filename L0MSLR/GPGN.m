%%  Use BPGD algorithm to implement L0_SLR 
function [w,b,losscor,loss,losstest,timerun,auc]=GPGN(var,testvar,y,ytest,w,b,maxiteropt,lamda,aa,stopindex,r)
%% initialization algorithm
loss=[];
losscor=[];
losstest=[];

[w,var,testvar,aa,tao]=renorm(w,var,testvar,r,aa);
sigma=0.1;
bsize=length(var);
lamda=sum(lamda);
testsize=length(testvar);
timerun=[0];
index=1;
t=1.01;



[loss(1),~]=ONElosscompute(var,w,y,bsize,b,lamda,1);
[losstest(1),losscor(1),auc(1)]=ONElosscompute(testvar,w,ytest,testsize,b,lamda,2);
z=zeros(size(w,2),1);
t1=clock;
for i=1:maxiteropt
%% update parameters
randIndex = randperm(length(var));
[var,~,y,~]=shuffle(var,y,1,[],[],randIndex);
fprintf("%d\n",i);
wk=w;
[w,b,loss(i+1)]=GPGNupdate(var,w,b,z,bsize,y,index,aa,lamda,sigma,tao,loss,t,2);
[losstest(i+1),losscor(i+1),auc(i+1)]=ONElosscompute(testvar,w,ytest,testsize,b,lamda,2);

%% Check if termination condition is met
fprintf("GPGN\n");
fprintf("nonzero:%d\n",nnz(w));
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







