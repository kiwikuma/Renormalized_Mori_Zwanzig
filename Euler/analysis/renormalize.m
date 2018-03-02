function coeff_array = renormalize(u,N_list)

s = size(u);
N_full = s(1);
M_full = 3*N_full;
%t = s(6);
t = 2;

exact_everything = zeros(s);


% make k array
k_vec_full = [0:M_full-1,-M_full:1:-1];
[kx_full,ky_full,kz_full] = ndgrid(k_vec_full,k_vec_full,k_vec_full);
k_full = zeros(2*M_full,2*M_full,2*M_full,3);
k_full(:,:,:,1) = kx_full;
k_full(:,:,:,2) = ky_full;
k_full(:,:,:,3) = kz_full;

a_full = 2:M_full;
b_full = 2*M_full:-1:M_full+2;

for i = 1:2
    
    current_u_temp = squeeze(u(:,:,:,:,:,i));
    
    u_full = u_fullify(current_u_temp,M_full);
    
    du_dt = Ck(u_full,u_full,a_full,b_full,k_full,[]);
    du_dt = u_squishify(du_dt,N_full);
    
    exact_everything(:,:,:,:,:,i) = du_dt.*conj(du_dt);
    
end



max_N = 2*max(N_list);

exact = zeros(max_N,max_N,max_N,3,t,length(N_list));
R0 = zeros(max_N,max_N,max_N,3,t,length(N_list));
R1 = zeros(max_N,max_N,max_N,3,t,length(N_list));
R2 = zeros(max_N,max_N,max_N,3,t,length(N_list));
R3 = zeros(max_N,max_N,max_N,3,t,length(N_list));
R4 = zeros(max_N,max_N,max_N,3,t,length(N_list));

for j = 1:length(N_list);
    N = N_list(j);
    M = 2*N;
    
    % make k array
    k_vec = [0:M-1,-M:1:-1];
    [kx,ky,kz] = ndgrid(k_vec,k_vec,k_vec);
    k = zeros(2*M,2*M,2*M,3);
    k(:,:,:,1) = kx;
    k(:,:,:,2) = ky;
    k(:,:,:,3) = kz;
    
    k = k;
    N = N;
    M = M;
    a = 2:M;
    b = 2*M:-1:M+2;
    a_tilde = N+1:M;
    
    for i = 1:t
        
        res = [1:N,max_N-N+1:max_N];
        res_exact = [1:N,2*M_full - N+1:2*M_full];
        
        exact_full = u_fullify(squeeze(exact_everything(:,:,:,:,:,i)),M_full);
        exact(res,res,res,:,i,j) = exact_full(res_exact,res_exact,res_exact,:,:);
        
        temp_u = squeeze(u(:,:,:,:,:,i));
        temp_u_full = u_fullify(temp_u,M_full);
        temp_u = u_squishify(temp_u_full,N);
        u_full = u_fullify(temp_u,M);
        
        [~,t0hat,t0tilde] = markov_term(u_full,a,b,k,a_tilde);
        [~,t1hat,t1tilde] = tmodel_term(u_full,t0tilde,a,b,k,a_tilde);
        [t2,Ahat,Atilde,Bhat,Btilde] = t2model_term(u_full,t0hat,t0tilde,t1tilde,a,b,k,a_tilde);
        t2hat = u_squishify(t2,N);
        t2hat = mode_clearer(t2hat,a_tilde);
        [t3,Ehat,Etilde,Fhat,Ftilde] = t3model_term(u_full,t0hat,t0tilde,t1hat,t1tilde,Ahat,Atilde,Btilde,a,b,k,a_tilde);
        t3hat = u_squishify(t3,N);
        t3hat = mode_clearer(t3hat,a_tilde);
        t4 = t4model_term(u_full,t0hat,t0tilde,t1hat,t1tilde,Ahat,Atilde,Bhat,Btilde,Ehat,Etilde,Fhat,Ftilde,a,b,k,a_tilde);
        t4hat = u_squishify(t4,N);
        t4hat = mode_clearer(t4hat,a_tilde);
        
        t0 = u_squishify(t0hat,N);
        t0_energy = t0.*conj(t0);
        t0_energy = u_fullify(t0_energy,M_full);
        R0(res,res,res,:,i,j) = t0_energy(res_exact,res_exact,res_exact,:,:);
        
        t1 = u_squishify(t1hat,N);
        t1_energy = t1.*conj(t1);
        t1_energy = u_fullify(t1_energy,M_full);
        R1(res,res,res,:,i,j) = t1_energy(res_exact,res_exact,res_exact,:,:);
        
        
        t2_energy = t2hat.*conj(t2hat);
        t2_energy = u_squishify(t2_energy,N);
        t2_energy = u_fullify(t2_energy,M_full);
        R2(res,res,res,:,i,j) = t2_energy(res_exact,res_exact,res_exact,:,:);
        
        
        t3_energy = t3hat.*conj(t3hat);
        t3_energy = u_squishify(t3_energy,N);
        t3_energy = u_fullify(t3_energy,M_full);
        R3(res,res,res,:,i,j) = t3_energy(res_exact,res_exact,res_exact,:,:);
        
        
        t4_energy = t4hat.*conj(t4hat);
        t4_energy = u_squishify(t4_energy,N);
        t4_energy = u_fullify(t4_energy,M_full);
        R4(res,res,res,:,i,j) = t4_energy(res_exact,res_exact,res_exact,:,:);
        
    end
    
end


coeff_array = 0;
