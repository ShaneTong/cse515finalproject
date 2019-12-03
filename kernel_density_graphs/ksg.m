close all
log_before = csvread('before_log_mean.csv');
log_after = csvread('after_log_mean.csv');
log_before_std = csvread('before_log_std.csv');
log_after_std = csvread('after_log_std.csv');
x1 = linspace(-5,10,50);
x2 = linspace(0,15,50);
truth = zeros(50,50);
for i = 1:50
    for j = 1:50
        truth(i,j) = branin([x1(i),x2(j)]);
    end
end
log_truth = log(truth);

% figure;imagesc(log_truth);
% figure;imagesc(log_after);

res_before = (log_before - truth)./log_before_std;
res_after = (log_after - log_truth)./log_after_std;

x = linspace(-3,3)';
y = normpdf(x);
figure;
plot(y)

[f_before, ~] = ksdensity(res_before(:));
[f_after, ~] = ksdensity(res_after(:));

figure;hold on;
plot(f_before);plot(y);hold off;
xlabel('$z$-score of the residual before taking log','Interpreter','latex');
set(gca, 'XTick', [1 50 100], 'XTickLabel', [-3 0 3]);
figure;hold on;
plot(f_after);plot(y);hold off;
xlabel('$z$-score of the residual after taking log','Interpreter','latex');
set(gca, 'XTick', [1 50 100], 'XTickLabel', [-3 0 3]);