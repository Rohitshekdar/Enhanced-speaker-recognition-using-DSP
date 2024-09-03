clc;
clear;
close all;
%% create arecorder object
recorder=audiorecorder(16000,16,2);
%% Record user's voice for 5 seconds
disp('please record your voice');
drawnow();
pause(1);
recordblocking(recorder,5);
play(recorder);
data=getaudiodata(recorder);
plot(data);
figure;  
%% Feature extraction
f=voice_feature(data);
%% classify
load database
 D=[];
for i=1:size(F,1)
    d=sum(abs(F(i)-f));
    D=[D d];
end    
%% smallest distance
sm=inf;
ind=-1;
for i=1:length(D)
    if(D(i)<sm)
        sm=D(i);
        ind=i;
    end
end
detected_class=C(ind);
disp('The detected class is :');
disp(detected_class);
