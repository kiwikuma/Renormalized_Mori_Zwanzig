function crunch_data(N)


format long

addpath ../../simulation_functions
addpath ../../nonlinear
addpath ../../analysis


load(sprintf('t1_%i',N))
load(sprintf('t2_%i',N))
load(sprintf('t3_%i',N))
load(sprintf('t4_%i',N))

load(sprintf('u_array1_%i',N))
load(sprintf('u_array2_%i',N))
load(sprintf('u_array3_%i',N))
load(sprintf('u_array4_%i',N))


M = 3*N;

% uniform grid
x = linspace(0,2*pi*(2*M-1)/(2*M),2*M).';
y = x;
z = x;

% 3D array of data points
[X,Y,Z] = ndgrid(x,y,z);

% create initial condition
eval = taylor_green(X,Y,Z);
u_full = fftn_norm(eval);
u = u_squishify(u_full,N);

% make k array
k_vec = [0:M-1,-M:1:-1];
[kx,ky,kz] = ndgrid(k_vec,k_vec,k_vec);
k = zeros(2*M,2*M,2*M,3);
k(:,:,:,1) = kx;
k(:,:,:,2) = ky;
k(:,:,:,3) = kz;

params.k = k;
params.N = N;
params.M = M;
params.a = 2:M;
params.b = 2*M:-1:M+2;
params.a_tilde = N+1:M;
params.print_time = 1;
params.no_time = 1;

params1 = params;
params1.func = @(x) tmodel_RHS(x);
params1.coeff = scaling_law(N,1); 

params2 = params;
params2.func = @(x) t2model_RHS(x);
params2.coeff = scaling_law(N,2); 

params3 = params;
params3.func = @(x) t3model_RHS(x);
params3.coeff = scaling_law(N,3); 

params4 = params;
params4.func = @(x) t4model_RHS(x);
params4.coeff = scaling_law(N,4); 

t1_include = 0;
t2_include = 0;
t3_include = 0;
t4_include = 0;
i = 1;

if t1(end) == end_time
    t1_include = 1;
    little_legend{i} = sprintf('ROM order 1, N = %i',N);
    i = i+1;
end

if t2(end) == end_time
    t2_include = 1;
    little_legend{i} = sprintf('ROM order 2, N = %i',N);
    i = i+1;
end

if t3(end) == end_time
    t3_include = 1;
    little_legend{i} = sprintf('ROM order 3, N = %i',N);
    i = i+1;
end

if t4(end) == end_time
    t4_include = 1;
    little_legend{i} = sprintf('ROM order 4, N = %i',N);
    i = i+1;
end

little_legend_sw = little_legend;
little_legend_sw{i} = 'location';
little_legend_sw{i+1} = 'southwest';

little_legend_se = little_legend;
little_legend_se{i} = 'location';
little_legend_se{i+1} = 'southeast';



if t1_include
d1 = energy_derivative(u_array1,t1,params1);
save(sprintf('d1_%i',N),'d1');
end
if t2_include
d2 = energy_derivative(u_array2,t2,params2);
save(sprintf('d2_%i',N),'d2');
end
if t3_include
d3 = energy_derivative(u_array3,t3,params3);
save(sprintf('d3_%i',N),'d3');
end
if t4_include
d4 = energy_derivative(u_array4,t4,params4);
save(sprintf('d4_%i',N),'d4');
end

figure(3)
hold off
if t1_include
plot(t1,d1,'linewidth',2)
hold on
end
if t2_include
plot(t2,d2,'r','linewidth',2)
hold on
end
if t3_include
plot(t3,d3,'k','linewidth',2)
hold on
end
if t4_include
plot(t4,d4,'c','linewidth',2)
hold on
end
legend(little_legend_se{:})
title('Energy Derivative','fontsize',16)
xlabel('time','fontsize',16)
ylabel('w','fontsize',16)
saveas(gcf,sprintf('energy_deriv%i',N),'png')


if t1_include
    ens1 = enstrophy(u_array1);
end
if t2_include
    ens2 = enstrophy(u_array2);
end
if t3_include
    ens3 = enstrophy(u_array3);
end
if t4_include
    ens4 = enstrophy(u_array4);
end

figure(4)
hold off
if t1_include
    plot(t1,ens1,'linewidth',2)
    hold on
end
if t2_include
    plot(t2,ens2,'r','linewidth',2)
    hold on
end
if t3_include
    plot(t3,ens3,'k','linewidth',2)
    hold on
end
if t4_include
    plot(t4,ens4,'c','linewidth',2)
    hold on
end
legend(little_legend_se{:})
title('Enstrophy','fontsize',16)
xlabel('time','fontsize',16)
ylabel('enstrophy','fontsize',16)
saveas(gcf,sprintf('enstrophy%i',N),'png')
