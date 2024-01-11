%% Termination condition checking function.
% absloss              : Decomposed residuals threshold 
% threshold            : Termination threshold
% timerun(end)>timeend : Where 'timeend' refers to the termination running time

function stop=stopcheck(absloss,timerun,stopindex)
    stop=0;
    threshold=1e-5;
    if(stopindex==1)
        if(timerun(end)>1000)
        stop=1;
        end

    elseif(stopindex==2) %%synthetic A
        if( absloss < threshold)
        stop=1;
        end
    end
end