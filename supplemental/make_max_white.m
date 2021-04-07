function new_cmap = make_max_white(cmap, varargin)
%  MAKE_MAX_WHITE  Takes a colormap and adjusts
%               the brightest values to be white
%
% Optional argument over-extends the maximum
% value to give more white in the middle.
%
% David Deepwell, 2017

% check input arguments
if nargin == 1
    mult = 1;
elseif nargin == 2
    mult = varargin{1};
else
    error('Too many input arguments.')
end

% colormap properties
[len, ~] = size(cmap);
mid = round(len/2);

% Convert to hsl values and get lightness
%try
%    add_dir('colorspace')
%catch
%    add_dir('colorspace','graham')
%end
%hsl = colorspace('rgb->hsl', cmap);
%L = hsl(:,3);
lab = colorspace('rgb->lab', cmap);
L = lab(:,1);
% calculate distance from lightest to darkest
min_L = min(L);
len_L  = max(L) - min_L;
%len_L2 = (1 - min_L)*mult;
len_L2 = (100 - min_L)*mult;

% make new hsl
new_L = (L-min_L)/len_L*len_L2 + min_L;
new_a = lab(:,2) - lab(mid,2);
new_b = lab(:,3) - lab(mid,3);
%new_h = hsl(:,1) - hsl(mid,1)+240;
%new_s = hsl(:,2) - hsl(mid,2);
new_lab = [new_L new_a new_b];
%new_hsl = [new_h new_s new_L];

% convert to new colormap
%new_cmap = colorspace('hsl->rgb', new_hsl);
new_cmap = colorspace('lab->rgb', new_lab);
%rm_dir('colorspace')
