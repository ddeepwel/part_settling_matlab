% plot the vertical velocity above a single particle
% this is to show how the stratification changes the velocity structure


base = '/scratch/ddeepwel/bsuther/part_settling/2particles/sigma1/Re0.25/';
gamm_dirs = {
'gamm0.1',...
'gamm0.3',...
'gamm0.5',...
'gamm0.7',...
'gamm0.9',...
'gamm1.0'
};
gs = [0.1:0.2:0.9, 1.0];

%depth = 21;
% 24 is the location of the pycnocline

for mm = 1:length(gs)
    cd([base,gamm_dirs{mm},'/1prt_dx25'])

    % find time for particle at prescribed depth 
    time = get_output_times('Data2d');
    val = zeros(length(time),1);
    for ii = 1:last_output('Data2d')
        filename_2d = sprintf('Data2d_%d.h5',ii);
        data1 = h5read(filename_2d, ['/xy1/v']);
        data2 = h5read(filename_2d, ['/xy2/v']);
        data = (data1 + data2)/2;
        vf1 = h5read(filename_2d, ['/xy1/vf']);
        vf2 = h5read(filename_2d, ['/xy2/vf']);
        vf = (vf1 + vf2)/2;
        data = data.*(1-vf);
        [nx,nz] = size(data);
        val(ii) = max(data(round(nx/2),:));
    end
    [mx,ind] = max(val);
    max_v(mm) = mx;
    max_t(mm) = time(ind);

    completion(mm,length(gs))
end

cd('../../compare_data')
save('1prt_max_vertvel','max_v','max_t','gamm_dirs');
