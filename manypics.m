% script for running the same m-file for many different cases
clear all

% which syst are you using? ('graham','ua','home')
syst = 'graham';

% set ctb and work directory locations
if strcmp(syst, 'graham')
    def = '~/projects/def-bsuther/ddeepwel/';
end

% set directories to use
base = [def,'part_settling/1particle'];
direc = {'srdic1_new'};

% other set-up
add_parties
add_dir('part_settling')

% loop over directories
for mm = 1:length(direc)
    % change directory and print new location
    cd([base,'/',direc{mm}])
    disp(['Directory: ',direc{mm}])

    % do stuff
    make_movie_stat2d('xy','u');
    make_movie_stat2d('xy','v');
    make_movie_stat2d('xy','w');
    make_movie_stat2d('xy','c0');

    make_movie_stat2d('integral_y','c_curve_diag');

    make_movie_stat2d('xz1','v');
    make_movie_stat2d('xz1','ke_h');
    make_movie_stat2d('xz1','c0');
    make_movie_stat2d('xz2','v');
    make_movie_stat2d('xz2','ke_h');
    make_movie_stat2d('xz2','c0');
    make_movie_stat2d('xz3','v');
    make_movie_stat2d('xz3','ke_h');
    make_movie_stat2d('xz3','c0');
    make_movie_stat2d('xz4','v');
    make_movie_stat2d('xz4','ke_h');
    make_movie_stat2d('xz4','c0');
    make_movie_stat2d('xz5','v');
    make_movie_stat2d('xz5','ke_h');
    make_movie_stat2d('xz5','c0');

    % clear variables for next loop
    clear_except({'base','direc','mm'})
end
