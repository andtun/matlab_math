N_PARTICLES = 50;
AX_LIMIT = 5;
dt = 0.01;
epsilon = 1;
sigma = 0.1;
WAIT = 0.0;

syms x y
U = 4*epsilon*((sigma/sqrt(x^2 + y^2))^12 - (sigma/sqrt(x^2 + y^2))^6);
% минусы далее в коде
F_x = matlabFunction(diff(U,x));
F_y = matlabFunction(diff(U,y));

tracks = 1/255*[200,200,200];
particles = AX_LIMIT*rand(N_PARTICLES,2);
x_array = particles(:,1);
y_array = particles(:,2);
x_speed = zeros(N_PARTICLES,1);
y_speed = zeros(N_PARTICLES,1);
x_forces_array = zeros(N_PARTICLES,1);
y_forces_array = zeros(N_PARTICLES,1);
next_x_forces_array = zeros(N_PARTICLES,1);
next_y_forces_array = zeros(N_PARTICLES,1);
x_tracks = zeros(N_PARTICLES,1);
y_tracks = zeros(N_PARTICLES,1);

h = scatter(particles(:,1),particles(:,2));
xlim([0 AX_LIMIT]);
ylim([0 AX_LIMIT]);
hold on;
for i = 1:inf
    for n = 1:N_PARTICLES
        nx_forces_array = zeros(N_PARTICLES,1);
        ny_forces_array = zeros(N_PARTICLES,1);
        for m = 1:N_PARTICLES
            if m ~= n
                rx = (x_array(m) - x_array(n));
                ry = (y_array(m) - y_array(n));
                nx_forces_array(m) = -F_x(rx, ry);
                ny_forces_array(m) = -F_y(rx, ry);
            end
        end
        x_forces_array(n) = sum(nx_forces_array);
        y_forces_array(n) = sum(ny_forces_array);
    end
    for n = 1:N_PARTICLES
        next_x = x_array(n) + x_speed(n)*dt + x_forces_array(n)*dt*dt/2;
        next_y = y_array(n) + y_speed(n)*dt + y_forces_array(n)*dt*dt/2;
        plot([x_array(n); next_x], [y_array(n); next_y], 'Color',tracks,'MarkerSize',2);
        x_array(n) = next_x;
        y_array(n) = next_y;
        for m = 1:N_PARTICLES
            nx_forces_array = zeros(N_PARTICLES,1);
            ny_forces_array = zeros(N_PARTICLES,1);
            if m ~= n
                rx = (x_array(m) - x_array(n));
                ry = (y_array(m) - y_array(n));
                nx_forces_array(m) = -F_x(rx, ry);
                ny_forces_array(m) = -F_y(rx, ry);
            end
        end
        next_x_forces_array(n) = sum(nx_forces_array);
        next_y_forces_array(n) = sum(ny_forces_array);
        x_speed(n) = x_speed(n) + (next_x_forces_array(n)+x_forces_array(n))*dt/2;
        y_speed(n) = y_speed(n) + (next_y_forces_array(n)+y_forces_array(n))*dt/2;
        if x_array(n) >= AX_LIMIT
            x_array(n) = 0;
        elseif x_array(n) <= 0
            x_array(n) = AX_LIMIT;
        elseif y_array(n) >= AX_LIMIT
            y_array(n) = 0;
        elseif y_array(n) <= 0
            y_array(n) = AX_LIMIT;
        end
    end
            
   set(h,'XData',x_array,'YData',y_array);
   drawnow
   pause(WAIT)
end
hold off;