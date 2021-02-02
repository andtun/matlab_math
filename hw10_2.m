N = 5;
dt = 0.001;
q2 = 1;
m = 1;
k = 1;

x_border = 0.2;
y_border = x_border;
loyolagray = 1/255*[200,200,200];

data = x_border*rand(N,2);

x_coords = data(:,1);
y_coords = data(:,2);
prev_x_coords = x_coords;
prev_y_coords = y_coords;
x_forces = zeros(N,1);
y_forces = zeros(N,1);
x_traces = zeros(N,1);
y_traces = zeros(N,1);

h = scatter(data(:,1),data(:,2));
%xlim([0 x_border]);
%ylim([0 y_border]);
hold on;

for i = 1:inf
    next_x_coords = zeros(N, 1);
    next_y_coords = zeros(N, 1);
    set(h,'XData',x_coords,'YData',y_coords);
    drawnow
    for n = 1:N
        nx_forces = zeros(N,1);
        ny_forces = zeros(N,1);
        for m = 1:N
            if n ~= m
                rx = (x_coords(m) - x_coords(n));
                ry = (y_coords(m) - y_coords(n));
                r3 = sqrt(rx^2 + ry^2)^3;
                fx = -k*q2*rx/r3;
                fy = -k*q2*ry/r3;
                nx_forces(m) = fx;
                ny_forces(m) = fy;
            end
        end
        x_forces(n) = sum(nx_forces);
        y_forces(n) = sum(ny_forces);
        next_x_coords(n) = 2*x_coords(n) - prev_x_coords(n) + x_forces(n)/2/m*dt*dt;
        next_y_coords(n) = 2*y_coords(n) - prev_y_coords(n) + y_forces(n)/2/m*dt*dt;
    end
    prev_x_coords = x_coords;
    prev_y_coords = y_coords;
    x_coords = next_x_coords;
    y_coords = next_y_coords;
end
hold off;
        
