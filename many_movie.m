% script for running the same m-file for many different cases
clear all

% which syst are you using? ('graham','ua','home')
syst = 'graham';

% set ctb and work directory locations
if strcmp(syst, 'graham')
    def = '~/projects/def-bsuther/ddeepwel/';
    scr = '~/scratch/bsuther/';
end

% other set-up
add_parties
add_subdirs('part_settling')

snapshot_movie
