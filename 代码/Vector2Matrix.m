function m = Vector2Matrix(v, n)
% 将数组转换成为二维矩阵
% v:vector
% n:fragment
% m:matrix

t = 0;
[r, c] = size(v);
%1 transpose vector 
if(r > c)
    v = v';
    t = 1;
    c = n;
    r = ceil(r / n);
else
    r = ceil(c / n);
    c = n;
end
%2 get matrix
len = mod(length(v), n);
m = zeros(r, c);
for l = 1 : r - 1
    m(l, :) = v((l - 1) * n + 1 : l * n);
end
if len ~= 0
    m(r, 1:len) = v((r - 1) * n + 1 : (r - 1) * n + len);
else
    m(r, :) = v((r - 1) * n + 1 : (r - 1) * n + n);
end
%3 transpose matrix if needed
if(t == 1)
    m = m';
end

end