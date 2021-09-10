clearvars
close all

% Connection capacity (Gb/s)
ul_speed = 2;
dl_speed = 2;

% Data parameters (Mb/s)
ul_rate = 603.2;
dl_rate = 279.2;
frequency = 30;

% Processor speed in Tflops
processor_speed = 0.01 : 0.01 : 3;

% Neural network complexity (Gflop)
complexities = [24, 8];

delay_local = zeros(2, length(processor_speed));
delay_edge = zeros(2, length(processor_speed));

communication = ul_rate / ul_speed / frequency + dl_rate / dl_speed / frequency;

for i = 1 : length(complexities)
    complexity = complexities(i);
    for j = 1 : length(processor_speed)
        computing = complexity / processor_speed(j);
        delay_local(i, j) = computing;
        delay_edge(i,j) = computing + communication;
    end
end

plot(processor_speed, delay_local(1, :))
hold on
plot(processor_speed, delay_edge(1, :))
plot(processor_speed, delay_local(2, :))
plot(processor_speed, delay_edge(2, :))
plot([0.0016, 0.0016],[0, 100], '--')
plot([0.07, 0.07],[0, 100], '--')
plot([0.72, 0.72],[0, 100], '--')
ylim([0, 50])
xlabel('Processor speed (TFlops)')
ylabel('Latency (ms)')
legend('NASNet (local)','NASNet (edge)', 'Xception (local)', 'Xception (edge)','Raspberry PI', 'nVidia Jetson TX1', 'nVidia Titan XP')