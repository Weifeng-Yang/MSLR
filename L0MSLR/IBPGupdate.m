% Parameter update function of IBPG algorithm

function [w,b,gradcheck,L,at,bt]=IBPGupdate(var,w,z,num,batch_size,b,y,index,aa,lamda,r,L,LK,randsor,wk,bk,wbt)
    sgrads=0;
    at=zeros(1,num);
    bt=at;
    m=unique(randsor,'stable');
    for i=1:num
    len=length(find(randsor==m(i)));
    j=m(i);
    at(j)=min(wbt(j),0.2*(r-1)/r*sqrt(LK(j)/L(j)));
    bt(j)=min(wbt(j),0.2*(r-1)*sqrt(LK(j)/L(j)));
    wv{j}=w{j}+at(j)*(w{j}-wk{j});
    wz{j}=w{j}+bt(j)*(w{j}-wk{j});
    wk{j}=w{j};
    [grad,tao,~,sgrads]=IBPGcompute(var,w,wz,num,j,batch_size,b,y,index,sgrads,1); 
    tao=tao+lamda(j);
    L(j)=tao;
    tao=r*tao;
    grad=grad';
    w{j}=wv{j}-(grad+lamda(j)*wz{j})/tao;
    [w{j},~]=PROX(w{j},aa(j),z{j});

        for k=1:len-1
        wv{j}=w{j}+at(j)*(w{j}-wk{j});
        wz{j}=w{j}+bt(j)*(w{j}-wk{j});
        wk{j}=w{j};

        [grad,~,~,~]=IBPGcompute(var,w,wz,num,j,batch_size,b,y,index,sgrads,3); 
        grad=grad';
         w{j}=wv{j}-(grad+lamda(j)*wz{j})/tao;
        [w{j},~]=PROX(w{j},aa(j),z{j});
        end

    gradcheck(j)=norm(grad)/batch_size;
    end

    at(num+1)=min(wbt(num+1),0.2*(r-1)/r*sqrt(LK(num+1)/L(num+1)));
    bt(num+1)=min(wbt(num+1),0.2*(r-1)*sqrt(LK(num+1)/L(num+1)));
    bv=b+at(num+1)*(b-bk);
    bz=b+bt(num+1)*(b-bk);
    [~,tao,bobj]=IBPGcompute(var,w,wz,num,j,batch_size,bz,y,index,sgrads,2);
    L(num+1)=tao;  
    b=bv-(bobj)/(r*tao);

end