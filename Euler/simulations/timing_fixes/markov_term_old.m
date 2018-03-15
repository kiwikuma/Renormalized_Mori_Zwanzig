function [t0,t0_hat,t0_tilde] = markov_term_old(u_full,a,b,k,a_tilde)
%
% Computes the RHS for every mode in the Markov model for 3D Euler
%
%
%%%%%%%%%
%INPUTS:%
%%%%%%%%%
%
%   u_full  =  full array of current Fourier state (2Mx2Mx2Mx3)
%
%        a  =  indices of positive resolved modes 1:M
%
%        b  =  indices of negative resolved modes -M:-1
%
%        k  =  array of wavenumbers (2Mx2Mx2Mx3)
%
%  a_tilde  =  indices of unresolved modes
%
%
%%%%%%%%%%
%OUTPUTS:%
%%%%%%%%%%
%
%  t0  =  Markov term of derivative of each resolved mode

% the full model is a simple convolution Ck(u,u)
[t0,t0_hat,t0_tilde] = Ck_old(u_full,u_full,a,b,k,a_tilde);