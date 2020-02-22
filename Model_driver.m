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

%PID Controller Tuning Parameters

Kp_x = 10
Ki_x = 1
Kd_x = 0

Kp_y = 10
Ki_y = 0
Kd_y = 0

Kp_yaw = 10
Ki_yaw = 0
Kd_yaw = 0


% SB MOTOR PID Set Values
SB_I = 10
SB_P = 10
SB_D = 10

    


%% Simulation

% open([cd,'/wetmodel.slx']);
% 
% tic
% sim('wetmodel',t_end);
% toc
