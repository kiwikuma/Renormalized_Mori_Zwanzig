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

if degree == 1 % updated 3/24/2018 N=48
    coefficients = exp(0.346140204693076) * N^-1.100982456346863;
end

if degree == 2 % updated 3/24/2018 N=48
    coefficients(1) = exp(0.450485290588850) * N^-0.910866820408359;
    coefficients(2) = exp(0.241869704035654) * N^-1.812532078606838;
end

if degree == 3 % updated 3/24/2018 N=48
    coefficients(1) = exp(0.700418137617023) * N^-0.935138605878111;
    coefficients(2) = exp(1.217147112806629) * N^-1.962577643260228;
    coefficients(3) = exp(1.431162474047888) * N^-3.188011710973634;
end

if degree == 4 % updated 3/24/2018 N=48
    coefficients(1) = exp(0.898823727373543) * N^-0.988857926218814;
    coefficients(2) = exp(1.753386619806672) * N^-2.103964030340424;
    coefficients(3) = exp(2.388790403108812) * N^-3.415262749214611;
    coefficients(4) = exp(2.412309528581516) * N^-4.945061502758477;
end