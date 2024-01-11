%% Calculate the target loss function, AUC and accuracy function in the form of tensor data
%% losstemp: loss function.
%% losscor : Accuracy rate under current parameters. 
%% auc     : AUC under current parameters.

function [losstemp,losscor,auc]=losscompute(var,w,num,b,y,bsize,lamda,inci)
losstemp=0;
losscor=0;
if(inci==1)
for j=1:bsize
    tobj=log(1+exp(-computeobj(var{j},w,num,b,y(j))));
    if(tobj==inf)
        tobj=-computeobj(var{j},w,num,b,y(j));
        tobj=tobj-tobj^2/2+tobj^3/3;
    end
    losstemp=losstemp+tobj;
end
losstemp=losstemp/bsize;
for i=1:num
     losstemp=losstemp+lamda(i)/2*norm(w{i},2)^2;
end


elseif(inci==2)
    test_tar=zeros(1,bsize);
for j=1:bsize
    tempobj=double((ttm(var{j}, w)+b));
    tobj=log(1+exp(-computeobj(var{j},w,num,b,y(j))));
    if(tobj==inf)
        tobj=-computeobj(var{j},w,num,b,y(j));
        tobj=tobj-tobj^2/2+tobj^3/3;
    end
    if( tempobj>0 )
        test_tar(j)=1;
         if(y(j)>0)
             losscor=losscor+1;
         end
    elseif( tempobj<=0 && y(j)<=0)
        losscor=losscor+1;
    end
    losstemp=losstemp+tobj;
end
losscor=losscor/bsize*100;
losstemp=losstemp/bsize;
for i=1:num
losstemp=losstemp+lamda(i)/2*norm(w{i},2)^2;
end
auc=AUC(y,test_tar);
end
end

