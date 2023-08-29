function check=plotplt(datas,trigger)
mess={};
check=0;
color=["-o","-*","-+","-x","-p","-^","->","-s"];
for i=1:length(trigger)
data=datas{i};
lossdata=data{1};
trdata=data{2};
aucs=data{3};
testloss=data{4};
losscors=data{5};
btz=data{6};


if(trigger(i)==4 || trigger(i)==8)
atz=data{7};
else
    atz=0;
end

if(~isempty(lossdata))
mess=pltplt(testloss,lossdata,trdata,aucs,btz,atz,losscors,mess,trigger(i),color(i));
end
end

end

function mess=pltplt(testloss,lossdata,trdata,aucs,bts,atz,losscor,mess,trigger,color)

figure(1)
ss=20;
% color=["","","","","","","",""];
for i=1:length(lossdata)
    maker_idx = 1:ss:length(lossdata{i});
    plot(lossdata{i},color,'linewidth',0.9,'MarkerIndices',maker_idx);
    xlabel(['iter(count)']);
    ylabel('the objective funciton value');

%     if(trigger==1)
%     mes{i}='$IIHT$';
    
    if(trigger==1)
    mes{i}='$GIST$';
    elseif(trigger==2)
    mes{i}='$GPGN$';
    elseif(trigger==3)
    mes{i}='$BPGD$';
    elseif(trigger==4)
    mes{i}='$IBPG$';
    elseif(trigger==5)
    mes{i}='$BPL$';
    elseif(trigger==6)
           if(i==1)
            mes{i}='$APALM$';
        elseif(i==2)
            mes{i}='$APALM^{+}$';
       end
    end
    hold on;
end
ls=length(mess);
for j=1:length(mes)
    mess{j+ls}=mes{j};
end
h=legend(mess,'Interpreter','latex');
set(h,'FontSize',11)
figure(2)
for i=1:length(lossdata)
        maker_idx = 1:ss:length(lossdata{i});
    plot(trdata{i},lossdata{i},color,'linewidth',0.9,'MarkerIndices',maker_idx);
    xlabel('Time(seconds)','FontSize',30);
    ylabel('the objective funciton value','FontSize',30);
    hold on;
end
h=legend(mess,'Interpreter','latex');
set(h,'FontSize',11)
figure(3)
for i=1:length(lossdata)
    maker_idx = 1:ss:length(losscor{i});
    plot(trdata{i},aucs{i},color,'linewidth',0.9,'MarkerIndices',maker_idx);
    xlabel('Time(seconds)','FontSize',30);
    ylabel('Prediction AUC','FontSize',30);
    hold on;
end
h=legend(mess,'Interpreter','latex');
set(h,'FontSize',11)
    plt0=0;
end