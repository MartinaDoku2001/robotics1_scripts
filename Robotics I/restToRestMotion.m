function [time, position, velocity, acceleration] = restToRestMotion(totalTime, accelerationValue, speedValue, accelerationTime)
    % This function simulates the motion profile of a robot going from Rest-to-Rest
    % with improved visualization.

    % Parameters:
    % - totalTime: Total time of the motion profile.
    % - accelerationValue: Acceleration magnitude during the acceleration phase.
    % - speedValue: Constant speed during the coast phase.
    % - accelerationTime: Time duration of the acceleration phase.

    % Calculate coast time
    coastTime = totalTime - 2 * accelerationTime;

    % Time vector
    t1 = linspace(0, accelerationTime, 100);
    t2 = linspace(accelerationTime, accelerationTime + coastTime, 100);
    t3 = linspace(accelerationTime + coastTime, totalTime, 100);
    time = [t1, t2, t3];

    % Acceleration profile
    a1 = ones(1, 100) * accelerationValue;
    a2 = zeros(1, 100);
    a3 = -ones(1, 100) * accelerationValue;
    acceleration = [a1, a2, a3];

    % Velocity profile
    v1 = cumtrapz(t1, a1);
    v2 = ones(1, 100) * speedValue;
    v3 = cumtrapz(t3, a3) + v2(end);
    velocity = [v1, v2, v3];

    % Position profile
    x1 = cumtrapz(t1, v1);
    x2 = cumtrapz(t2, v2) + x1(end);
    x3 = cumtrapz(t3, v3) + x2(end);
    position = [x1, x2, x3];

    % Create a larger figure
    figure('Position', [100, 100, 1000, 700]); 

    % Position Plot
    subplot(3, 1, 1);
    plot(time, position, 'b-', 'LineWidth', 2); hold on;
    scatter([time(1), time(end)], [position(1), position(end)], 100, 'r', 'filled'); % Highlight start & end points
    title('Position vs Time', 'FontSize', 14, 'FontWeight', 'bold');
    xlabel('Time (s)', 'FontSize', 12);
    ylabel('Position (m)', 'FontSize', 12);
    grid on;
    legend('Position', 'Start/End', 'Location', 'best');
    
    % Velocity Plot
    subplot(3, 1, 2);
    plot(time, velocity, 'g-', 'LineWidth', 2); hold on;
    scatter(time(velocity == max(velocity)), max(velocity), 100, 'k', 'filled'); % Highlight max velocity
    title('Velocity vs Time', 'FontSize', 14, 'FontWeight', 'bold');
    xlabel('Time (s)', 'FontSize', 12);
    ylabel('Velocity (m/s)', 'FontSize', 12);
    grid on;
    legend('Velocity', 'Max Velocity', 'Location', 'best');

    % Acceleration Plot
    subplot(3, 1, 3);
    plot(time, acceleration, 'r-', 'LineWidth', 2); hold on;
    scatter(time(acceleration == max(acceleration)), max(acceleration), 100, 'b', 'filled'); % Highlight max accel
    scatter(time(acceleration == min(acceleration)), min(acceleration), 100, 'k', 'filled'); % Highlight min accel
    title('Acceleration vs Time', 'FontSize', 14, 'FontWeight', 'bold');
    xlabel('Time (s)', 'FontSize', 12);
    ylabel('Acceleration (m/s²)', 'FontSize', 12);
    grid on;
    legend('Acceleration', 'Max Accel', 'Min Accel', 'Location', 'best');

    % Enhance figure appearance
    sgtitle('Rest-to-Rest Motion Profile', 'FontSize', 16, 'FontWeight', 'bold');
end


