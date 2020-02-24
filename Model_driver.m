%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                      %%
%%    Driverfile for ship propulsion system model                       %%
%%    Version 1.0                                                       %%
%%    P. de Vos                                                         %%
%%    Delft University of Technology                                    %%
%%    3ME / MTT / SDPO / ME                                             %%
%%                                                                      %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% This program drives the simulation of a ship propulsion sytem.
% Three processes are distinguished:
% - Pre-processing for loading the model parameters 
% - Running the ship propulsion system model (i.e. simulation)
% - Post-processing is where results are plotted in graphs.


%% Pre-processing

clc; clear all; close all;

% load properties and parameters

% PID Controller Tuning Parameters

Kp_x = 10;
Ki_x = 0;
Kd_x = 0;

Kp_y = 10;
Ki_y = 0;
Kd_y = 0;

Kp_yaw = 10;
Ki_yaw = 0;
Kd_yaw = 0;

% Thrust Allocation Settings - Configuration 5 (Angle,Xposition,Yposition)
% Starboard Thruster
SB_thruster = [0 -0.05 0.05];

% Port Thruster
PS_thruster = [pi/2 -0.05 -0.05]; %need to determine where angle is +/-

% Bow Thruster
B_thruster = [pi/2 0.05 0];

% MOTOR PID Settings

% RPS_SB = 1200 % rpm
% RPS_PS = 1200 % rpm

% SB MOTOR PID Set Values
SB_P = 1.3;
SB_I = 10;
SB_D = 0.02;
SB_AW = 10

% P MOTOR PID Set Values
PS_P = 1.3;
PS_I = 10;
PS_D = 0.02;
PS_AW = 50



%% Mass properties of model

a_x = 2.09;     %[kg] Added mass in surge
a_y = 17.4;     %[kg] Added mass in y sway 
a_psi = 0.11; %[kg*m^2] Added inertia in yaw

b_x = 3.99;     %[kg/s] Damping coefficient in surge
b_y = 47.62;    %[kg/s] Damping coefficient in sway
b_psi = 0.22; %[kg*m^2/s] Damping coefficient in yaw

c_x = 0;     %[kg/s] Damping coefficient in surge
c_y = 0;    %[kg/s] Damping coefficient in sway
c_psi = 0; %[kg*m^2/s] Damping coefficient in yaw

m = 30;         %[TO BE MEASURED!] Mass of the model ship
I_zz = 15;      %[TO BE MEASURED!] Mass moment of inertia of the model ship


%% Simulation

open([cd,'/wetmodel.slx']);
% 
% tic
% sim('wetmodel',t_end);
% toc
