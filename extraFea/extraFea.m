%% read in file list
imgFileList = 'fileName.txt';
fileName = importdata(imgFileList);

% read in image
% set index
index = 1;
img = imread(fileName{index});

%% color distribution
colorBin = colorDistribution(img);

%% Hue Count
hueCount = getHueCount(img);