% threshold            : Decomposed residuals threshold, see Eq. (8) of the paper: 
% Globally Convergent Accelerated Algorithms for Multilinear Sparse Logistic Regression with $\ell_0$-constraints
% timerun(end)>timeend : Where 'timeend' refers to the termination running time

function stop=stopcheck(TOLgrad,absloss,stopgrad,timerun,stopindex)
    stop=0;
    threshold=1e-5;
    if(stopindex==1)
        if(timerun(end)>200)
        stop=1;
        end

    elseif(stopindex==2) 
        if(timerun(end)>300)
        stop=1;
        end
   elseif(stopindex==3)
        if(timerun(end)>400)
        stop=1;
        end

    elseif(stopindex==4) %%synthetic A
        if(timerun(end)>400 || absloss < threshold || stopgrad<TOLgrad)
        stop=1;
        end
   elseif(stopindex==5) %%CC, Anime and synthetic B
        if(timerun(end)>600 || absloss < threshold || stopgrad<TOLgrad)
        stop=1;
        end
    elseif(stopindex==6)%% BR
        if(timerun(end)>2000 || absloss < threshold || stopgrad<TOLgrad)
        stop=1;
        end
   elseif(stopindex==7)%% BR
        if(timerun(end)>1300)
        stop=1;
        end
    end
end