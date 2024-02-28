tem2=readmatrix("steady00_2.txt");
tem22=readmatrix("steady000_2.txt");
% tem6=readmatrix("6s.txt");
% tem66=readmatrix("6s2.txt");
% tem15=readmatrix("15s.txt");
% tem151=readmatrix("15s2.txt");
col1=[0 0.4470 0.7410];
col2=[0.8500 0.3250 0.0980];
col3=[0.9290 0.6940 0.1250];
col4=[0.4940 0.1840 0.5560];
col5=[0.4660 0.6740 0.1880];
col6=[0.3010 0.7450 0.9330];
col7=[0.6350 0.0780 0.1840];
col8=[203 148 117]/255;
col9=[37 125 139]/255;
col10=[124 77 119]/255;
col11=[64 183 173]/255;
col12=[52 24 62]/255;
col13=[130 9 59]/255;
col14=[88 93 94]/255;
ygridnumber1=200;ygridnumber2=500;
H1=0.02;H2=0.08;
deltay1=H1/ygridnumber1;
deltay2=H2/ygridnumber2;
H1=0.02;H2=0.08;
yaxis=[0,deltay1/2:deltay1:H1-deltay1/2,H1,H1+deltay2/2:deltay2:H1+H2-deltay2/2,H1+H2];
% scatter(yaxis(1:12:end),tem2(1:12:end,1),"^",MarkerEdgeColor=col1,MarkerFaceColor=col1,LineWidth=2.0,DisplayName="\it t=2s");
% hold on;
figure('Color','w');
plot(yaxis,tem2(:,1),"-^",'MarkerIndices',1:13:length(tem2(:,1)),MarkerEdgeColor=col13,MarkerFaceColor=col13,Color=col13,MarkerSize=6.0,LineWidth=3.0,displayName="\it convection and radiation");
hold on;
% scatter(yaxis(1:15:end),tem6(1:15:end,1),"d",MarkerEdgeColor=col7,MarkerFaceColor=col7,LineWidth=2.0,Color=col7,DisplayName="\it t=6s");
% hold on;
% plot(yaxis,tem66(:,1),"-.",LineWidth=2.0,Color=col7,displayName="\it t=6s nonradiation");
% hold on;
% scatter(yaxis(1:20:end),tem15(1:20:end,1),"o",MarkerEdgeColor=col2,MarkerFaceColor=col2,LineWidth=2.0,Color=col2,DisplayName="\it t=15s");
% hold on;
plot(yaxis,tem22(:,1),"-o",'MarkerIndices',1:13:length(tem2(:,1)),MarkerEdgeColor=col11,MarkerFaceColor=col11,Color=col11,MarkerSize=6.0,LineWidth=3.0,displayName="\it only convection");
xlabel("$Y[m]$",Interpreter="latex",FontSize=18);
ylabel("$T[K]$",Interpreter="latex",FontSize=18);
leg=legend;
leg.FontSize=15;
legend("boxoff");
legend("Location","northeast");
set(gca, 'LooseInset', [0,0,0,0]);