WAIT = 0.01;
AX_LIMIT = 100;
N_PARTICLES = 200;

all_coords = randperm(AX_LIMIT^2, N_PARTICLES);
x_coords = mod(all_coords, AX_LIMIT);
y_coords = floor(all_coords / AX_LIMIT);

velocities = zeros(N_PARTICLES, 2);
for i = 1:N_PARTICLES
    t = randi(4);
    switch t
        case 1
            velocities(i,:) = [0 1];
        case 2
            velocities(i,:) = [0 -1];
        case 3
            velocities(i,:) = [1 0];
        case 4
            velocities(i,:) = [-1 0];
    end
end
            

h = scatter(x_coords,y_coords, 'b.');
%disp(x_coords);
%disp(y_coords);
xlim([0 AX_LIMIT-1]);
ylim([0 AX_LIMIT-1]);
grid on;
grid minor;
pause(WAIT);

for i = 1:inf
    
    for n = 1:N_PARTICLES
        for m = n+1:N_PARTICLES
                delta_x = abs(x_coords(n) - x_coords(m));
                delta_y = abs(y_coords(n) - y_coords(m));
                x_neighbors = (delta_x <= 1) && (delta_y == 0);
                y_neighbors = (delta_y <= 1) && (delta_x == 0);
                if (x_neighbors && (velocities(n,1) ~= 0)) || (y_neighbors && (velocities(n,2) ~= 0))
                    %if velocities(n,:) == velocities(m,:)
                    %    velocities(n,:) = (-1 * velocities(m,:));
                    if velocities(n,:) == (-1 * velocities(m,:))
                        %disp(velocities(n,:));
                        %disp(velocities(m,:));
                        velocities(n,:) = fliplr(velocities(n,:));
                        velocities(m,:) = fliplr(velocities(m,:));
                        %x_coords(n) = ceil(x_coords(n));
                        %y_coords(n) = ceil(y_coords(n));
                        %x_coords(m) = floor(x_coords(m));
                        %y_coords(m) = floor(y_coords(m));
                        %disp(velocities(n,:));
                        %disp(velocities(m,:));
                        %disp("---");
                    end
                end
            
        end
    end
    
    for n = 1:N_PARTICLES
        
        if (x_coords(n) >= AX_LIMIT-1)
            x_coords(n) = AX_LIMIT-1;
            velocities(n,:) = [-1 0];
        elseif (x_coords(n) <= 0)
            x_coords(n) = 0;
            velocities(n,:) = [1 0];
        end
        if (y_coords(n) >= AX_LIMIT-1)
            y_coords(n) = AX_LIMIT-1;
            velocities(n,:) = [0 -1];
        elseif (y_coords(n) <= 0)
            y_coords(n) = 0;
            velocities(n,:) = [0 1];
        end
        
        x_coords(n) = x_coords(n) + velocities(n,1);
        y_coords(n) = y_coords(n) + velocities(n,2);
    end
    
    
    
    set(h,'XData',x_coords,'YData',y_coords);
    drawnow
    pause(WAIT);
end
