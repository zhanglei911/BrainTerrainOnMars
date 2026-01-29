clear;
load("20260126_spacing.mat");       %"R_Spacing":   Depression Spacing fraction results of Phase-Separation.
load("20260126_width.mat");         %"R_Width":     Width fraction results of Phase-Separation.
load("Ratio_PS.mat");               %"Ratio_PS":    Area fraction results of Phase-Separation.

load("Ratio_MBT.mat");              %"Ratio_MBT":   Depression Area fraction results of observed MBT.
load("Spacing_MBT.mat");            %"Spacing_MBT": Depression Spacing results of observed MBT.
load("Width_MBT.mat");              %"Width_MBT":   Depression Width fraction results of observed MBT.

load("Limit_range.mat");            %"Limit_range": Depression threshold for depression(Simulated results)


load("F_BrainTerrain.mat");         %"Fig2F":       Elevation data of Fig2. F. (Detrended, see SI Appendix, Fig. S3)
load("G_BrainTerrain.mat");         %"Fig2F":       Elevation data of Fig2. G. (Detrended, see SI Appendix, Fig. S3)
load("H_BrainTerrain.mat");         %"Fig2F":       Elevation data of Fig2. H. (Detrended, see SI Appendix, Fig. S3)
load("I_PS.mat");                   %"Fig2I":       Elevation data of Fig2. I. (v_0 = 3.25, steps = 2400 in COMSOL Multiphysics)
load("J_PS.mat");                   %"Fig2J":       Elevation data of Fig2. J. (v_0 = 3.40, steps = 2400 in COMSOL Multiphysics)
load("K_PS.mat");                   %"Fig2K":       Elevation data of Fig2. K. (v_0 = 3.90, steps = 2400 in COMSOL Multiphysics)

load("Locations of MBT.mat");       %"loc":         The location of area with MBT (see SI Appendix, Fig. S5)
load("colormap.mat");
load("fusion.mat");

%Basic parameters used in extraction and analysis.

RegionWidth = 200;                  %The extration region width
Scanwidth = 50;                     %The scanning resolution
Ang_each = 5 ;                      %The angle of each rotation
PieceNumber = 36;                   %Number of cutting lines
PointDistance =0.25;                 %The tangential resolution
Reselution = 1;                     %Elevation data resolution
DTE = -0.2831;                      %Depression threshold for depression(MBT elvation)
select = 0.2831;                    %Depression threshold for depression(MBT extraction)

Angle_InternalFriction = 45;        %Angle of repose：(Θ),°
Space_Utilization = 0.6;            %Packing density：(η),1 or 100%
v_0 = 2.0:0.05:7.0;                 %maximum stone stransport velocity: mm/cycle
t_range = 100:100:10000;            %simulation steps in COMSOL Multiphysics
t_simulate = linspace(1e8,1e10,100);%The theoretical simulation steps of Phase-Separation
[c,h] = Calculate_StoneHeight(Angle_InternalFriction,Space_Utilization);%Theoretical stone piles model.
BasicELe = interp1(c,h,30);         %Initial height.
boundary = 93;                      %Effective data range


%Analysis of MBT morphology parameter extraction results in the study area.(see SI Appendix Fig. S6)
%Remove the data from the MBT-free area(SI Appendix, Fig. S5)
Spacing = Spacing_MBT.*loc;
Width  = Width_MBT.*loc;
Spacing(Spacing==0 ) = NaN;
Width( Width==0) = NaN;

%Calculate the average value of MBT morphological parameters in study area.
Average_Spacing = mean(Spacing(Spacing>0));
error_Spacing = std(Spacing(Spacing>0));
Average_Width = mean(Width(Width>0));
error_Width = std(Width(Width>0));
Normalized_Spacing = Spacing./mean(Spacing(Spacing>0));
Normalized_Width = Width./mean(Width(Width>0));

disp("Average Depression Spacing = " + Average_Spacing + "m");disp("Error of Depression Spacing= " + error_Spacing + "m");
disp("Average Depression Width = " + Average_Width + "m");disp("Error of Depression Width = " + error_Width + "m");



[R_S,Y_S,R_W,Y_W,R_S_erro,Y_S_erro,R_W_erro,Y_W_erro] = Analysis_RegionFeature2(Normalized_Spacing,Normalized_Width,Ratio_MBT,0.03);
print(gcf, '../SI Appendix, Figure S6CandD.png', '-dpng');


%Parameter calibration results (SI Appendix, Figs. S13A-F)

figure("position",[200,100,1200,700]);
subplot(2,3,1);surf(t_simulate,v_0(1:boundary),Ratio_PS(1:boundary,:),"EdgeColor","none");
view(0,90);xlim([1e8,1e10]);ylim([2,6.6]);xlabel("Step");ylabel("v_0");
title("Depression Area Fraction");colorbar;clim([0.05,0.6]);

subplot(2,3,2);surf(t_simulate,v_0(1:boundary),R_spacing(1:boundary,:),"EdgeColor","none");
view(0,90);xlim([1e8,1e10]);ylim([2,6.6]);xlabel("Step");ylabel("v_0");
title("Depression Spacing");colorbar;clim([5,50]);

subplot(2,3,3);surf(t_simulate,v_0(1:boundary),R_width(1:boundary,:),"EdgeColor","none");
view(0,90);xlim([1e8,1e10]);ylim([2,6.6]);xlabel("Step");ylabel("v_0");
title("Depression Width");colorbar;clim([1,20]);


subplot(2,3,4);hold on;
scatter(v_0(1:boundary),Ratio_PS(1:boundary,17),"filled");
scatter(v_0(1:boundary),Ratio_PS(1:boundary,25),"filled");
scatter(v_0(1:boundary),Ratio_PS(1:boundary,33),"filled");
xlabel("v_0");ylabel("Depression area fraction");xlim([2,5]);
yline(0.4);yline(0.1);
legend("steps = 1.7*10e9","steps = 2.5*10e9","steps = 3.3*10e9","Location","northwest");

subplot(2,3,5);hold on;
scatter(Ratio_PS(1:boundary,17),R_spacing(1:boundary,17),"filled");
scatter(Ratio_PS(1:boundary,25),R_spacing(1:boundary,25),"filled");
scatter(Ratio_PS(1:boundary,33),R_spacing(1:boundary,33),"filled");
xlabel("DAF");ylabel("Depression spacing");xlim([0,0.5]);
xline(0.1);xline(0.4);yline(27.1811);ylim([24,36]);
legend("steps = 1.7*10e9","steps = 2.5*10e9","steps = 3.3*10e9","Location","north");

subplot(2,3,6);hold on;
scatter(Ratio_PS(1:boundary,17),R_width(1:boundary,17),"filled");
scatter(Ratio_PS(1:boundary,25),R_width(1:boundary,25),"filled");
scatter(Ratio_PS(1:boundary,33),R_width(1:boundary,33),"filled");
xlabel("DAF");ylabel("Depression width");xlim([0,0.5]);
xline(0.1);xline(0.4);yline(7.8974);ylim([4,14]);
legend("steps = 1.7*10e9","steps = 2.5*10e9","steps = 3.3*10e9","location","southeast");

print(gcf, '../SI Appendix, Figures S13A-F.png', '-dpng');

%(SI Appendix, Figs. S13G and H)
figure();
ave_spacing = [];
ave_width = [];
region_l = 10; 
region_r = 40; 

for t = region_l:region_r      
    
    data_ratio = Ratio_PS(:,t);
    region =find( (data_ratio >= 0.1) & (data_ratio <= 0.4));
   
    data_spacing = R_spacing(region,t);
    d = data_spacing;
    d(isnan(d)) = [];
    ave_spacing(t) = mean(d);

    data_width = R_width(region,t);
    d = data_width;
    d(isnan(d)) = [];
    ave_width(t) = mean(d);
    
    data_spacing_normalized = data_spacing./ave_spacing(t);
    data_width_normalized = data_width/ave_width(t);

    subplot(2,1,1);
    scatter(Ratio_PS(region,t),data_spacing_normalized,"filled");
    hold on;xlabel("Depression Area Fraction");ylabel("Normalized Depression Spacing");
    subplot(2,1,2);
    scatter(Ratio_PS(region,t),data_width_normalized,"filled");
    hold on;xlabel("Depression Area Fraction");ylabel("Normalized Depression Width");
    
end
print(gcf, '../SI Appendix, Figures S13G-H.png', '-dpng');


%(SI Appendix, Figs. S13I and J)
figure("position",[500,100,800,700]);
subplot(2,1,1);scatter(t_simulate(region_l:region_r),ave_spacing(region_l:region_r),"filled");
yline(27.1811,"LineWidth",1.5);yline(0.95*27.1811);yline(1.05*27.1811);   
xlabel("Steps");ylabel("Average Depression Spacing of MBT");

subplot(2,1,2);scatter(t_simulate(region_l:region_r),ave_width(region_l:region_r),"filled");
yline(7.8974,"LineWidth",1.5);yline(0.95*7.8974);yline(1.05*7.8974);
xlabel("Steps");ylabel("Average Depression Width of MBT");
print(gcf, '../SI Appendix, Figures S13I and J.png', '-dpng');



%Extracted results from observed MBT and Numerical simulation.(MBT: Fig. 2F-H; Simulation: Fig. 2I-K)


figure(Position=[100,70,1200,800]);
subplot(3,3,1);surf(Fig2F,EdgeColor="none");axis equal;view(0,90);hold on;contour(Fig2F,[DTE,DTE],"white"); clim([-1,1]);colorbar;title("Fig. 2F: DAF = "+ Ratio_MBT(64,68));set(gca,"YDir","reverse");
[spacings,widths] = extraction_elevation(Fig2F,RegionWidth,PieceNumber,PointDistance,Ang_each,select);
subplot(3,3,2);histogram(spacings,BinWidth=2);xlim([0,60]);xlabel("Depression Spacing (m)");ylabel("Frequency");title("Average Spacing = " + mean(spacings)+" m");
subplot(3,3,3);histogram(widths,BinWidth=1);xlim([0,20]);xlabel("Depression Width (m)");ylabel("Frequency");title("Average Width = " + mean(widths)+" m");

subplot(3,3,4);surf(Fig2G,EdgeColor="none");axis equal;view(0,90);hold on;contour(Fig2G,[DTE,DTE],"white"); clim([-1,1]);colorbar;title("Fig. 2G: DAF = "+ Ratio_MBT(38,37));set(gca,"YDir","reverse");
[spacings,widths] = extraction_elevation(Fig2G,RegionWidth,PieceNumber,PointDistance,Ang_each,select);
subplot(3,3,5);histogram(spacings,BinWidth=2);xlim([0,60]);xlabel("Depression Spacing (m)");ylabel("Frequency");title("Average Spacing = " + mean(spacings)+" m");
subplot(3,3,6);histogram(widths,BinWidth=1);xlim([0,20]);xlabel("Depression Width (m)");ylabel("Frequency");title("Average Width = " + mean(widths)+" m");

subplot(3,3,7);surf(Fig2H,EdgeColor="none");axis equal;view(0,90);hold on;contour(Fig2H,[DTE,DTE],"white"); clim([-1,1]);colorbar;title("Fig. 2H: DAF = "+ Ratio_MBT(4,103));set(gca,"YDir","reverse");
[spacings,widths] = extraction_elevation(Fig2H,RegionWidth,PieceNumber,PointDistance,Ang_each,select);
subplot(3,3,8);histogram(spacings,BinWidth=2);xlim([0,60]);xlabel("Depression Spacing (m)");ylabel("Frequency");title("Average Spacing = " + mean(spacings)+" m");
subplot(3,3,9);histogram(widths,BinWidth=1);xlim([0,20]);xlabel("Depression Width (m)");ylabel("Frequency");title("Average Width = " + mean(widths)+" m");
colormap(CustomColormap);
print(gcf, '../Extraction results of MBTs.png', '-dpng');


figure(Position=[100,70,1200,800]);
subplot(3,3,1);surf(Fig2I,EdgeColor="none");axis equal;view(0,90);hold on;contour(Fig2I,[Limit_range(26),Limit_range(26)],"white"); clim([-0.1,0.1]);colorbar;title("Fig. 2I: DAF = "+ Ratio_PS(26,t));
[spacings,widths] = extraction_elevation(Fig2I,RegionWidth,PieceNumber,PointDistance,Ang_each,0.0857);
subplot(3,3,2);histogram(spacings,BinWidth=2);xlim([0,60]);xlabel("Depression Spacing (m)");ylabel("Frequency");title("Average Spacing = " + mean(spacings)+" m");
subplot(3,3,3);histogram(widths,BinWidth=1);xlim([0,20]);xlabel("Depression Width (m)");ylabel("Frequency");title("Average Width = " + mean(widths)+" m");

subplot(3,3,4);surf(Fig2J,EdgeColor="none");axis equal;view(0,90);hold on;contour(Fig2J,[Limit_range(32),Limit_range(32)],"white"); clim([-0.1,0.1]);colorbar;title("Fig. 2J: DAF = "+ Ratio_PS(32,t));
[spacings,widths] = extraction_elevation(Fig2J,RegionWidth,PieceNumber,PointDistance,Ang_each,0.0857);
subplot(3,3,5);histogram(spacings,BinWidth=2);xlim([0,60]);xlabel("Depression Spacing (m)");ylabel("Frequency");title("Average Spacing = " + mean(spacings)+" m");
subplot(3,3,6);histogram(widths,BinWidth=1);xlim([0,20]);xlabel("Depression Width (m)");ylabel("Frequency");title("Average Width = " + mean(widths)+" m");

subplot(3,3,7);surf(Fig2K,EdgeColor="none");axis equal;view(0,90);hold on;contour(Fig2K,[Limit_range(39),Limit_range(39)],"white"); clim([-0.1,0.1]);colorbar;title("Fig. 2K: DAF = "+ Ratio_PS(39,t));
[spacings,widths] = extraction_elevation(Fig2K,RegionWidth,PieceNumber,PointDistance,Ang_each,0.0857);
subplot(3,3,8);histogram(spacings,BinWidth=2);xlim([0,60]);xlabel("Depression Spacing (m)");ylabel("Frequency");title("Average Spacing = " + mean(spacings)+" m");
subplot(3,3,9);histogram(widths,BinWidth=1);xlim([0,20]);xlabel("Depression Width (m)");ylabel("Frequency");title("Average Width = " + mean(widths)+" m");
colormap(Fusion);
print(gcf, '../Extraction results of Simulation.png', '-dpng');


%The curve with error bars in Fig. 3
An_ratio = [];
An_spacing = [];
An_width = [];

for t = 19:29

    data_ratio = Ratio_PS(:,t);
    region =find( (data_ratio >= 0.1) & (data_ratio <= 0.4));
   
    data_spacing = R_spacing(region,t);
    d = data_spacing;
    d(isnan(d)) = [];
    ave_spacing(t) = mean(d);

    data_width = R_width(region,t);
    d = data_width;
    d(isnan(d)) = [];
    ave_width(t) = mean(d);
    
    data_spacing_normalized = data_spacing./ave_spacing(t);
    data_width_normalized = data_width./ave_width(t);
    data_ratio_normalized = data_ratio(region);

    An_ratio = [An_ratio;data_ratio_normalized];
    An_spacing = [An_spacing;data_spacing_normalized];
    An_width = [An_width;data_width_normalized];
end

[R_S_NS,Y_S_NS,R_W_NS,Y_W_NS,R_S_erro_NS,Y_S_erro_NS,R_W_erro_NS,Y_W_erro_NS] = Analysis_RegionFeature2(An_spacing,An_width,An_ratio,0.03);
print(gcf, '../Comparision with SI Appendix, Figure S6CandD.png', '-dpng');



%Comparison between extraction results (Fig. 3)
%Preprocessing
t = 24;
data_ratio = Ratio_PS(:,t);
region =find( (data_ratio >= 0.1) & (data_ratio <= 0.4));

data_spacing = R_spacing(region,t);d = data_spacing;
d(isnan(d)) = [];ave_spacing(t) = mean(d);

data_width = R_width(region,t);d = data_width;
d(isnan(d)) = [];ave_width(t) = mean(d);

data_spacing_normalized = R_spacing(:,t)./ave_spacing(t);
data_width_normalized = R_width(:,t)./ave_width(t);



figure("position",[200,300,1200,400]);
subplot(1,2,1);
x = R_S;y_upper = Y_S+Y_S_erro;y_lower = Y_S-Y_S_erro;
fill([x(3:13), fliplr(x(3:13))], [y_upper(3:13), fliplr(y_lower(3:13))], 'black', ...
     'FaceAlpha', 0.1, 'EdgeColor', 'none');
hold on;plot(R_S,Y_S,"LineWidth",2,"Color","black");

errorbar(R_S_NS,Y_S_NS,Y_S_erro_NS*2,'black','LineStyle','none','LineWidth',0.75);
scatter(R_S_NS,Y_S_NS,"filled","MarkerFaceColor",[0,0.447,0.741]);

scatter(Ratio_MBT(64,68),Normalized_Spacing(64,68),"filled","square","MarkerFaceColor","green");
scatter(Ratio_MBT(38,37),Normalized_Spacing(38,37),"filled","square","MarkerFaceColor","green");
scatter(Ratio_MBT(4,103),Normalized_Spacing(4,103),"filled","square","MarkerFaceColor","green");

scatter(Ratio_PS(26,24),data_spacing_normalized(26),"filled","square","MarkerFaceColor","blue");
scatter(Ratio_PS(32,24),data_spacing_normalized(32),"filled","square","MarkerFaceColor","blue");
scatter(Ratio_PS(39,24),data_spacing_normalized(39),"filled","square","MarkerFaceColor","blue");

xlim([0.09,0.35]);xlabel("Depression area fraction");ylabel("Normalized depression spacing");title("Fig. 3A");

subplot(1,2,2);
x = R_W;y_upper = Y_W+Y_W_erro;y_lower = Y_W-Y_W_erro;
fill([x(3:13), fliplr(x(3:13))], [y_upper(3:13), fliplr(y_lower(3:13))], 'black', ...
     'FaceAlpha', 0.1, 'EdgeColor', 'none');
hold on;plot(R_W,Y_W,"LineWidth",1.5,"Color","black");

errorbar(R_W_NS,Y_W_NS,Y_W_erro_NS*2,'black','LineStyle','none','LineWidth',0.75);
scatter(R_W_NS,Y_W_NS,"filled","MarkerFaceColor",[0,0.447,0.741]);

scatter(Ratio_MBT(64,68),Normalized_Width(64,68),"filled","square","MarkerFaceColor","green");
scatter(Ratio_MBT(38,37),Normalized_Width(38,37),"filled","square","MarkerFaceColor","green");
scatter(Ratio_MBT(4,103),Normalized_Width(4,103),"filled","square","MarkerFaceColor","green");

scatter(Ratio_PS(26,24),data_width_normalized(26),"filled","square","MarkerFaceColor","blue");
scatter(Ratio_PS(32,24),data_width_normalized(32),"filled","square","MarkerFaceColor","blue");
scatter(Ratio_PS(39,24),data_width_normalized(39),"filled","square","MarkerFaceColor","blue");

xlim([0.09,0.35]);xlabel("Depression area fraction");ylabel("Normalized depression width");title("Fig. 3B");

print(gcf, '../Figure3.png', '-dpng');




