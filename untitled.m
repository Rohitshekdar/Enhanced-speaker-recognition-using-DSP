clc;
clear;
close all;

%% create audiorecorder object
recorder = audiorecorder(16000, 16, 2);

%% Record user's voice for 5 seconds
disp('Please record your voice');
drawnow(); % updates the figure and the callbacks
pause(1); % pause the process and then display the graph
recordblocking(recorder, 5); % records the audio for 5 seconds

% Get audio data and apply VAD
data = getaudiodata(recorder);

vad_threshold = 0.01; % Adjust this threshold according to your needs
vad_mask = data.^2 > vad_threshold;
vad_data = data(vad_mask);


% Play the filtered audio
sound(vad_data, 16000);

% Plot the original and filtered audio
figure;
subplot(2, 1, 1);
plot(data);
title('Original Audio');
xlabel('Sample');
ylabel('Amplitude');

subplot(2, 1, 2);
plot(vad_data);
title('Filtered Audio');
xlabel('Sample');
ylabel('Amplitude');

%% Extract voice features
f = voice_feature(vad_data);

%% Save user's data
uno = input('Enter your user number: ');

try
    load database
    clear C;
    F = [F; f]; % update the frequency array
    C = [C; uno]; % update the user number array
    save database F C
catch
    F = f; % if any error occurs, update with the latest values
    C = uno;
    save database F C
end

msgbox('Your voice is registered'); % GUI to display the message
