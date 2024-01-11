%% Functions for computing gradients and licpchitz constants for APALM, and BPGD

function [grad,tao,bobj]=compute(var,w,num,n,batch_size,b,y,index,inci)
    tao=0;
    grad=0;
    bobj=0;
    if(inci==1)
    for index=index:batch_size+index-1 
        sgrad=computegrad(var{index},w,num,n);
        sgrad=double(squeeze(sgrad));
        if(y(index)~=0)
        obj=computeobj(var{index},w,num,b,y(index));
        grad=grad+y(index)/(1+exp(obj))*sgrad;
        end
        tao=tao+(norm(sgrad,2)+1)^2;
    end
    grad=grad*(-1);
    tao=sqrt(2)*tao;
    elseif(inci==2)
    for index=index:batch_size+index-1 
        sgrad=computegrad(var{index},w,num,n);
        sgrad=double(squeeze(sgrad));
        if(y(index)~=0)
        obj=computeobj(var{index},w,num,b,y(index));
        bobj=bobj+y(index)/(1+exp(obj));
        end
        tao=tao+(norm(sgrad,2)+1)^2;
    end
    bobj=bobj*(-1);
    tao=sqrt(2)*tao;
    end  
end