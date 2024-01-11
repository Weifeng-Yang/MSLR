%% Reshape parameters and variables into vector form (ie: traditional vector-based logistic regression)

function [w,var,testvar,aa,tao]=renorm(w,var,testvar,r,aa)
for i=1:size(w,2)
    w{i}=w{i}';
end
w=ktensor(w);
w=tensor(w);
w=double(reshape(w,[1,prod(size(w))]));
aa=prod(aa);

for i=1:length(var)
    var{i}=reshape(double(var{i}),1,prod(size(var{i})));
end
svar=cell2mat(var');
tao=(r*norm(svar,2)^2)/4;
for i=1:length(testvar)
    testvar{i}=reshape(double(testvar{i}),1,prod(size(testvar{i})));
end