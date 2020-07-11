function grad_P = grad_profit(h,Assets_value,Assets)
    %% Variables
    X = (circshift(Assets_value,-1)./Assets_value); % Growth matrix
    X(end,:) =[]; % Last row is deleted
    XA = X(:,Assets);
    X_Xn = XA-XA(:,end);
    X_Xn(:,end) = [];
    grad_P = sum(1./sum(XA.*h,2).*X_Xn); % Profit Calculation
end