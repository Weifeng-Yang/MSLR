function [ngmar,tar]=readfile(i)
   if (i==1)
    N=500;
    size=200;
    X=synthesize(N,-0.5,1,size);
    Y=synthesize(N,-0.5,-1,size);
    ngmar=double(cat(1,X,Y));

    tar=[zeros(1,N),ones(1,N)]';
   elseif (i==2)
    N=200;
    size=400;
    X=synthesize(N,-0.5,1,size);
    Y=synthesize(N,-0.5,-1,size);
    ngmar=double(cat(1,X,Y));
    tar=[zeros(1,N),ones(1,N)]';
   end
    
end

function ngmar=synthesize(N,labma,judge,nsize)
    A=randn(20);
    A=sign(judge)*A'*A;
    B=labma*eye(20);
    A=A+B;
    ngmar=randn(N,nsize,nsize);
    for i=1:N
        ngmar(i,1:20,1:20)=A;
    end

end
