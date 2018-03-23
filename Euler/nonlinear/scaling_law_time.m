function coefficients = scaling_law_time(N,degree)
%
% Produces renormalization coefficients for a renormalized model of
% resolution N and degree "degree" that does not cancel out the algebraic
% time dependence of the Taylor series
%
% Based upon simulations done on March 19 from N = 32 data with no time
% dependence and a non-variable windwo (N = 16 t-model between 1e-16 and
% 1e-10)
%
%
%%%%%%%%%
%INPUTS:%
%%%%%%%%%
%
%       N  =  resolution of ROM
%
%  degree  =  maximal degree of ROM term to include
%
%
%%%%%%%%%%
%OUTPUTS:%
%%%%%%%%%%
%
%  coefficients  =  a degree x 1 array of the renormalization coefficients
%  to use

coefficients = zeros(degree,1);

if degree == 1 % updated 3/23/2018
    coefficients = exp(0.491389081810366) * N^-1.156688861750875;
end

if degree == 2 % updated 3/23/2018
    coefficients(1) = exp(0.420499429436766) * N^-0.905316406347716;
    coefficients(2) = exp(-0.036826745092329) * N^-1.704715202816203;
end

if degree == 3 % updated 3/23/2018
    coefficients(1) = exp(0.646049344808330) * N^-0.909907895474231;
    coefficients(2) = exp(1.133390649291541) * N^-1.921368478893264;
    coefficients(3) = exp(1.508958599629432) * N^-3.215153162288559;
end

if degree == 4 % updated 3/23/2018
    coefficients(1) = exp(0.861980016570825) * N^-0.976581292511070;
    coefficients(2) = exp(1.734556578801689) * N^-2.107984536699434;
    coefficients(3) = exp(2.474608341696148) * N^-3.480333013089068;
    coefficients(4) = exp(3.748465655044792) * N^-5.710059939108191;
end

