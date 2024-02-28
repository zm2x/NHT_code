%% parameter setting
epsi=0;sig=5.67e-8;Tf1=360;Tf2=280;hf1=15;hf2=8.5;
cp1=0;cp2=0;ro1=900;ro2=600;lam1=3.5;lam2=12.5;
L1=0.1;H1=0.02;L2=0.02;H2=0.08;t0=0;
xgridnumber2=200;ygridnumber1=200;ygridnumber2=500;
q=200;
%% mesh division
deltat=0.1;
deltax=L2/xgridnumber2;
xgridnumber1=(L1-L2)/2/deltax;
xgridnumber=2*xgridnumber1+xgridnumber2;
deltay1=H1/ygridnumber1;
deltay2=H2/ygridnumber2;
xaxis=[0,deltax/2:deltax:L1-deltax/2,L1];
yaxis=[0,deltay1/2:deltay1:H1-deltay1/2,H1,H1+deltay2/2:deltay2:H1+H2-deltay2/2,H1+H2];
xaxis11=[(L1-L2)/2,(L1-L2)/2+deltax/2:deltax:(L1+L2)/2-deltax/2,(L1+L2)/2];
yaxis1=[0,deltay1/2:deltay1:H1-deltay1/2,H1];
yaxis2=[H1,H1+deltay2/2:deltay2:H1+H2-deltay2/2,H1+H2];
%% interface conductivity
lambda1=ones(ygridnumber1+2,xgridnumber+2).*lam1;
lambda2=ones(ygridnumber2+1,xgridnumber2+2).*lam2;
lambda1_v=deltax./(deltax/2.*lambda1(2:end-1,3:end-1)+deltax/2.*lambda1(2:end-1,2:end-2)).*lambda1(2:end-1,3:end-1).*lambda1(2:end-1,2:end-2);
lambda1_v=[lambda1(2:end-1,1) lambda1_v lambda1(2:end-1,end)];
lambda1_o=deltay1./(deltay1/2.*lambda1(3:end-1,2:end-1)+deltay1/2.*lambda1(2:end-2,2:end-1)).*lambda1(2:end-2,2:end-1).*lambda1(3:end-1,2:end-1);
lambda1_o=[lambda1(1,2:end-1); lambda1_o;lambda1(end,2:end-1)];
lambda2_v=deltax./(deltax/2.*lambda2(1:end-1,3:end-1)+deltax/2.*lambda2(1:end-1,2:end-2)).*lambda2(1:end-1,3:end-1).*lambda2(1:end-1,2:end-2);
lambda2_v=[lambda2(1:end-1,1) lambda2_v lambda2(1:end-1,end)];
lambda2_o=deltay2./(deltay2/2.*lambda2(2:end-1,2:end-1)+deltay2/2.*lambda2(1:end-2,2:end-1)).*lambda2(2:end-1,2:end-1).*lambda2(1:end-2,2:end-1);
lambda2_o=[lambda2_o; lambda2(end,2:end-1)];
%% compute coefficient(inner point)
aew1=deltay1./(deltax./lambda1_v(:,2:end-1));
aew1=[deltay1./(deltax/2./lambda1_v(:,1)) aew1 deltay1./(deltax/2./lambda1_v(:,end))];
ans1=deltax./(deltay1./lambda1_o(2:end-1,:));
ans1=[deltax./(deltay1/2./lambda1_o(1,:));ans1;deltax./(deltay1/2./lambda1_o(end,:))];
aew2=deltay2./(deltax./lambda2_v(:,2:end-1));
aew2=[deltay2./(deltax/2./lambda2_v(:,1)) aew2 deltay2./(deltax/2./lambda2_v(:,end))];
ans2=deltax./(deltay2./lambda2_o(1:end-1,:));
ans2=[deltax./(deltay2/2./(lambda1(end,xgridnumber1+2:xgridnumber1+xgridnumber2+1)));ans2;deltax./(deltay2/2./lambda2_o(end,:))];
ap01=ro1*cp1*deltax*deltay1/deltat;
ap02=ro2*cp2*deltax*deltay2/deltat;
ap1=aew1(:,2:end)+aew1(:,1:end-1)+ans1(2:end,:)+ans1(1:end-1,:)+ap01;
ap2=aew2(:,2:end)+aew2(:,1:end-1)+ans2(2:end,:)+ans2(1:end-1,:)+ap02;
%% temperature compute
tem0=ones(ygridnumber1+2,xgridnumber+2)*Tf1;
tem1=ones(ygridnumber2+1,xgridnumber2+2)*Tf2;
tem00=tem0;tem11=tem1;
temt=zeros(ygridnumber2+2,xgridnumber2+2);
for i=1:200
    tem0_old=tem0;
    tem1_old=tem1;
    ii=0;
     while(true)
         ii=ii+1;
         %% boubdary condition  % additional point equation
%        tem0(1,2:end-1)=(hf1*Tf1+2*lambda1_o(1,:)/deltay1.*tem00(2,2:end-1))./(hf1+2*lambda1_o(1,:)./deltay1);
         tem0(1,2:end-1)=tem00(2,2:end-1)+(q*deltay1/2)./lambda1_o(1,:);
         tem0(2:end-1,1)=tem00(2:end-1,2);
         tem0(2:end-1,end)=tem00(2:end-1,end-1);
         tem0(end,2:xgridnumber1+1)=(epsi*sig.*(Tf2.^4-tem00(end,2:xgridnumber1+1).^4)+hf2*Tf2+2.*lambda1_o(end,1:xgridnumber1).*tem00(end-1,2:xgridnumber1+1)./deltay1)./(2.*lambda1_o(end,1:xgridnumber1)./deltay1+hf2);
         tem0(end,xgridnumber1+2:xgridnumber1+xgridnumber2+1)=(tem11(1,2:end-1).*deltay1/2+tem00(end-1,xgridnumber1+2:xgridnumber1+xgridnumber2+1).*deltay2/2)./(deltay1/2+deltay2/2);
         tem0(end,xgridnumber1+xgridnumber2+2:end-1)=(epsi*sig.*(Tf2.^4-tem00(end,xgridnumber1+xgridnumber2+2:end-1).^4)+hf2*Tf2+2.*lambda1_o(end,xgridnumber1+xgridnumber2+1:end).*tem00(end-1,xgridnumber1+xgridnumber2+2:end-1)./deltay1)./(2.*lambda1_o(end,xgridnumber1+xgridnumber2+1:end)./deltay1+hf2);
         tem1(1:end-1,1)=(epsi*sig.*(Tf2.^4-tem11(1:end-1,1).^4)+hf2*Tf2+2.*lambda2_v(:,1).*tem11(1:end-1,2)./deltax)./(2.*lambda2_v(:,1)./deltax+hf2);
         tem1(1:end-1,end)=(epsi*sig.*(Tf2.^4-tem11(1:end-1,end).^4)+hf2*Tf2+2.*lambda2_v(:,end).*tem11(1:end-1,end-1)./deltax)./(2.*lambda2_v(:,end)./deltax+hf2);
         tem1(end,2:end-1)=(epsi*sig.*(Tf2.^4-tem11(end,2:end-1).^4)+hf2*Tf2+2.*lambda2_o(end,:).*tem11(end-1,2:end-1)./deltay2)./(2.*lambda2_o(end,:)./deltay2+hf2);
         %% inner point 
         tem0(2:end-1,2:end-1)=(aew1(:,2:end).*tem00(2:end-1,3:end)+aew1(:,1:end-1).*tem0(2:end-1,1:end-2)+ans1(2:end,:).*tem00(3:end,2:end-1)+ans1(1:end-1,:).*tem0(1:end-2,2:end-1)+ap01.* tem0_old(2:end-1,2:end-1))./ap1;
         tem1(1,2:end-1)=(aew2(1,2:end).*tem11(1,3:end)+aew2(1,1:end-1).*tem1(1,1:end-2)+ans2(2,:).*tem11(2,2:end-1)+ans2(1,:).*tem0(ygridnumber1+2,xgridnumber1+2:xgridnumber1+xgridnumber2+1)+ap02.*tem1_old(1,2:end-1))./ap2(1,:);
         tem1(2:end-1,2:end-1)=(aew2(2:end,2:end).*tem11(2:end-1,3:end)+aew2(2:end,1:end-1).*tem1(2:end-1,1:end-2)+ans2(3:end,:).*tem11(3:end,2:end-1)+ans2(2:end-1,:).*tem1(1:end-2,2:end-1)+ap02.* tem1_old(2:end-1,2:end-1))./ap2(2:end,:);
         %% renew temperature field
        if(all([max(abs(tem0-tem00))<1e-4 max(abs(tem1-tem11))<1e-4],2))
           break;
        end
       tem00=tem0;
       tem11=tem1;
       disp("the number of iteration is  "+num2str(ii));
%        disp(max([max(abs(tem0-tem00)) max(abs(tem1-tem11))]));
     end
   tem0(1,1)=(tem0(2,1)+tem0(1,2))/2;
   tem0(1,end)=(tem0(2,end)+tem0(1,end-1))/2;
   tem0(end,1)=(tem0(end-1,1)+tem0(end,2))/2;
   tem0(end,end)=(tem0(end-1,end)+tem0(end,end-1))/2;
   tem1(end,1)=(tem1(end-1,1)+tem1(end,2))/2;
   tem1(end,end)=(tem1(end-1,end)+tem1(end,end-1))/2;
   corner0=(tem1(1,1)+tem0(end,xgridnumber1+2))/2;
   corner1=(tem1(1,end)+tem0(end,xgridnumber1+xgridnumber2+1))/2;
   temt=[ corner0 tem0(end,xgridnumber1+2:xgridnumber1+xgridnumber2+1) corner1;tem1];
%    disp("t="+num2str(t0+i*deltat));
   if(i==1)
        figure('Color','w');
        contourf(xaxis,yaxis1,tem0);
        hold on;
        contourf(xaxis11,yaxis2,temt);
        minT=min(min(tem0,[],'all'),min(tem1,[],"all"));
        maxT=max(max(tem0,[],'all'),max(tem1,[],"all"));
        colormap jet(40);
        c1=colorbar;
        set(c1,'ytick',ceil(minT):floor((maxT-minT)/14):floor(maxT),'Fontsize',12,'Fontname','Times New Roman');   
        xlabel("$X[m]$",Interpreter="latex",FontSize=18);
        ylabel("$Y[m]$",Interpreter="latex",FontSize=18);
        set(get(c1,'title'),'string','$T[K]$','Interpreter','latex','FontSize',15);
        writematrix([tem0(:,xgridnumber1+1+xgridnumber2/2);tem1(:,xgridnumber2/2+1)],'steady000_2.txt')
   end
   break;
%    if(i==40)
%         figure(2);
%         contourf(xaxis,yaxis1,tem0);
%         hold on;
%         contourf(xaxis11,yaxis2,temt);
%         colormap hsv;
%         c1=colorbar('FontSize',10);
%         xlabel("$x/m$",Interpreter="latex",FontSize=14);
%         ylabel("$y/m$",Interpreter="latex",FontSize=14);
%         title("$t=4s$",Interpreter="latex",FontSize=14);
%         set(get(c1,'title'),'string','$T/K$','Interpreter','latex','FontSize',13)
%    end
%    if(i==80)
%         figure(3);
%         contourf(xaxis,yaxis1,tem0);
%         hold on;
%         contourf(xaxis11,yaxis2,temt);
%         colormap hsv;
%         c1=colorbar('FontSize',10);
%         xlabel("$x/m$",Interpreter="latex",FontSize=14);
%         ylabel("$y/m$",Interpreter="latex",FontSize=14);
%         title("$t=8s$",Interpreter="latex",FontSize=14);
%         set(get(c1,'title'),'string','$T/K$','Interpreter','latex','FontSize',13);
%    end
%    if(i==200)
%         figure(4);
%         contourf(xaxis,yaxis1,tem0);
%         hold on;
%         contourf(xaxis11,yaxis2,temt);
%         colormap hsv;
%         c1=colorbar('FontSize',10);
%         xlabel("$x/m$",Interpreter="latex",FontSize=14);
%         ylabel("$y/m$",Interpreter="latex",FontSize=14);
%         title("$t=20s$",Interpreter="latex",FontSize=14);
%         set(get(c1,'title'),'string','$T/K$','Interpreter','latex','FontSize',13)
%    end
%    if(i==20)
%       writematrix([tem0(:,xgridnumber1+1+xgridnumber2/2);tem1(:,xgridnumber2/2+1)],'2s2.txt');
%    end
%    if(i==60)
%        writematrix([tem0(:,xgridnumber1+1+xgridnumber2/2);tem1(:,xgridnumber2/2+1)],'6s2.txt');
%    end
%    if(i==150)
%        writematrix([tem0(:,xgridnumber1+1+xgridnumber2/2);tem1(:,xgridnumber2/2+1)],'15s2.txt');
%    end
end


















