%% Parameter update function of GIST algorithm

function [w,b,loss]=GISTupdate(var,w,b,batch_size,y,index,lamda,tao,flag)

    for i=index:batch_size+index-1
     sgrad(i)=y(i)/(1+exp((w*var{i}'+b)*y(i)));
    end
    svar=cell2mat(var');
    grad=svar'*sgrad';
    grad=-grad';
    u=w-(grad+lamda*w)/tao;
%     w=u/(1/tao+1);
    if(flag==1)
    w=PROXn(u,0.5,1/tao);
    elseif(flag==0)
    w=u/(1/tao+1);
    end
    b=b-sgrad*y'/tao;
    loss=ONElosscompute(var,w,y,batch_size,b,lamda,1);

end

function x=PROXn(U,lamda,tao)
U=double(U);
indbig=find(U>tao*lamda);
indsmall=find(U<-tao*lamda);
x=zeros(size(U));
x(indbig)=U(indbig)-tao*lamda;
x(indsmall)=U(indsmall)+tao*lamda;
end