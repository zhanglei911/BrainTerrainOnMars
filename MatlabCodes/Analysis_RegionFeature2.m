%获取区域整体的凹陷占比-凹陷间距 & 凹陷占比-凹陷宽度  关系图

function [R_S,Y_S,R_W,Y_W,R_S_erro,Y_S_erro,R_W_erro,Y_W_erro] = Analysis_RegionFeature2(Spacing,Width,Ratio,window)


xxx = Ratio(:);
sss = Spacing(:);
www = Width(:);


figure("position",[400,120,900,600]);

subplot(2,2,1);
scatter(xxx,sss,5,"filled");
ylabel("Normalized Depression spacing");
xlim([0,0.5]);
ylim([0.7,1.3]);

subplot(2,2,2);
scatter(xxx,www,5,"filled");
ylabel("Normalized Depression width");
xlim([0,0.5]);
ylim([0.5,1.5]);

subplot(2,2,3);
[R_S,Y_S,R_S_erro,Y_S_erro] = calculate_error(Ratio,Spacing,window);
errorbar(R_S,Y_S,Y_S_erro);
hold on;
errorbar(R_S,Y_S,R_S_erro,"horizontal");
xlim([0,0.5]);
ylim([0.7,1.3]);
ylabel("Normalized Depression spacing");

subplot(2,2,4);
[R_W,Y_W,R_W_erro,Y_W_erro] = calculate_error(Ratio,Width,window);
errorbar(R_W,Y_W,Y_W_erro);
hold on;
errorbar(R_W,Y_W,R_W_erro,"horizontal");
xlim([0,0.5]);
ylim([0.5,1.5]);
ylabel("Normalized Depression width");


subplot(2,2,3);
xlabel("Depression area fraction");
subplot(2,2,4);
xlabel("Depression area fraction");

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



