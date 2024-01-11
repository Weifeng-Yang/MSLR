%% Tensor objective function value calculation function

function f=computeobj(f,w,~,b,y)
f = double(y*(ttm(f, w)+b));
end