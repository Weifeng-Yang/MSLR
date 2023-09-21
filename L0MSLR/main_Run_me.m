clear
clc

% Parameter.
%   index     : The data set to be used, when index=1, use first mode's synthetic dataset,
%               when index=2, use second mode's synthetic dataset, 
%               when index=3, use Concrete Crack Images for Classification dataset, 
%               when index=4, use GochiUsa-Faces dataset,
%               when index=5, use Br35H :: Brain Tumor Detection 2020 dataset.
%   bt        : Initial extrapolated parameter values for APGnc+, ABPL and ABPL+
%   btmax     : Maximum extrapolated parameter values for APGnc+, ABPL and ABPL+
%   t         : Decay and increment rates for extrapolated parameters for APGnc+, ABPL and ABPL+
%   r         : Step factor
%   maxiteropt: Maximum iteration alloted to the algorithm
%   trigger   : Whether to enable the indicator array of each algorithm, where
%               1∈trigger, enable the GIST algorithm
%               2∈trigger, enable the GPGN algorithm
%               3∈trigger, enable the BPGD algorithm
%               4∈trigger, enable the IBPG algorithm
%               5∈trigger, enable the BPL algorithm
%               6∈trigger, enable the APALM+ algorithm
%   objs      : Whether to enable APALM+'s adaptive momentum
%               1∈objs, enable the non-adaptive momentum
%               2∈objs, enable the adaptive momentum
%   percent   ：The proportion of non-zero elements of each decomposition matrix
%   stopindex : The indicator of the stop condition, set the specific termination condition, see the 'stopcheck' function for details, 
%               the default termination condition is: each algorithm runs for 400 seconds
%   trainsplit: The proportion of the training set to the total number of samples
%   lamda     ：The coefficient of the regularization term

% Output
%   criteria  : The difference in the training set loss function between two iterations.
%   gradcheck ：The difference in the gradient of the training set loss function between two iterations.

%% Parameter settings
rng('shuffle');
warning('off');
index=1;
bt=0.6;
r=1.5;
tk=1.3;
maxiteropt=6000000; 
trigger=[1,2,3,4,5,6];
objs=[1,2];
stopindex=3;
percent=0.3;
trainsplit=0.8;
lamda=[0.00002,0.00002,0.002];



%% Algorithm iteration starts
[ngmar,tar]=readfile(index);
num=length((size(ngmar)))-1;
for i=1:num
    aa(i)=round(size(ngmar,i+1)*percent,1, 'significant');
    if(aa(i)<1)
        aa(i)=1;
    end
end
[var,testvar,y,ytest]=shuffle(ngmar,trainsplit,tar,0);
w=init(var,num,aa);
b=rand(1);
for j=1:num
    fprintf("the num of parameter:%d\n",size(w{j},2))
    fprintf("nonzero:%d\n",sum(w{j}~=0));    
end
for i=1:length(trigger)
[datas{i},ws{i},bs{i}]=ALGOchoose(var,testvar,y,ytest,b,w,bt,maxiteropt,num,lamda,aa,trigger(i),stopindex,r,tk,objs);
end
datas{length(trigger)+1}=w;
datas{length(trigger)+2}=b;


%% Drawing
plt0=plotplt(datas,trigger);



