function [times,energies,errors] = error_test_real(N,alpha,endtime)
%
%  [times,energies,errors] = error_test_real(N,alpha,endtime)
%
%  Computes ROMs of Burgers of many varieties and compares their energy
%  evolution and errors *in real space*
%
%
%%%%%%%%%
%INPUTS:%
%%%%%%%%%
%
%        N  =  resolution of ROM
%
%    alpha  =  degree of nonlinearity
%
%  endtime  =  final time of simulation
%
%
%%%%%%%%%%
%OUTPUTS:%
%%%%%%%%%%
%
%     times  =  structure containing times of each ROM
%
%  energies  =  structure containing energy at all times for each ROM
%
%    errors  =  structure containing errors at all times for each ROM

addpath ../simulation_functions
addpath ../nonlinear
addpath ../analysis

% load the exact solution if it exists, otherwise make it
if ~(exist(sprintf('u_list%i.mat',endtime),'file') == 2)
    
    [t_list,u_list] = upwind_burgers(1,10000,endtime,1e-4,1000);
    save(sprintf('u_list%i',endtime),'u_list');
    save(sprintf('t_list%i',endtime),'t_list');
    
else
    load(sprintf('u_list%i',endtime));
    load(sprintf('t_list%i',endtime));
end

leg = {'Exact','n = 1, constant coefficients','n = 2, constant coefficients','n = 3, constant coefficients','n = 4, constant coefficients','n = 1, decaying coefficients','n = 2, decaying coefficients','n = 3, decaying coefficients','n = 4, decaying coefficients'};


[x_e,u_e] = make_real_space(u_list,N);

% save shared parameters
simulation_params.N = N;
simulation_params.alpha = alpha;
simulation_params.endtime = endtime;
simulation_params.print_time = 1;
simulation_params.time_range = t_list;

% Burgers-style 1 ROM
type = 'c1B';
simulation_params.time_dependence = 1;
simulation_params.degree = 4;
simulation_params.coeffs = scaling_law(N,type);
simulation_params.initialization = @(x) ROM_init_Burgers(x);
simulation_params.time_dependence = 1;
[tc1B,uc1B] = PDE_solve(simulation_params);
[x_c1B,u_c1B] = make_real_space(uc1B,N);

% Burgers-style 1+2 ROM
type = 'c2B';
simulation_params.time_dependence = 1;
simulation_params.degree = 4;
simulation_params.coeffs = scaling_law(N,type);
simulation_params.initialization = @(x) ROM_init_Burgers(x);
simulation_params.time_dependence = 1;
[tc2B,uc2B] = PDE_solve(simulation_params);
[x_c2B,u_c2B] = make_real_space(uc2B,N);

% Burgers-style 1+2+3 ROM
type = 'c3B';
simulation_params.time_dependence = 1;
simulation_params.degree = 4;
simulation_params.coeffs = scaling_law(N,type);
simulation_params.initialization = @(x) ROM_init_Burgers(x);
simulation_params.time_dependence = 1;
[tc3B,uc3B] = PDE_solve(simulation_params);
[x_c3B,u_c3B] = make_real_space(uc3B,N);

% Burgers-style 1+2+3+4 ROM
type = 'c4B';
simulation_params.time_dependence = 1;
simulation_params.degree = 4;
simulation_params.coeffs = scaling_law(N,type);
simulation_params.initialization = @(x) ROM_init_Burgers(x);
simulation_params.time_dependence = 1;
[tc4B,uc4B] = PDE_solve(simulation_params);
[x_c4B,u_c4B] = make_real_space(uc4B,N);

% KdV-style 1 ROM
type = 'c1KdV';
simulation_params.time_dependence = 1;
simulation_params.degree = 4;
simulation_params.coeffs = scaling_law(N,type);
simulation_params.initialization = @(x) ROM_init_Burgers(x);
simulation_params.time_dependence = 0;
[tc1KdV,uc1KdV] = PDE_solve(simulation_params);
[x_c1KdV,u_c1KdV] = make_real_space(uc1KdV,N);

% KdV-style 1+2 ROM
type = 'c2KdV';
simulation_params.time_dependence = 1;
simulation_params.degree = 4;
simulation_params.coeffs = scaling_law(N,type);
simulation_params.initialization = @(x) ROM_init_Burgers(x);
simulation_params.time_dependence = 0;
[tc2KdV,uc2KdV] = PDE_solve(simulation_params);
[x_c2KdV,u_c2KdV] = make_real_space(uc2KdV,N);

% KdV-style 1+2+3 ROM
type = 'c3KdV';
simulation_params.time_dependence = 1;
simulation_params.degree = 4;
simulation_params.coeffs = scaling_law(N,type);
simulation_params.initialization = @(x) ROM_init_Burgers(x);
simulation_params.time_dependence = 0;
[tc3KdV,uc3KdV] = PDE_solve(simulation_params);
[x_c3KdV,u_c3KdV] = make_real_space(uc3KdV,N);

% KdV-style 1+2+3+4 ROM
type = 'c4KdV';
simulation_params.time_dependence = 1;
simulation_params.degree = 4;
simulation_params.coeffs = scaling_law(N,type);
simulation_params.initialization = @(x) ROM_init_Burgers(x);
simulation_params.time_dependence = 0;
[tc4KdV,uc4KdV] = PDE_solve(simulation_params);
[x_c4KdV,u_c4KdV] = make_real_space(uc4KdV,N);


% compute and plot energies
energy_exact = get_energy(u_list,N);
energyc1B = get_energy(uc1B,N);
energyc2B = get_energy(uc2B,N);
energyc3B = get_energy(uc3B,N);
energyc4B = get_energy(uc4B,N);
energyc1KdV = get_energy(uc1KdV,N);
energyc2KdV = get_energy(uc2KdV,N);
energyc3KdV = get_energy(uc3KdV,N);
energyc4KdV = get_energy(uc4KdV,N);

figure(1)
hold off
plot(log(t_list),log(energy_exact),'linewidth',2)
hold on
plot(log(tc1B),log(energyc1B),'r')
plot(log(tc2B),log(energyc2B),'k')
plot(log(tc3B),log(energyc3B),'c')
plot(log(tc4B),log(energyc4B),'m')

plot(log(tc1KdV),log(energyc1KdV),'r--','linewidth',1.2)
plot(log(tc2KdV),log(energyc2KdV),'k--','linewidth',1.2)
plot(log(tc3KdV),log(energyc3KdV),'c--','linewidth',1.2)
plot(log(tc4KdV),log(energyc4KdV),'m--','linewidth',1.2)
legend(leg{:},'location','southwest')

title(sprintf('N = %i',N),'fontsize',16)
xlabel('log(t)')
ylabel('log(energy)')
saveas(gcf,sprintf('Burgers_energy%i_%i',N,endtime),'png')
close


% compute and plot errors
u_exact = u_list(1:N,:);

errc1B = sum(u_c1B(:,1:length(tc1B)) - u_e(:,1:length(tc1B)),1)./sum(u_e(:,1:length(tc1B)),1);
errc2B = sum(u_c2B(:,1:length(tc2B)) - u_e(:,1:length(tc2B)),1)./sum(u_e(:,1:length(tc2B)),1);
errc3B = sum(u_c3B(:,1:length(tc3B)) - u_e(:,1:length(tc3B)),1)./sum(u_e(:,1:length(tc3B)),1);
errc4B = sum(u_c4B(:,1:length(tc4B)) - u_e(:,1:length(tc4B)),1)./sum(u_e(:,1:length(tc4B)),1);

errc1KdV = sum(u_c1KdV(:,1:length(tc1KdV)) - u_e(:,1:length(tc1KdV)),1)./sum(u_e(:,1:length(tc1KdV)),1);
errc2KdV = sum(u_c2KdV(:,1:length(tc2KdV)) - u_e(:,1:length(tc2KdV)),1)./sum(u_e(:,1:length(tc2KdV)),1);
errc3KdV = sum(u_c3KdV(:,1:length(tc3KdV)) - u_e(:,1:length(tc3KdV)),1)./sum(u_e(:,1:length(tc3KdV)),1);
errc4KdV = sum(u_c4KdV(:,1:length(tc4KdV)) - u_e(:,1:length(tc4KdV)),1)./sum(u_e(:,1:length(tc4KdV)),1);

figure(1)
hold off
plot(tc1B,errc1B,'r','linewidth',1.5)
hold on
plot(tc2B,errc2B,'k','linewidth',1.5)
plot(tc3B,errc3B,'c','linewidth',1.5)
plot(tc4B,errc4B,'m','linewidth',1.5)
axis([0,endtime,0,2])
legend(leg{2:5},'location','northeast')

title(sprintf('Constant coefficients, N = %i',N),'fontsize',16)
xlabel('t')
ylabel('error')
saveas(gcf,sprintf('Burgers_const_err%i_%i',N,endtime),'png')
close

figure(2)
hold off
plot(tc1KdV,errc1KdV,'r','linewidth',1.5)
hold on
plot(tc2KdV,errc2KdV,'k','linewidth',1.5)
plot(tc3KdV,errc3KdV,'c','linewidth',1.5)
plot(tc4KdV,errc4KdV,'m','linewidth',1.5)
legend(leg{2:5},'location','northeast')

title(sprintf('Decaying coefficients, N = %i',N),'fontsize',16)
xlabel('t')
ylabel('error')
saveas(gcf,sprintf('Burgers_decay_err%i_%i',N,endtime),'png')
close


% save results
energies.exact = energy_exact;
energies.c1B = energyc1B;
energies.c2B = energyc2B;
energies.c3B = energyc3B;
energies.c4B = energyc4B;
energies.c1KdV = energyc1KdV;
energies.c2KdV = energyc2KdV;
energies.c3KdV = energyc3KdV;
energies.c4KdV = energyc4KdV;

times.exact = t_list;
times.c1B = tc1B;
times.c2B = tc2B;
times.c3B = tc3B;
times.c4B = tc4B;
times.c1KdV = tc1KdV;
times.c2KdV = tc2KdV;
times.c3KdV = tc3KdV;
times.c4KdV = tc4KdV;

errors.c1B = errc1B;
errors.c2B = errc2B;
errors.c3B = errc3B;
errors.c4B = errc4B;
errors.c1KdV = errc1KdV;
errors.c2KdV = errc2KdV;
errors.c3KdV = errc3KdV;
errors.c4KdV = errc4KdV;