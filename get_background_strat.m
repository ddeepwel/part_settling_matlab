function strat = get_background_strat(ii)
% return the background stratification

filename = sprintf('Data_%d.h5',ii);
data = h5read(filename, '/Conc/0');
% probably should only read what I need, but I'm too lazy right now

strat = squeeze(data(1,:,1));

