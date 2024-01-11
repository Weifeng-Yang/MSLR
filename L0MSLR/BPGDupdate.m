%% Parameter update function of BPGD algorithm

function [w,b,L,bt]=BPGDupdate(var,w,num,batch_size,b,y,index,lamda,r,L,LK,randsor,wk,bk,wbt,flag)
    sgrads=0;
    bt=zeros(1,num);
    m=unique(randsor,'stable');
    for i=1:num
    j=m(i);

    bt(j)=min(wbt,(r-1)/(2*r+2)*sqrt(LK(j)/L(j)));
    wz{j}=w{j}+bt(j)*(w{j}-wk{j});
    wk{j}=w{j};
    [grad,tao,~,sgrads]=BPGDcompute(var,w,wz,num,j,batch_size,b,y,index,sgrads,1); 
    tao=tao+lamda(j);
    L(j)=tao;
    tao=r*tao;
    grad=grad';
    w{j}=wz{j}-(grad+lamda(j)*wz{j})/tao;
    if(flag==1)
    w{j}=PROXn(w{j},0.5,1/tao);
    elseif(flag==0)
    w{j}=w{j}/(1/tao+1);
    end
    end

    bt(num+1)=min(wbt,(r-1)/(2*r+2)*sqrt(LK(num+1)/L(num+1)));

    bz=b+bt(num+1)*(b-bk);
    [~,tao,bobj]=BPGDcompute(var,w,wz,num,j,batch_size,bz,y,index,sgrads,2);
    L(num+1)=tao;  
    b=bz-(bobj)/(r*tao);

end

function x=PROXn(U,lamda,tao)

U=double(U);
indbig=find(U>tao*lamda);
indsmall=find(U<-tao*lamda);
x=zeros(size(U));
x(indbig)=U(indbig)-tao*lamda;
x(indsmall)=U(indsmall)+tao*lamda;
end
