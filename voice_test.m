clc;
clear;
close all;

%% Create audio recorder object
recorder = audiorecorder(16000, 16, 2);

%% Record user's voice for 5 seconds
disp('Please record your voice');
drawnow();
pause(1);
recordblocking(recorder, 5);

%% Play recording and get data
play(recorder);

data = getaudiodata(recorder);

%% Feature extraction
f = voice_feature(data);

%% Load database
load database

%% Calculate distances
D = [];
for i = 1:size(F, 1)
    % Calculate sum of absolute differences in frequencies
    d = sum(abs(F(i) - f));
    D = [D d];
end

%% Check for unregistered user based on frequency distance
sm = inf;
ind = -1;
unregistered_threshold = 500; % Define threshold for frequency difference

for i = 1:length(D)%% iteration throughout the length of D
    if D(i) < sm
        sm = D(i);
        ind = i;
    end
end

%% Check if distance exceeds threshold and return unregistered if so
if sm > unregistered_threshold
    disp('User not registered! Frequency does not match pre-recorded voices.');
else
    detected_class = C(ind);
    disp('The detected User Number is:');
    disp(detected_class);
end