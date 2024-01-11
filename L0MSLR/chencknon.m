%% Check whether the parameters meets the L0 norm requirement
function flag=chencknon(w,aa,num)
flag=0;
 for i=1:num
     if(sum(w{i}~=0)>aa(i))
         flag=1;
         return;
     end
 end
end