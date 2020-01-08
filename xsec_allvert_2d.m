function [] = xsec_allvert_2d(positions)
% vertical time series for multiple fields and positions

params = read_params();
Ny = params.NYM+1;

% initialize variables
tinds = 0:last_output('Data2d');
Noutputs = length(tinds);
v_ty  = zeros(Noutputs, Ny);

for mm = 1:length(positions)
    position = positions(mm);
    for ii = 1:Noutputs
        field = 'v';
        [y, xsec, vfsec] = xsec_vertical_2d(field, tinds(ii), position);
        v_ty(ii,:) = xsec;

        completion(ii, Noutputs)
    end

    % save data
    time = get_output_times('Data2d');
    filename = sprintf('xsection_vert_%02d', position);
    save(filename,'time','y','position','v_ty','vfsec');
end
