function P = profit(h,Assets_value,Assets)
    %% Variables
    X = (circshift(Assets_value,-1)./Assets_value); % Growth matrix
    X(end,:) =[]; % Last row is deleted
    P = sum(log(sum(X(:,Assets).*h,2))); % Profit Calculation
end