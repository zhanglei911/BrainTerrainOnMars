%获取区域整体的凹陷占比-凹陷间距 & 凹陷占比-凹陷宽度  关系图

function [R_S,Y_S,R_W,Y_W,R_S_erro,Y_S_erro,R_W_erro,Y_W_erro] = Analysis_RegionFeature(Spacing,Width,Ratio,window)


xxx = Ratio(:);
sss = Spacing(:);
www = Width(:);


figure();

subplot(2,2,1);
scatter(xxx,sss,3,"filled");
ylabel("Deprssion Spcaing");
xlim([0,0.5]);
ylim([20,35]);

subplot(2,2,2);
scatter(xxx,www,3,"filled");
ylabel("Deprssion Width");
xlim([0,0.5]);
ylim([4,12]);


subplot(2,2,3);
[R_S,Y_S,R_S_erro,Y_S_erro] = calculate_error(Ratio,Spacing,window);
errorbar(R_S,Y_S,Y_S_erro);
hold on;
errorbar(R_S,Y_S,R_S_erro,"horizontal");
xlim([0,0.5]);
ylim([20,35]);
ylabel("Deprssion Spcaing");

subplot(2,2,4);
[R_W,Y_W,R_W_erro,Y_W_erro] = calculate_error(Ratio,Width,window);
errorbar(R_W,Y_W,Y_W_erro);
hold on;
errorbar(R_W,Y_W,R_W_erro,"horizontal");
xlim([0,0.5]);
ylim([4,12]);
ylabel("Deprssion Width");



subplot(2,2,3);
xlabel("Depression Area Fraction");
subplot(2,2,4);
xlabel("Depression Area Fraction");



subplot(2,2,1);
yline(mean(Spacing(Spacing>0)));
subplot(2,2,3);
yline(mean(Spacing(Spacing>0)));
subplot(2,2,2);
yline(mean(Width(Width>0)));
subplot(2,2,4);
yline(mean(Width(Width>0)));



end


function [R,Y_mean,R_erro,Y_erro] = calculate_error(Ratio,Y,width)

    x = Ratio(:);
    y = Y(:);
    xrange = 0:width:max(x);
    R = xrange-width/2;
    R_erro = zeros(1,length(xrange));
    Y_erro = zeros(1,length(xrange));
    Y_mean = zeros(1,length(xrange));
    for i = 1:length(xrange)
        l = xrange(i);
        r = xrange(i)+width;
        loc = x>l&x<r;
        x_in = x(loc);
        y_in = y(loc);
        x_erro = std(x_in);
        y_erro = std(y_in);
        x_mean = mean(x_in);
        y_mean = mean(y_in);
        R(i) = x_mean;
        Y_mean(i) = y_mean;
        R_erro(i) = x_erro;
        Y_erro(i) = y_erro;
    end
    
end



