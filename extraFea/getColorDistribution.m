function colorBin = getColorDistribution(img)
colorBin = zeros(4096,1);
img = im2uint8(img);
img = bitshift(img,-4);
for i = size(img,1)
    for j = size(img,2)
        colorBin(img(i,j,1)*256+img(i,j,2)*16+img(i,j,1)) = colorBin(img(i,j,1)*256+img(i,j,2)*16+img(i,j,1)) +1;
    end
end
