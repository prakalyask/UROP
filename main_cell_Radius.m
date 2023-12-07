%%%%%%%%%%%%%%%%%%%  Q -Learning Based Power Control Algorithm  %%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%  for D2D Communication  %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                                 
%%% Input:                                                              
%%%     % Speech Input.txt                                           
%%% Output:                                                        
%%%     % CVSD Encoded output bits  
%%%
%% Initalization of distance
clc;
clear all;
close all;

cell_radius = 500;
cell_radius_range = [200 250 300 350 400 450 500];
dist_d2d = 50;
%dist_d2d_range = [15 20 25 30 35 40 45 50];
num_iter = 1000;
for ii = 1:numel(cell_radius_range)
    for kk = 1:num_iter
N=10; % number of D2D user
r1 = cell_radius_range(ii);
r=r1+250*rand(1,N);
theta=360*rand(1,N);
phi=60*rand(1,N);
dist=dist_d2d+25*rand(1,N);
dtx=r.*cosd(theta);
dty=r.*sind(theta);
drx=dtx+dist.*cosd(phi);
dry=dty;
bs_x=0;
bs_y=0;
len=r*rand(1);
angle=rand(1);
cx=len*cosd(angle);
cy=len*sind(angle);
theta2=0:360;
x1=cell_radius.*cosd(theta2);
y1=cell_radius.*sind(theta2);

a=2:22;
%% interference calculation
P=23*ones(1,N);
[BI, DI]=SINR(P,dtx,dty,drx,dry,cx,cy); 
    DI_avg(kk,:) = DI;
    end
 DI_sum(ii)= sum(mean(DI_avg(:,:)));
clear DI;
end
%% distributed algorithm
Q=zeros(2,length(a),N);

figure 
plot(dist_d2d_range,DI_sum,'-*')
xlabel('Distance between D2D users');
ylabel('Energy efficiency (EE)');
grid on

figure();
plot(x1,y1,'k-');
hold all; grid on;
plot(dtx,dty,'^');
plot(drx,dry,'v');
plot(bs_x,bs_y,'o');
plot(cx,cy,'sq');