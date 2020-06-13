
k=imread('rice.JPG'); 
a=rgb2gray(k);          
radius=1;
b=fspecial('disk',1);
c=imfilter(a,b,'replicate');
level=graythresh(c);
d=imbinarize(c,level);
figure,imshow(k),figure,imshow(a),figure,imshow(c),figure,imshow(d);
e=edge(d,'canny');

labeledimg=bwlabel(e,8);
imshow(labeledimg);
coloredlabels=label2rgb(labeledimg,'hsv','k','shuffle');
imshow(coloredlabels);
blobmeasurements=regionprops('struct',labeledimg,'all');
numofblobs=size(blobmeasurements,1);
figure,imshow(k);
hold on;
boundaries = bwboundaries(d);
numofboundaries=size(boundaries,1);
for l=1:numofboundaries
    thisboundary=boundaries{l};
    plot(thisboundary(:,2),thisboundary(:,1),'g','LineWidth',2);
end
hold off;
textFontSize = 14;	% Used to control size of "blob number" labels put atop the image.
labelShiftX = -7;	% Used to align the labels in the centers of the coins.
blobECD = zeros(1, numofblobs);
fprintf(1,'Blob #    Area   Perimeter Major-Axis-Length   Minor-Axis Length \n');
% Loop over all blobs printing their measurements to the command window.
for x = 1 : numofblobs           % Loop through all blobs.
	blobArea = blobmeasurements(x).Area;		% Get area.
	blobPerimeter = blobmeasurements(x).Perimeter;		% Get perimeter.
	blobCentroid = blobmeasurements(x).Centroid;% Get centroid one at a time
	blobmajor=blobmeasurements(x).MajorAxisLength;
        blobminor=blobmeasurements(x).MinorAxisLength;
	fprintf(1,'# %2d %11.1f %8.1f %8.1f     %8.1f\n', x, blobArea, blobPerimeter,blobmajor,blobminor);
	% Put the "blob number" labels on the "boundaries" grayscale image.
	text(blobCentroid(1) + labelShiftX, blobCentroid(2), num2str(x), 'FontSize', textFontSize, 'FontWeight', 'Bold');
end