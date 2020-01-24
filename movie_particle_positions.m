function [] = movie_particle_positions()
% make a movie of particle positions


particle_files = dir('mobile_*.dat');
N_files = length(particle_files);

p = cell(1, N_files);
for mm = 1:N_files
    fname = sprintf('mobile_%d', mm-1);
    p{mm} = check_read_dat(fname);
end

ysep = ceil(abs(p{2}.y(1) - p{1}.y(1)));

time = p{1}.time;
Nt = length(time);
cols = default_line_colours();

framerate = 30; % must be greater than or equal to 3!
if exist('tmp_figs','dir')
    rmdir('tmp_figs','s') % wipe directory clear before populating
end
mkdir('tmp_figs')
cd('tmp_figs')


figure(68)
Nframes = round(Nt/4);
plot_times = linspace(0, time(end), Nframes);
%plot_times = 0:1:time(end);
%Nframes = length(plot_times);
for ii = 1:Nframes
    ind = nearest_index(time, plot_times(ii));
    t(ii) = time(ind);
    clf
    for mm = 1:N_files
        x = p{mm}.x;
        y = p{mm}.y;
        viscircles([x(ind) y(ind)],0.5, 'Color',cols(mm,:));
    end

    xlabel('$x/D_p$')
    ylabel('$y/D_p$')
    title(sprintf('$t=%4.2f$',time(ind)))
    axis image
    xl = xlim;
    yl = ylim;
    xlim(xl + [-0.5 0.5])
    ylim(yl(1) + [-0.2 ysep+1])

    hold on
    plot([0 0],ylim(),'k--')
    hold off

    figure_defaults()
    drawnow

    filename = ['tmp_',num2str(ii,'%03d')];
    print_figure(filename, 'format', 'png','res',600)

    completion(ii, Nframes)
end

first_out = 1;
check_make_dir('../movies')
filename = 'particle_positions';
ffmpeg = sprintf(['ffmpeg -framerate %d -r %d '...
    '-start_number %d -i tmp_%%03d.png -vcodec mpeg4 '...
    '../movies/%s.mp4'], framerate, framerate,first_out,filename);
fprintf([ffmpeg,'\n'])
status = system(ffmpeg);
if status ~= 0
    disp([filename,'.mp4 was possibly not redered correctly.'])
end
cd('..')
rmdir('tmp_figs','s')


%figure(178)
%plot(diff(t))
