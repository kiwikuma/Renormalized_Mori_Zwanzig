function normalized_fftn = fftn_norm(u)
%
%Computes the 3-dimensional FFT of the NxNxN u using the more standard
%normalization of 1/N^3 instead of just 1.
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Inputs:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  u_full  =  real space vector to be transformed
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Outputs:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  normalized_fftn  =  normalized FFT of that vector

s = size(u);
normalized_fftn = zeros(s);
for i = 1:3
    normalized_fftn(:,:,:,i) = fftn(u(:,:,:,i))*1/numel(u(:,:,:,i));
end