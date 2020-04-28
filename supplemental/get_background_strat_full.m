function strat = get_background_strat_full(ii, file_prefix)
% return the background stratification as a full 2D or 3D field

if nargin == 1
    file_prefix = 'Data2d';
end

params = read_params();
Ny = params.NYM+1;
Nz = params.NZM+1;

strat_1d = get_background_strat(ii, file_prefix);

if strcmp(file_prefix(end-1:end),'2d')
    % 2D
    strat = repmat(strat_1d,[Ny 1]);
else
    % 3D
    % this is probably incorrect!
    strat = repmat(strat_1d,[Ny 1 Nz]);
end
