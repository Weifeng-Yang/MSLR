%% Calculate the target loss function, AUC and accuracy function in the form of vector data
%% losstemp: loss function.
%% losscor : Accuracy rate under current parameters. 
%% auc     : AUC under current parameters.

function [losstemp,losscor,auc]=ONElosscompute(var,w,y,bsize,b,lamda,inci)
losstemp=0;
losscor=0;
if(inci==1)
for j=1:bsize
    temp=log(1+exp(-(var{j}*w'+b)*y(j)));
    if(temp==inf)
        temp=-(var{j}*w'+b)*y(j);
        temp=temp-temp^2/2+temp^3/3;
    end
    tobj=temp;
    
    losstemp=losstemp+tobj;
end
losstemp=losstemp/bsize;
losstemp=losstemp+lamda/2*norm(w,2)^2;


elseif(inci==2)
    test_tar=zeros(1,bsize);
for j=1:bsize
    tempobj=var{j}*w'+b;
%     temp=log(1+exp(-(var{j}*w'+b)*y(j))); 
    temp=log(1+exp(-tempobj*y(j))); 
    if(temp==inf)
        temp=-(var{j}*w'+b)*y(j);
        temp=temp-temp^2/2+temp^3/3;
    end
    tobj=temp;
    if( tempobj>0)
        test_tar(j)=1;
        if( y(j)>0 )
        losscor=losscor+1;
        end
    elseif( tempobj<=0 && y(j)<=0)
        losscor=losscor+1;
    end
    losstemp=losstemp+tobj;
end
losscor=losscor/bsize*100;
losstemp=losstemp/bsize;
losstemp=losstemp+lamda/2*norm(w,2)^2;

auc=AUC(y,test_tar);
end

end

