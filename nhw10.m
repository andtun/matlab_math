N = 50;
dt = 0.01;
wait = 0.0;
epsilon = 1;
sigma = 0.1;

syms x y
U = 4*epsilon*((sigma/sqrt(x^2 + y^2))^12 - (sigma/sqrt(x^2 + y^2))^6);
F_x = matlabFunction(diff(U,x));
F_y = matlabFunction(diff(U,y));


x_border = 5;
y_border = x_border;
loyolagray = 1/255*[200,200,200];

data = x_border*rand(N,2);

x_coords = data(:,1);
y_coords = data(:,2);
x_velocities = zeros(N,1);
y_velocities = zeros(N,1);
x_forces = zeros(N,1);
y_forces = zeros(N,1);
next_x_forces = zeros(N,1);
next_y_forces = zeros(N,1);
x_traces = zeros(N,1);
y_traces = zeros(N,1);

h = scatter(data(:,1),data(:,2));
xlim([0 x_border]);
ylim([0 y_border]);
hold on;
for i = 1:inf
    for n = 1:N
        nx_forces = zeros(N,1);
        ny_forces = zeros(N,1);
        for m = 1:N
            if m ~= n
                rx = (x_coords(m) - x_coords(n));
                ry = (y_coords(m) - y_coords(n));
                r3 = sqrt(rx^2 + ry^2)^3;
                fx = F_x(rx, ry);
                fy = F_y(rx, ry);
                nx_forces(m) = -fx;
                ny_forces(m) = -fy;
            end
        end
        x_forces(n) = sum(nx_forces);
        y_forces(n) = sum(ny_forces);
        next_x = x_coords(n) + x_velocities(n)*dt + x_forces(n)*dt*dt/2;
        next_y = y_coords(n) + y_velocities(n)*dt + y_forces(n)*dt*dt/2;
        plot([x_coords(n); next_x], [y_coords(n); next_y], 'Color',loyolagray,'MarkerSize',2);
        x_coords(n) = next_x;
        y_coords(n) = next_y;
        for m = 1:N
            nx_forces = zeros(N,1);
            ny_forces = zeros(N,1);
            if m ~= n
                rx = (x_coords(m) - x_coords(n));
                ry = (y_coords(m) - y_coords(n));
                r3 = sqrt(rx^2 + ry^2)^3;
                fx = F_x(rx, ry);
                fy = F_y(rx, ry);
                nx_forces(m) = -fx;
                ny_forces(m) = -fy;
            end
        end
        next_x_forces(n) = sum(nx_forces);
        next_y_forces(n) = sum(ny_forces);
        x_velocities(n) = x_velocities(n) + (next_x_forces(n)+x_forces(n))*dt/2;
        y_velocities(n) = y_velocities(n) + (next_y_forces(n)+y_forces(n))*dt/2;
        if x_coords(n) >= x_border
            x_coords(n) = 0;
        elseif x_coords(n) <= 0
            x_coords(n) = x_border;
        elseif y_coords(n) >= y_border
            y_coords(n) = 0;
        elseif y_coords(n) <= 0
            y_coords(n) = y_border;
        end
    end
            
   set(h,'XData',x_coords,'YData',y_coords);
   drawnow
   pause(wait)
end
hold off;