%% 4) Toy Example
%% Parameters
N = 3000; % Number of periods
Assets = [1,2]; % Assest to be evaluated from Assets Matrix 
%% --- a) and b) Assets Matrix generation
X1 = ones(1,N);
X2 = repmat([1,2],[1,N/2]);
Xd = [X1',X2'];
% Investment vectors
ha_1 = [1,0]; % Investment vector for section a)
ha_2 = [0,1]; % Investment vector for section a)
hb = [0.5,0.5]; % Investment vector for section b)
%% Profit Calculation
Pa_1 = profit(ha_1,Xd,Assets);
Pa_2 = profit(ha_2,Xd,Assets);
Pb = profit(hb,Xd,Assets);
%% --- c) Assets Matrix generation
X3 = ones(1,N);
X4 = zeros(1,N);
X4(1) = (rand()>0.5)*1.5+0.5;
for i = 1:N-1
    X4(i+1) = X4(i)*((rand()>0.4)*1.5+0.5);
end
Xs = [X3',X4'];
hc = [0.5,0.5]; % Investment vector for section c)
%% Profit Calculation
Pc = profit(hc,Xs,Assets);
%% --- d) Optimization
alpha = 0.001; % Learning Rate gradiend descent
err_T = 0.0001; % Error Tolerance X(k+1)-X(k)
[Popt_d,hopt_d,err_d] = opt_profit(Xd,Assets,alpha,err_T); % Deterministic case
[Popt_s,hopt_s,err_s] = opt_profit(Xs,Assets,alpha,err_T); % Stochastic case
Ratio_2s = sum(((circshift(Xs(:,2),-1)./Xs(:,2))==2)); % Number of double profits

%% 5) Data Retrieval and Implementation
%% --- a) Data Preprocessing
filename = 'asset_prices.csv';
Assets_table = readtable(filename);
Assets_value = table2array(Assets_table(:,:));
%% --- b) Profit Calculation D=2
%% American Express and BPPIc
Assets = [1,3]; % Stocks 1 and 3       
[Popt_b1,hopt_b1,err_b1] = opt_profit(Assets_value,Assets,alpha,err_T); % Optimal 
%% Costco and Starbucks
Assets = [5,16]; % Stocks 5 and 16
[Popt_b2,hopt_b2,err_b2] = opt_profit(Assets_value,Assets,alpha,err_T); % Optimal 
%% --- 2c) Profit Calculation D=3
%% American Express, Cotsco and Tiffany Co
Assets = [1,5,18]; % Stocks 1, 15 and 18       
[Popt_c1,hopt_c1,err_c3] = opt_profit(Assets_value,Assets,alpha,err_T); % Optimal
%% BPPIc, Broadcom and Microsoft
Assets = [3,4,13]; % Stocks 3, 4 and 13       
[Popt_c2,hopt_c2,err_c2] = opt_profit(Assets_value,Assets,alpha,err_T); % Optimal
%% --- 2e) Brute Force Verification 
%% American Express and BPPIc
Assets = [1,3]; % Stocks 1 and 3       
Num = 101;
P = zeros(1,Num);
Pmax_b1 = 0;
for i=1:Num
    h = [(i-1),(Num-i)]/(Num-1);
    P(i) = profit(h,Assets_value,Assets);
    if (P(i)>=Pmax_b1)
        Pmax_b1 = P(i);
        hmax_b1 = h;
    end
end
%% Costco and Starbucks
Assets = [5,16]; % Stocks 5 and 16
Num = 101;
P = zeros(1,Num);
Pmax_b2 = 0;
for i=1:Num
    h = [(i-1),(Num-i)]/(Num-1);
    P(i) = profit(h,Assets_value,Assets);
    if (P(i)>=Pmax_b2)
        Pmax_b2 = P(i);
        hmax_b2 = h;
    end
end
%% American Express, Cotsco and Tiffany Co
Assets = [1,5,18]; % Stocks 1, 15 and 18       
Num = 101;
P = zeros(Num,Num);
Pmax_c1 = 0;
for j=1:Num
    T = Num-j+1;
    for i=1:T
        h = [(i-1),(T-i),j-1]/(Num-1);
        P(i,j) = profit(h,Assets_value,Assets);       
        if (P(i,j)>=Pmax_c1)
            Pmax_c1 = P(i,j);
            hmax_c1 = h;
        end
    end
end
%% BPPIc, Broadcom and Microsoft
Assets = [3,4,13]; % Stocks 3, 4 and 13       
Num = 101;
P = zeros(Num,Num);
Pmax_c2 = 0;
for j=1:Num
    T = Num-j+1;
    for i=1:T
        h = [(i-1),(T-i),j-1]/(Num-1);
        P(i,j) = profit(h,Assets_value,Assets);       
        if (P(i,j)>=Pmax_c2)
            Pmax_c2 = P(i,j);
            hmax_c2 = h;
        end
    end
end