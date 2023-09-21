%  All parameters of this function are explained the same as 'main_Run_me' and 'ALGOchoose' functions
function [w,b,losscor,loss,losstest,timerun,bts,rate,auc]=GIST(var,testvar,y,ytest,b,w,maxiteropt,lamda,aa,stopindex,r)
%% initialization algorithm
loss=[];
losscor=[];
losstest=[];
bts=0;
[w,var,testvar,aa,tao]=renorm(w,var,testvar,r,aa);
tao=tao/r;
bsize=length(var);
lamda=sum(lamda);
t=1.1;
taomax=10*tao;
testsize=length(testvar);

timerun=[0];
index=1;


wsize=sum(size(w));

TOL=(1e-6)*sqrt(wsize);
TOLgrad=(1e-6)*sqrt(wsize);
fprintf("TOL:%d\n",TOL);
rate=[];
wk=w;
bk=b;
[loss(1),~]=ONElosscompute(var,w,y,bsize,b,lamda,1);
[losstest(1),losscor(1),auc(1)]=ONElosscompute(testvar,w,ytest,testsize,b,lamda,2);
z=zeros(size(w,2),1);
t1=clock;


for i=1:maxiteropt
%% update parameters
[var,~,y,~]=shuffle(var,0,y,1);
fprintf("%d\n",i);
[w,b,gradcheck,loss(i+1)]=GISTupdate(var,w,b,bsize,y,index,lamda,tao);
tao=min(tao*t,taomax);

[losstest(i+1),losscor(i+1),auc(i+1)]=ONElosscompute(testvar,w,ytest,testsize,b,lamda,2);

%% Check if termination condition is met
stopgrad=sum(gradcheck);
fprintf("nonzero:%d\n",nnz(w));
absloss=abs(loss(i+1)-loss(i));
fprintf("GIST:criteria:%d\n",absloss);
t2=clock;
timerun(i+1)=etime(t2,t1);
rate(i)=absloss;
fprintf("gradcheck:%d\n",stopgrad);
stop=stopcheck(TOLgrad,absloss/bsize,stopgrad,timerun,stopindex);
if(stop==1)
    fprintf("Number of terminations：%d\n",i);
    pause(4);
    break;
end
end


end







