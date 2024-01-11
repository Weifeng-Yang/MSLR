clear
clc

%% Parameter. 
%   index     : The data set to be used, when index=1, use first mode's synthetic dataset,
%               when index=2, use second mode's synthetic dataset, 
%   bt        : Initial extrapolation parameter values for APALM+
%   btmax     : Maximum extrapolation parameter values for APALM+
%   tk         : Decay and increment rates for extrapolation parameters for APALM+
%   r         : Step factor
%   maxiteropt: Maximum iteration alloted to the algorithm
%   trigger   : Whether to enable the indicator array of each method, where
%               when 1∈trigger, enable the LR method
%               when 2∈trigger, enable the SLR method
%               when 3∈trigger, enable the L0SLR method
%               when 4∈trigger, enable the MLR method
%               when 5∈trigger, enable the MSLR method
%               when 6∈trigger, enable the L0MSLR method
%   kcross    : kcross - fold cross validation.
%   lamda     ：The parameter of the L2 regularization term
%   percent   ：The proportion of non-zero elements of each vector
%   stopindex : The indicator of the stop condition, set the specific termination condition, see the 'stopcheck' function for details,   
%               the default termination condition is: each method runs for ε<1e-5.

%% Display
%   nonzero   ：The number of non-zero elements in each component.
%   criteria  : The difference in the objective function value between two iterations.

%% Parameter settings
rng('shuffle');
warning('off');
index=1;
bt=0.6;
r=1.5;
tk=1.1;
maxiteropt=6000000; 
trigger=[1,2,3,4,5,6];
stopindex=2;
percent=0.35;
lamda=[0.002,0.002,0.002];
kcross=5;


%% method iteration starts
[ngmar,tar]=readfile(index);
num=length((size(ngmar)))-1;
for i=1:num
    aa(i)=ceil(size(ngmar,i+1)*percent);
    if(aa(i)<1)
        aa(i)=1;
    end
end

randIndex = randperm(size(ngmar,1));
for j=1:kcross
[var,testvar,y,ytest]=shuffle(ngmar,tar,0,kcross,j,randIndex);
w=init(var,num,aa);
b=rand(1);
for i=1:length(trigger)
[datas{i},ws{i},bs(i)]=ALGOchoose(var,testvar,y,ytest,b,w,bt,maxiteropt,num,lamda,aa,trigger(i),stopindex,r,tk,[2]);
end
w{num+1}=b;
datas{length(trigger)+1}=w;
datas{length(trigger)+2}=ws;
datas{length(trigger)+3}=bs;
datass{j}=datas;
w={};
ws={};
end

%% Drawing
plt0=pltt(datass);
