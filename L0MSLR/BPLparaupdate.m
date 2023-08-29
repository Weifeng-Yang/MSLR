% Parameter update function of BPL algorithm

function [w,b,gradcheck,L]=BPLparaupdate(var,w,z,num,batch_size,b,y,index,aa,lamda,r)
randsor=randperm(num);

for i=1:num
 j=randsor(i);
    [grad,tao,~]=compute(var,w,num,j,batch_size,b,y,index,1); 
    tao=tao+lamda(j);
    L(j)=tao;
    tao=r*tao;
    
    grad=grad';
      w{j}=w{j}-(grad+lamda(j)*w{j})/tao;
     [w{j},~]=PROX(w{j},aa(j),z{j});
       gradcheck(j)=norm(grad);

end
    [~,tao,bobj]=compute(var,w,num,j,batch_size,b,y,index,2);
    L(num+1)=tao;
    
     b=b-(bobj)/(r*tao);

end