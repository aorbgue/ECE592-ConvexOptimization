function [opt_P,opt_h,error,num_it] = opt_profit(Assets_value,Assets,L_r,Tol)
    h_i = 0.5*ones(1, length(Assets)-1);
    h2 = [h_i, 1-sum(h_i)]; % Initial point
    num_it = 0; % Number of iterations
    error = 1; % Initial error
    while (error > Tol)
        grad_P = grad_profit(h2,Assets_value,Assets); % Gradient Calculation
        h_j = h_i + L_r*grad_P; % New h_i
        h2 = [h_j,1-sum(h_j)]; % New point
        if (sum(h_j)<0)
            h_j=zeros(1,length(Assets)-1);
            h2 = [h_j,1-sum(h_j)]; % New point
            break;
        end
        if (sum(h_j)>1)
            h_j=ones(1,length(Assets)-1);
            h2 = [h_j,1-sum(h_j)]; % New point
            break;
        end
        error = sum(abs(h_j-h_i));
        num_it = num_it + 1;
        h_i = h_j;
    end
    opt_P = profit(h2,Assets_value,Assets); % Optimal profit
    opt_h = h2; % Optimal proportion
end