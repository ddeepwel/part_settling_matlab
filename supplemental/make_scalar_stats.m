% read all integral quantities from 2d hdf5 files and make
% a single file containing the time series


field = 'entrained_fluid';
fileformat = 'Data2d';

fieldname = ['/integral/',field];

Noutputs = last_output(fileformat);
volume  = zeros(Noutputs,1);
time = zeros(Noutputs,1);

for ii = 1:Noutputs
    filename_2d = sprintf([fileformat,'_%d.h5'],ii-1);
    volume(ii)  = h5read(filename_2d, fieldname);
    time(ii) = h5read(filename_2d, '/time');

    completion(ii,Noutputs)
end

save('entrained_fluid','time','volume');
% need to multiply volume by 6/pi to get ratio of entrained fluid to particle volume
