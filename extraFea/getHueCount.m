function val = getHueCount(img)
img = im2uint8(img);
img = rgb2hsv(img);
range = [0.15 0.95];
sMin = 0.2;
numBins = 20;
alpha = 0.05;
index = 1;
for i = 0:size(img,1)
    for j = 0:size(img,2)
        if img(i,j,1) > range(1) && img(i,j,1) < range(2) && img(i,j,2) > sMin
            hue(index) = img(i,j,1);
            index = index + 1;
        end
    end
end
bins = hist(hue,numBins);
N = sum(bins > alpha * max(hue));
val = numBins - N;