%% Recup and plot

clc; clear; close all;

root = 'Samples';

F = [1, 2];
N_F = length(F);
nData = 5;

letters = ['a', 'e', 'i', 'o', 'u'];
nLetters = length(letters);

dataLetters = zeros([nLetters, N_F, nData]);

for l=1:nLetters
    rootCsv = fullfile(root, sprintf('TSIG_TP1_%s', letters(l)));
    dataTemp = readmatrix(rootCsv, 'Delimiter', ';');
    dataTemp2 = dataTemp(1:nData,:);
    dataLetters(l,F(1),:) = dataTemp2(:,3);
    dataLetters(l,F(2),:) = dataTemp2(:,4);
end

%% Plot

colors = lines(length(letters));
figure(1);
hold on;
for l=1:length(letters)
    x_data = squeeze(dataLetters(l, F(2), :));
    y_data = squeeze(dataLetters(l, F(1), :));
    scatter(x_data, y_data, 50, colors(l, :), 'filled');
    text(dataLetters(l,F(2),:), dataLetters(l,F(1),:), letters(l), 'FontSize', 10, 'HorizontalAlignment', 'right', 'VerticalAlignment', 'top');
    xlabel('F2 [Hz]');
    ylabel('F1 [Hz]');
end

%% Mean and std

meanF = zeros(nLetters, N_F);
stdF = zeros(nLetters, N_F);

for l=1:nLetters
    for f=1:N_F
        meanF(l,f) = mean(dataLetters(l,f,:));
        stdF(l,f) = std(dataLetters(l,f,:));
    end
end

%% Recup 2 (test part)

nData2 = 8;

dataLetters2 = zeros([nLetters, N_F, nData2]);

for l=1:nLetters
    rootCsv = fullfile(root, sprintf('TSIG_TP1_%s', letters(l)));
    dataTemp = readmatrix(rootCsv, 'Delimiter', ';');
    dataTemp2 = dataTemp(1:nData2,:);
    dataLetters2(l,F(1),:) = dataTemp2(:,3);
    dataLetters2(l,F(2),:) = dataTemp2(:,4);
end

%% Fct distance

dL2 = zeros([nLetters, nData2, nLetters]);
for lData=1:nLetters
    for d=1:nData2
        for l=1:nLetters
            sumData = 0;
            for f=1:N_F
                sumData = sumData + (dataLetters2(lData,F(f),d)-meanF(l,f))^2;
            end
            dL2(lData,d,l) = sqrt(sumData);
        end
    end
end

dL1 = zeros(nLetters, nData2, nLetters);
for lData=1:nLetters
    for d=1:nData2
        for l=1:nLetters
            sumData = 0;
            for f=1:N_F
                sumData = sumData + abs(dataLetters2(lData,F(f),d)-meanF(l,f));
            end
            dL1(lData,d,l) = sumData;
        end
    end
end

dPlanInfinite = zeros(nLetters, nData2, nLetters);
for lData=1:nLetters
    for d=1:nData2
        for l=1:nLetters
            maxD = 0;
            for f=1:N_F
                n = abs(dataLetters2(lData,F(f),d)-meanF(l,f));
                if n > maxD
                    maxD = n;
                end
            end
            dPlanInfinite(lData,d,l) = maxD;
        end
    end
end

dPlanMahalanobis = zeros(nLetters, nData2, nLetters);
for lData=1:nLetters
    for d=1:nData2
        for l=1:nLetters
            sumData = 0;
            for f=1:N_F
                sumData = sumData + (dataLetters2(lData,F(f),d)-meanF(l,f))^2 / stdF(l,f)^2;
            end
            dPlanMahalanobis(lData,d,l) = sqrt(sumData);
        end
    end
end

%% Result

resultDL2 = zeros([nLetters, nLetters]); %mesuré, réel
for lData=1:nLetters
    for d=1:nData2
        min = 1000000;
        lMin = 0;
        for l=1:nLetters
            if dL2(lData,d,l) < min
                min = dL2(lData,d,l);
                lMin = l;
            end
        end
        resultDL2(lMin,lData) = resultDL2(lMin,lData)+1;
    end
end

resultDL1 = zeros([nLetters, nLetters]); %mesuré, réel
for lData=1:nLetters
    for d=1:nData2
        min = 1000000;
        lMin = 0;
        for l=1:nLetters
            if dL1(lData,d,l) < min
                min = dL1(lData,d,l);
                lMin = l;
            end
        end
        resultDL1(lMin,lData) = resultDL1(lMin,lData)+1;
    end
end

resultDInf = zeros([nLetters, nLetters]); %mesuré, réel
for lData=1:nLetters
    for d=1:nData2
        min = 1000000;
        lMin = 0;
        for l=1:nLetters
            if dPlanInfinite(lData,d,l) < min
                min = dPlanInfinite(lData,d,l);
                lMin = l;
            end
        end
        resultDInf(lMin,lData) = resultDInf(lMin,lData)+1;
    end
end

resultDMa = zeros([nLetters, nLetters]); %mesuré, réel
for lData=1:nLetters
    for d=1:nData2
        min = 1000000;
        lMin = 0;
        for l=1:nLetters
            if dPlanMahalanobis(lData,d,l) < min
                min = dPlanMahalanobis(lData,d,l);
                lMin = l;
            end
        end
        resultDMa(lMin,lData) = resultDMa(lMin,lData)+1;
    end
end
