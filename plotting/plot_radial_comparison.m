% compare the diameter of the downward moving area over time

params = read_params();
Nx = params.NXM;

Noutputs = last_output('Data2d')+1;


for mm = 1:Noutputs;
    ii = mm - 1;

    [x,u_mid] = plot_radial_convergence(3, ii, 'v');

    ind = nearest_index(u_mid(Nx/2+35:end-10), 0);
    loc(mm) = x(Nx/2+34+ind);
end

time = get_output_times('Data2d'); 

figure(58)
clf
plot(time,loc)
