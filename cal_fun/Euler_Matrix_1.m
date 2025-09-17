function g = Euler_Matrix_1(A1,B,A2)
    g3 = [cos(A2),sin(A2),0;-sin(A2),cos(A2),0;0,0,1];
    g2 = [1,0,0;0,cos(B),sin(B);0,-sin(B),cos(B)];
    g1 = [cos(A1),sin(A1),0;-sin(A1),cos(A1),0;0,0,1];
    g = g3 * g2 * g1;%连续左乘，逆时针旋转
end