function [fitresult, gof] = createFit(T, dTow)
%% Fit: 'untitled fit 1'.
[xData, yData] = prepareCurveData( T, dTow );

% Set up fittype and options.
ft = fittype( 'a*exp(b/(x-c))', 'independent', 'x', 'dependent', 'y' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Lower = [0.00000001 300 200];
opts.StartPoint = [1.8*10^(-1) 313 240];
opts.Upper = [1 500 300];

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );

% Plot fit with data.
figure( 'Name', 'untitled fit 1' );
h = plot( fitresult, xData, yData,'*' );
legend( h, 'dS vs. T', 'untitled fit 1', 'Location', 'NorthEast', 'Interpreter', 'none' );
% Label axes
xlabel( 'T', 'Interpreter', 'none' );
ylabel( 'Tow', 'Interpreter', 'none' );
grid on


