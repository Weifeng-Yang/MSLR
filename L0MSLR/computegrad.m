%% Tensor gradient value calculation function

function f=computegrad(f,w,num,n)
sa=1:num;
sa(n)=[];
f = ttm(f, w, sa); 
end