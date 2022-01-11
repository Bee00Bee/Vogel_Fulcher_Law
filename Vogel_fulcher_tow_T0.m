clear all; close all; clc; 
fontSize = 20;

clc
filename = sprintf('Tow vs T, 10 kHz.txt');
data = load(filename);

%% Vogel_fulcher_fit
T = data(1:end,1);
tow = data(1:end,2);
figure (1)
plot(T,tow,'*')
% Vogel_fulcher_fit(T,tow)



%% Find the best linear fit to ln(f_m) vs 1/(T-T0) to find the best R-squared value
Tstep = 100;
T0 = (linspace(200,330,Tstep/1))';
sz = size(T0);
row = size(T0,1);
col= size(T0,2);
sstot =  zeros(sz); ssres =  zeros(sz); rsquared =  zeros(sz);tow0 = zeros(sz);Ta = zeros(sz);
% figure(2)
for i=1:length(T0)
      y = log(tow);
      x = 1./(T-T0(i));
      P = polyfit(x, y,1);
      yfit = P(1)*x+P(2);
%       plot(x,yfit,'r-.',x,y,'o')
%       hold on
      xlabel( '1/(T-T0)', 'Interpreter', 'none' );
      ylabel( 'ln(f_m)', 'Interpreter', 'none' );
      polydata = polyval(P,x);
      sstot(i) = sum((y - mean(y)).^2);
      ssres(i) = sum((y - polydata).^2);
      rsquared(i)= 1 - (ssres(i) / sstot(i));
      Ta(i) = P(1);
      tow0(i) = exp(P(2));
end
figure(3)
plot(T0,rsquared,'--o')
Table1 = [T0,rsquared];[~,maxidx] = max(Table1);maximum_rsquared = Table1(maxidx,:);
fprintf('The best R-squared value:\n')
disp(maximum_rsquared)
Table2 = table(T0,rsquared,Ta,tow0);
writetable(Table2,'7.6-nm-To-Tow0-values.txt','Delimiter','\t','WriteRowNames',true);
