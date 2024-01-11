%% Parameter update function of GPGN algorithm

function [w,b,lossout]=GPGNupdate(var,w,b,z,batch_size,y,index,aa,lamda,sigma,tao,loss,t,inci)
    wk=w;
    loss=loss(end);
    check=1;
    for i=index:batch_size+index-1
     sgrad(i)=y(i)/(1+exp((w*var{i}'+b)*y(i)));
    end
    svar=cell2mat(var');
    grad=svar'*sgrad';
    grad=-grad';
    w=w-(grad+lamda*w)/tao;
    [w,ind]=PROX(w,aa,z);
    for i=index:batch_size+index-1
     sgrad(i)=y(i)/(1+exp((w*var{i}'+b)*y(i)));
    end
    b=b+sgrad*y'/tao;
    wloss=ONElosscompute(var,w,y,batch_size,b,lamda,1);
    
    while(wloss>loss-sigma/2*norm(w-wk,2)^2)
        tao=tao*t;
        w=w-(grad+lamda*w)/tao;
        [w,ind]=PROX(w,aa,z);
        for i=index:batch_size+index-1
        sgrad(i)=y(i)/(1+exp((w*var{i}'+b)*y(i)));
%      grad=grad+var{i}*sgrad(i);
        end
        b=b-sgrad*y'/tao;
        wloss=ONElosscompute(var,w,y,batch_size,b,lamda,1);
    end

    if(inci==2)
    if(isequal(find((wk~=0)),find(w~=0)))

        for i=index:batch_size+index-1
        sgrad(i)=y(i)/(1+exp((w*var{i}'+b)*y(i)));
        dgrad(i)=y(i)*exp((w*var{i}'+b)*y(i))/(1+exp((w*var{i}'+b)*y(i)))^2;
        end
        grad=svar'*sgrad';
        grad=-grad;
        dgrad=diag(dgrad');
        svarind=svar(:,ind);
%         grad2=svarind'*dgrad*svarind;
        svartemp=svarind'*dgrad;
        try
        grad2=svartemp*svarind;
        wv=zeros(size(w));
        grad2temp=double(grad2);
        temp=inv(grad2temp)*grad(ind);
        wv(ind)=w(ind)-temp';
        wvloss=ONElosscompute(var,wv,y,batch_size,b,lamda,1);
        check=wvloss-wloss;
        catch
            warning("out of memory, skipping Newton steps")
        end
    end
    end
   if(check<0)
            w=wv;
            lossout=wvloss;
   else
            lossout=wloss;
            
   end

end

