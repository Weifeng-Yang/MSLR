%% Input.
% var         : Training set sample
% testvar     : Test set sample
% y           : Training set labels
% ytest       : Test set labels
% aa          : Maximum number of non-zero elements for each parameter vector
% The remaining parameters are explained the same as the 'main_Run_me' function

%% Output.
% ws and bs:  : The parameter vector tuple produced by the final iteration result
% loss:       : Array of training set loss functions generated during iteration
% losscor:    : Array of test set accuracies generated during iteration
% losstest:   : Array of test set loss functions generated during iteration
% tr:         : Runtime array during iteration
% btss and atz: An array of extrapolated parameters produced by each algorithm during iteration
%               where 'atz' represents the array of additional extrapolated parameters for IBPG
% auc         : Area Under the receiver operating characteristic Curve

function [data,ws,bs]=ALGOchoose(var,testvar,y,ytest,b,w,bt,maxiteropt,num,lamda,aa,flag,stopindex,r,tk,objs)
lossdata={};
losscors={};
wss={};

if(flag==1)
[ws,bs,losscor,loss,losstest,tr,bts,auc]=GIST(var,testvar,y,ytest,b,w,maxiteropt,lamda,aa,stopindex,r,0);

lossdata{1}=loss;
testloss{1}=losstest;
trdata{1}=tr;
losscors{1}=losscor;
btz{1}=bts;
wss{1}=ws;
bss{1}=bs;
aucs{1}=auc;

elseif(flag==2)
[ws,bs,losscor,loss,losstest,tr,bts,auc]=GIST(var,testvar,y,ytest,b,w,maxiteropt,lamda,aa,stopindex,r,1);

lossdata{1}=loss;
testloss{1}=losstest;
trdata{1}=tr;
losscors{1}=losscor;
btz{1}=bts;
wss{1}=ws;
bss{1}=bs;
aucs{1}=auc;


elseif(flag==3)
[ws,bs,losscor,loss,losstest,tr,auc]=GPGN(var,testvar,y,ytest,w,b,maxiteropt,lamda,aa,stopindex,r);
lossdata{1}=loss;
testloss{1}=losstest;
trdata{1}=tr;
losscors{1}=losscor;
btz{1}=0;
wss{1}=ws;
bss{1}=bs;
aucs{1}=auc;

elseif(flag==4)
[ws,bs,losscor,loss,losstest,tr,bts,auc]=BPGD(var,testvar,y,ytest,b,w,maxiteropt,num,lamda,stopindex,r,0);
lossdata{1}=loss;
testloss{1}=losstest;
trdata{1}=tr;
losscors{1}=losscor;
btz{1}=bts;
wss{1}=ws;
bss{1}=bs;
aucs{1}=auc;

elseif(flag==5)
[ws,bs,losscor,loss,losstest,tr,bts,auc]=BPGD(var,testvar,y,ytest,b,w,maxiteropt,num,lamda,stopindex,r,1);
lossdata{1}=loss;
testloss{1}=losstest;
trdata{1}=tr;
losscors{1}=losscor;
btz{1}=bts;
wss{1}=ws;
bss{1}=bs;
aucs{1}=auc;



elseif(flag==6)
for i=1:length(objs)
[ws,bs,losscor,loss,losstest,tr,bts,auc]=APALM(var,testvar,y,ytest,b,w,maxiteropt,bt,num,lamda,aa,stopindex,r,tk,objs(i));
lossdata{i}=loss;
testloss{i}=losstest;
trdata{i}=tr;
losscors{i}=losscor;
btz{i}=bts;
wss{i}=ws;
bss{i}=bs;
aucs{i}=auc;
end
end


data{1}=lossdata;
data{2}=trdata;
data{3}=aucs;
data{4}=testloss;
data{5}=losscors;
data{6}=btz;





end
