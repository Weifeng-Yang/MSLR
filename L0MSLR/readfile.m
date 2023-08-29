function [ngmar,tar]=readfile(i)
   if (i==1)
    N=500;
    size=200;
    X=synthesize(N,-0.5,1,size);
    Y=synthesize(N,-0.5,-1,size);
    ngmar=double(cat(1,X,Y));

    tar=[zeros(1,N),ones(1,N)]';
   elseif (i==2)
    N=100;
    size=800;
    X=synthesize(N,-0.5,1,size);
    Y=synthesize(N,-0.5,-1,size);
    ngmar=double(cat(1,X,Y));
    tar=[zeros(1,N),ones(1,N)]';


  elseif(i==3)
   filename='.\data\ConcreteCracklabel.mat';
    E=load(filename);
    tar=E.tar; 
    filename='.\data\ConcreteCrack.mat';
    ngmar=load(filename).ngmar;  
  elseif(i==4)
   filename='.\data\Animelabel.mat'; %% city_building and container
    E=load(filename);
    tar=E.tar; 
    filename='.\data\Anime.mat';
    ngmar=load(filename).ngmar;  
 elseif(i==5)
   filename='.\data\Brain-Tumor-Detection.mat';
    ngmar=load(filename).ngmar;

    filename='.\data\Brain-Tumor-Detectionlabel.mat';
    E=load(filename);
    tar=E.tar; 
   end
    
end

function [ngmar,tar]=synthesize(N,labma,judge,nsize)
    A=randn(20);
    A=sign(judge)*A'*A;
    B=labma*eye(20);
    A=A+B;
%     w1=rand(1,20);
%     w2=rand(20,1);
%     check=w1*A*w2;

    ngmar=randn(N,nsize,nsize);
    for i=1:N
        ngmar(i,1:20,1:20)=A;
    end

end