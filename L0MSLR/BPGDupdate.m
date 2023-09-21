% Parameter update function of BPGD algorithm

function [w,b,gradcheck,L]=BPGDupdate(var,w,num,batch_size,b,y,index,lamda,r)

for j=1:num    
    [grad,tao,~]=compute(var,w,num,j,batch_size,b,y,index,1); 
    tao=tao+lamda(j);
    L(j)=tao;
    tao=r*tao;
    
    grad=grad';
      u=w{j}-(grad+lamda(j)*w{j})/tao;
      w{j}=u/(1/tao+1);
       gradcheck(j)=norm(grad)/batch_size;
end
    [~,tao,gradb]=compute(var,w,num,j,batch_size,b,y,index,2);
    L(num+1)=tao;
     b=b-(gradb)/(r*tao);

end