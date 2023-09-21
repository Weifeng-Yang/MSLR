%  All parameters of this function are explained the same as 'main_Run_me' and 'ALGOchoose' functions
function [w,b,losscor,loss,losstest,timerun,rate,auc]=GPGN(var,testvar,y,ytest,w,b,maxiteropt,num,lamda,aa,stopindex,r)
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
% batch=ceil(bsize/batch_size);
index=1;
t=1.01;
wsize=sum(size(w));


TOL=(1e-6)*sqrt(wsize);
TOLgrad=(1e-6)*sqrt(wsize);
fprintf("TOL:%d\n",TOL);

rate=[];
[loss(1),~]=ONElosscompute(var,w,y,bsize,b,lamda,1);
[losstest(1),losscor(1),auc(1)]=ONElosscompute(testvar,w,ytest,testsize,b,lamda,2);
z=zeros(size(w,2),1);
t1=clock;
for i=1:maxiteropt
%% update parameters
[var,~,y,~]=shuffle(var,0,y,1);
fprintf("%d\n",i);
wk=w;
[w,b,gradcheck,loss(i+1)]=GPGNupdate(var,w,b,z,bsize,y,index,aa,lamda,sigma,tao,loss,t,2);
[losstest(i+1),losscor(i+1),auc(i+1)]=ONElosscompute(testvar,w,ytest,testsize,b,lamda,2);

%% Check if termination condition is met
stopgrad=abs(gradcheck);
fprintf("GPGN:nonzero:%d\n",nnz(w));
t2=clock;
timerun(i+1)=etime(t2,t1);
absloss=abs(loss(i+1)-loss(i));
rate(i)=absloss;
fprintf("criteria:%d\n",absloss);
fprintf("gradcheck:%d\n",stopgrad);
stop=stopcheck(TOLgrad,absloss/bsize,stopgrad,timerun,stopindex);
if(stop==1)
    fprintf("Number of terminations：%d\n",i);
    siter=i;
    pause(4);
    break;
end


end




end







