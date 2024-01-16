% Load dataset
load('stopSignsAndCars.mat');
stopSigns = fullfile(toolboxdir('vision'),'visiondata',stopSignsAndCars{:,1});

% Positive datastore
imds = imageDatastore(stopSigns);
blds = boxLabelDatastore(stopSignsAndCars(:,2));
positiveInstances = combine(imds,blds);

% Negative datastore
negativeFolder = fullfile(matlabroot,'toolbox','vision','visiondata','nonStopSigns');
negativeImages = imageDatastore(negativeFolder);

%% Training 1
%{
NCS=1
output='output1.png'
FAR = 0.1
FT = 'HOG'
%}
%% Training 2
%{
NCS=2
output='output2.png'
FAR = 0.1
FT = 'HOG'
%}
%% Training 3
%{
NCS=3
output='output3.png'
FAR = 0.1
FT = 'HOG'
%}
%% Training 4
%{
NCS=2
output='outputHaar.png'
FAR = 0.1
FT = 'Haar'
%}
%% Training 5
%{
NCS=2
output='outputLBP.png'
FAR = 0.1
FT = 'LBP'
%}
%% Training 6

NCS=4
output='output13.png'
FAR = 0.1
FT = 'HOG'


trainCascadeObjectDetector('stopSignDetector.xml',positiveInstances,negativeFolder,FalseAlarmRate=0.01,NumCascadeStages=NCS, FeatureType=FT);
detector = vision.CascadeObjectDetector('stopSignDetector.xml');

img = imread('test13.png');
bbox = step(detector,img);
detectedImg = insertObjectAnnotation(img,'rectangle',bbox,'stop sign');

imwrite(detectedImg, output)


%figure;
%imshow(detectedImg);


