function [] = movie_stat2d(group, field)
% MAKE_MOVIE     Make a movie of a 2D statistic
%   make_movie uses ffmpeg to stitch frames together, so a working copy 
%   of that is necessary.
%
%  Usage:
%    make_movie()
%
%  Inputs:
%    'varname'   - the variable to make a movie of.
%                  Allowed names - Anything readable by spins_plot2d:
%                      rho, u, KE, Mean KE, SD KE, ...
%
%  Outputs:
%    none
%
%  David Deepwell, 2019

%params = read_params();

switch field
    case {'c0'}
        clim = [0 1];
    case {'u'}
        clim = [-1 1]*5e-1;
    case {'v'}
        clim = [-1 1];
    case {'w'}
        clim = [-1 1]*1e-3;
    case {'c_curve_diag'}
        clim = [-1 1]*0.8;
    case 'KE_h'
        clim = [0 1]*5e-3;
    otherwise
        clim = 'auto';
end

if strcmp(group(1:2), 'xy')
    figsize = [4 8];
elseif strcmp(group(1:2), 'xz') || strcmp(group, 'integral_y')
    figsize = [5 5];
end

% video frame rate
framerate = 12;
% frame rate lower than 3 does not work with quicktime

% set-up directory and figure
if exist('tmp_figs','dir')
    rmdir('tmp_figs','s') % wipe directory clear before populating
end
mkdir('tmp_figs')

% outputs to use in movie (default here is all of them)
first_out = 0;
last_out = last_output('Data2d');
outputs = first_out:last_out;

% do loop
for ii = outputs
    % make plot
    plot_stat2d(group, field, ii, 95, clim, 'contourf');

    % adjust title for c0
    ax = gca;
    ttl = ax.Title.String;
    switch field
        case 'c0'
            ttl = ['$\rho',ttl(4:end)];
    end

    % adjust to defaults
    set(gca,'TickDir','out')
    axis image
    figure_defaults()

    % save output figure
    cd('tmp_figs')
    filename = ['tmp_',num2str(ii,'%03d')];
    print_figure(filename, 'format', 'png','size', figsize,'res',600)
    cd('..')

    completion(ii-first_out+1, length(outputs))
end

% create directory to store movies
check_make_dir('movies')
% make movie and remove temporary files and folder
cd('tmp_figs')
filename = [field,'_',group];
ffmpeg = sprintf(['ffmpeg -framerate %d -r %d ',...
    '-start_number %d -i tmp_%%03d.png -y -vcodec mpeg4 -q 1 ',...
    '../movies/%s.mp4'], framerate, framerate, first_out, filename);
disp(ffmpeg)
status = system(ffmpeg);
if status ~= 0
    disp([filename,'.mp4 was possibly not rendered correctly.'])
    cd('..')
else
    cd('..')
    rmdir('tmp_figs','s')
end
