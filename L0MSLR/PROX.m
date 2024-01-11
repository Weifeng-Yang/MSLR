%% Proximal projection function
function [z,ind]=PROX(w,aa,z)
    if(aa>size(w,2))
    aa=size(w,2);
    end
    truea=aa;   
    [ind,~,~]=specomp(w,truea);
    z(ind)=w(ind); 
    z=z';
end

function [ind,list,IX]=specomp(w,truea)
list=abs(w);
[~,IX] = sort(list,'descend');
ind=IX(1:truea);

end