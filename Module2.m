% Gradient descent MatLab code
% Suppose we have a variety of funds with
%  1. known average returns,
%  2. known volatility
% Let us start with three
percentage_gains = [0.1, 0.3, 0.23];
volatility = [0.1, 0.5, 0.3];
% Our variables to optimize are the percentage we invest in each fund.
% Hence, these values must sum to 1. distribution = [x, y, 1 - x - y].
% Our initial guess is uniformly distributed.
distribution = [1/3, 1/3, 1/3];
% We want to maximize the gains.
epsilon = 0.01;
max_iterations = 5000;
portfolio_gains = [];
alpha =.9;
% Keep track of best distribution and maximum value of the function
best_x = 1/3;
best_y = 1/3;
best_func = 0;
for k = 1:3
    best_func = best_func + (1-alpha)*distribution(k)*percentage_gains(k) - alpha*distribution(k)^2*volatility(k);
end
for indx = 1:max_iterations
    % Compute derivatives
    dx = (1-alpha)*(percentage_gains(1)-percentage_gains(3))-alpha*(2*volatility(1)*best_x-2*volatility(3)*(1-best_x-best_y));
    dy = (1-alpha)*(percentage_gains(2)-percentage_gains(3))-alpha*(2*volatility(2)*best_y-2*volatility(3)*(1-best_x-best_y));
    % Update our distribution, but make sure values remain in [0, 1]
    distribution(1) = distribution(1) + epsilon*dx;
    if distribution(1) > 1
        distribution(1) = 1;
    end
    if distribution(1) < 0
        distribution(1) = 0;
    end
    distribution(2) = distribution(2) + epsilon*dy;
    if distribution(2) > 1
        distribution(2) = 1;
    end
    if distribution(2) < 0
        distribution(2) = 0;
    end
    distribution(3) = 1 - distribution(1) - distribution(2);
    % Keep track of portfolio value
    current_func = 0.;
    for k = 1:3
        current_func = current_func + (1-alpha)*distribution(k)*percentage_gains(k)-alpha*distribution(k)^2*volatility(k);
    end
    % If objective function value is larger, keep the best result
    if current_func > best_func
        best_func = current_func;
        best_x = distribution(1);
        best_y = distribution(2);
        % Keep track of the value at each step of gradient descent, so we can plot this later

        portfolio_gains = [portfolio_gains current_func];
    else
        % We are not making progress, so break
        break 
    end
end
% Plot our portfolio value after each iteration
plot(portfolio_gains)
% Print our investment distribution
disp(best_x);
disp(best_y);
disp(1 - best_x - best_y);
best_gain = distribution(1)*percentage_gains(1)+distribution(2)*percentage_gains(2)+distribution(3)*percentage_gains(3)