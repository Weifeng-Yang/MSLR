% Parameter update function of GIST algorithm

function [w,b,gradcheck,loss]=GISTupdate(var,w,b,batch_size,y,index,lamda,tao)

    for i=index:batch_size+index-1
     sgrad(i)=y(i)/(1+exp((w*var{i}'+b)*y(i)));
    end
    svar=cell2mat(var');
    grad=svar'*sgrad';
    grad=-grad';
    u=w-(grad+lamda*w)/tao;
    w=u/(1/tao+1);
    gradcheck=abs(grad)/batch_size;
    b=b-sgrad*y'/tao;
    loss=ONElosscompute(var,w,y,batch_size,b,lamda,1);

end