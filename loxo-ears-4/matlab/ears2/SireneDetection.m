%% Time analysis (v.3)
count = 0;
Freq = 0;
oldFreq = 0;
sirenFlag = 0;
siren = zeros(1,length(data_t(1,:)));

%t = 0:timestep:timeaudio+40*timestep; % Seulement pour FFT

tol = 20; %Hz
time = 0;
mintime = 0.5; %minimum duration of one siren tone in seconds
maxtime = 0.9; %maximum duration of one siren tone in seconds
sirentime = 0;

sizeSlide = floor(mintime/timestep);
slideTable = zeros(1,sizeSlide);
periode = 0;

n=1;
while n <= length(data_t(1,:))-sizeSlide
    n = n+1;
    count = 0;
    if sirenFlag
        time = time + timestep;
    end
    for m = 1:sizeSlide
        slideTable(m) = data_t(1,n+sizeSlide-m);
        if (slideTable(1) >= slideTable(m) - tol) && (slideTable(1) <= slideTable(m) + tol)
            count = count + 1;
        end
    end
    if count >= floor(0.8*sizeSlide) && slideTable(1) ~= 0 % 80% des valeurs ok
        Freq = slideTable(1);
        if time > maxtime
            sirenFlag = 0;
            periode = 0;
        end
        if sirenFlag 
            if (Freq >= 1.2*oldFreq) &&  (Freq <= 1.4*oldFreq)
                for index = round(n-(time/timestep)):round(n+(time/timestep))
                    siren(index) = 1;
                end
                sirenflag = 0;
                periode = periode + 1;
            elseif (Freq <= oldFreq/1.2) &&  (Freq >= oldFreq/1.4)
                for index = round(n-(time/timestep)):round(n+(time/timestep))
                    siren(index) = 1;
                end
                sirenflag = 0;
                periode = periode + 1;
            end
        else 
            sirenFlag = 1;
            oldFreq = Freq;
            n = n + sizeSlide;
            time = sizeSlide * timestep;
        end
    end
    if mean(slideTable) < 300
        sirenFlag = 0;
        periode = 0;
    end
%     if periode >= 3
%         for y = 1:50
%             siren(n+y) = 1;
%         end
%     end
end

figure(2)
%figure(4)
ax(2) = subplot(2,1,2)
stem(t,siren)
set(gca,'FontSize',12)
ylim([0 1.1]);
xlim([0 90])
xlabel('[t] = s','Fontsize',18);
ylabel('Siren alarm','Fontsize',16);

linkaxes(ax,'x')