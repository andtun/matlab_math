A = [1 1 1; 2 1 -6; 3 -2 0];
B = [2; -1; 8];
x = A\B;
fprintf("� ������ 1 ������:\n");
for i = 1:3
    fprintf("x%i = %f\n", i, x(i));
end

fprintf("---\n����� 2:\n");

n = 5;
A = zeros(n);

for k = 1:5
    for m = 1:5
        v = sqrt(2/(n+1))*exp(pi/(n+1)*k*(m-1)*1j);
        A(k,m) = v;
    end
end
fprintf("A = \n");
disp(A);
f = (A * inv(A)) == eye(n);
fprintf("������� ��������: ");
disp(all(f(:)));

fprintf("---\n����� 3:\n");

n = 6;
A = randi([-10, 10], n, n);
fprintf("A = \n");
disp(A);
fprintf("���� �������: %d\n", rank(A));
fprintf("������������ �������: %d\n", det(A));
fprintf("�� �������: \n");
[U, R] = eig(A);
R = diag(R);
for i = 1:6
    fprintf("%d-� ����������� ������:\n", i);
    disp(U(:, i));
    fprintf("%d-� ����������� ��������:%f\n\n", i, R(i));
end

fprintf("�������� �������: A* =\n");
disp(inv(A));
fprintf("\n������� ���� �� ������������� ���������:\n");
disp(A .* (A>0));
fprintf("\n������� ���� �� ������������� ���������:\n");
disp(A .* (A<0));
toSort = sum(A, 2);
toSort = [toSort, A];
toSort = sortrows(toSort);
fprintf("\n������ ������������� �� ����� ���������:\n");
disp(toSort(:,2:n+1));


