%%  Functions for computing gradients and licpchitz constants for BPGD

function [grad,tao,bobj,sgrads]=BPGDcompute(var,w,wz,num,n,batch_size,b,y,index,sgrads,flag)
    if(flag==1)
    tao=0;
    grad=0;
    bobj=0;
    sgrads={};
    wztemp=wz{n};
    w{n}=wztemp;
    for index=index:batch_size+index-1
        sgrad=computegrad(var{index},w,num,n);
        sgrad=double(squeeze(sgrad));
        if(y(index)~=0)
        obj=computeobj(var{index},w,num,b,y(index));
        grad=grad+y(index)/(1+exp(obj))*sgrad;
        end
        tao=tao+(norm(sgrad,2)+1)^2;
        sgrads{index}=sgrad;
    end
    grad=grad*(-1)/batch_size;
    tao=sqrt(2)/batch_size*tao;
  elseif(flag==2)
    tao=0;
    grad=0;
    bobj=0;
    sgrads={};
   for index=index:batch_size+index-1
        sgrad=computegrad(var{index},w,num,n);
        sgrad=double(squeeze(sgrad));
        if(y(index)~=0)
        obj=computeobj(var{index},w,num,b,y(index));
        bobj=bobj+y(index)/(1+exp(obj));
        end
        tao=tao+(norm(sgrad,2)+1)^2;
   end
   bobj=bobj*(-1)/batch_size;
    tao=sqrt(2)/batch_size*tao;
    end
end