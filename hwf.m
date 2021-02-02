for i = 3:5
    build_attractor(i);
end

function [] = build_attractor(r)
    [t, X] = ode45(@equation, [0 100], [0; 0; 0])
    plot3(X(:,1), X(:,2), X(:,3))
    xlabel("X(t)")
    ylabel("Y(t)")
    zlabel("Z(t)")
    title("Фазовый портрет для аттрактора с r = " + string(r))
    grid()
    function dXdt = equation(t, X)
    a = 0.2
    b = 0.2
    dx1 = -X(2) - X(3)
    dx2 = X(1) + a*X(2)
    dx3 = b + (X(1)-r)*X(3)
    
    dXdt = [dx1; dx2; dx3]
    end
end