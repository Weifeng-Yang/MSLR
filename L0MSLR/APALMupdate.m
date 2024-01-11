%% Parameter update function of APALM algorithm
function [w,b]=APALMupdate(var,w,z,num,batch_size,b,y,index,aa,lamda,r)
for j=1:num    
    [grad,tao,~]=compute(var,w,num,j,batch_size,b,y,index,1); 
    tao=tao+lamda(j);
    tao=r*tao;
    
    grad=grad';
      w{j}=w{j}-(grad+lamda(j)*w{j})/tao;
     [w{j},~]=PROX(w{j},aa(j),z{j});
end
    [~,tao,gradb]=compute(var,w,num,j,batch_size,b,y,index,2); 
     b=b-(gradb)/(r*tao);

end