%% Draw a histogram with error bars after K-fold cross validation.
function plt0=pltt(datass1)
datasss=datass1;

lossdatas=[];
tr=[];


for k=1:length(datasss)
datass=datasss{k};
wdatas=datass{end-1};
for i=1:length(datass)-3
    datas=datass{i};
    adata=datas{3};
    cdata=datas{5};
    lsdata=datas{1};
    wdata=wdatas{i};
    if(iscell(wdata))
        for j=1:length(wdata)
            paraden(i,j)=nnz(wdata{j})/numel(wdata{j});
        end
    else
        paraden(i,1)=nnz(wdata)/numel(wdata);
    end
    trdata=datas{2};
    for j=1:length(lsdata)
        losstemp=lsdata{j};  
        trtemp=trdata{j};
        auctemp=adata{j};
        acctemp=cdata{j};
        aucdatas(i,j)=auctemp(end);
        accdatas(i,j)=acctemp(end);
        lossdatas(i,j)=losstemp(end);
        timedatas(i,j)=trtemp(end);
    end
end
paradatas{k}=paraden;
lossdata{k}=lossdatas;
timedata{k}=timedatas;
% ratedata{k}=rtdatas;
aucdata{k}=aucdatas;
accdata{k}=accdatas;
aucdatas=[];
accdatas=[];
lossdatas=[];
btdata=[];
atdata=[];

tr=[];
rate=[];
end


lossmean=zeros(size(lossdata{1}));
timemean=lossmean;
aucmean=lossmean;
accmean=lossmean;
count=lossmean;
paramean=0;
aucdatas=[];
lossdatas=[];
index=[];
for i=1:length(datasss)
    aucmean=aucmean+aucdata{i}/length(datasss);
    aucdatas(i,1:length(aucdata{i}))=aucdata{i};
    
end

neg = std(aucdatas);
negs=flip(neg);
pos=negs;
x=1:size(aucmean,1)';
figure;
aucmeans=flip(aucmean);
b =bar(x,  aucmeans,0.4);
b.FaceColor = 'flat';
b.CData(6,:) = [.2 1 .2];
b.CData(5,:) = [.4 0.8 .4];
b.CData(4,:) = [.5 0.6 .5];
b.CData(3,:) = [.9 0.5 .7];
b.CData(2,:) = [.9 0.3 .5];
b.CData(1,:) = [.5 0.1 .5];
hold on
errorbar(x, aucmeans, negs, pos,'LineStyle', 'none', 'Color', 'k', 'LineWidth', 2);

mess{6}='LR';
mess{5}='SLR';
mess{4}='ℓ0-SLR';
mess{3}='MLR';
mess{2}='MSLR';
mess{1}='ℓ0-MSLR';
set(gca,'FontSize',60,'YTick', 0:0.2:1)
set(gca,'linewidth',2);
axis([0.5 6.5 0 1]);
set(gca,'XTickLabel',mess,'XTickLabelRotation',40)

ylabel('AUC','FontSize',60)
plt0=1;
end
