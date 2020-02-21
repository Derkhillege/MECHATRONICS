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
    get_parameters;

% simulation control parameters
    t_end        = 36000;
    iv_t_control = [   0,  (1/10)*t_end, (2/10)*t_end,  (5/10)*t_end,  (6/10)*t_end, (7/10)*t_end, t_end];         % [s]
    ov_X_set     = [ 100,           100,           30,            40,            40,           90,    90]/100;     % [%] of maximum fuelrack
    ov_Y_set     = [ 100,           100,          100,           100,           100,          100,   100]/100;     % [%] disturbance factor
    
    % experiment 1
%     t_end        = 1500;
%     iv_t_control = [   0,  (1/5)*t_end, (1/5)*t_end, (2/5)*t_end, (2/5)*t_end, (3/5)*t_end, (3/5)*t_end, (4/5)*t_end, (4/5)*t_end, t_end];         % [s]
%     ov_X_set     = [ 100,          100,          75,          75,          50,          50,          25,          25,           1,     1]/100;     % [%] of maximum fuelrack
%     ov_Y_set     = [ 100,          100,         100,         100,         100,         100,         100,         100,         100,   100]/100;     % [%] disturbance factor

% Initial values
    in_eng       = n_eng_nom/i_gb;
    iv_s         = 7.54;

%% Simulation

open([cd,'/models/propulsion.mdl']);

tic
sim('propulsion',t_end);
toc

%% Post-processing
plot_file;
%% Modifications:
% 121012: Created                                (PdV)
% 140127: Inserted experiment 1                  (PdV)
% 140205: Final version for MT1452               (PdV)
