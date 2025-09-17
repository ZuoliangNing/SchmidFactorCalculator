function a = CalculateIPF(a,app)

AllDirectionSample3 = [1,0,0; 0,1,0; 0,0,1];
% 若为Channel5,需要修改以上！201014
for i = 1:3
    DirectionSample3 = AllDirectionSample3(i,:);
    DirectionsCrystal3 = reshape(...
        a.InvertTransferMatrix * DirectionSample3', ...
        3,a.N);
    X = DirectionsCrystal3(1,:)';
    Y = DirectionsCrystal3(2,:)';
    Z = DirectionsCrystal3(3,:)';
    ind = Z<0;
    X(ind) = -X(ind);
    Y(ind) = -Y(ind);
    Z(ind) = -Z(ind);
    [theta,rho] = cart2pol(X,Y); % theta - -pi~pi
    rho = rho./( 1 + Z );
    theta(theta<0) = theta(theta<0) + 2*pi; % theta - 0~2pi
    theta = rem(theta,pi/3); % theta - 0~pi/3
    theta(theta>pi/6) = pi/3 - theta(theta>pi/6); % theta - 0~pi/6
    C = zeros(a.N,3);
    C(:,1) = 1 - rho.^0.7 + 0.1;
    C(:,3) = theta*6/pi;
    C(:,2) = 1 - C(:,3);
    C(:,2:3) = C(:,2:3).*rho + 0.1;
    C(C>1) = 1;
    temp = max(C,[],2);
    C = C./temp;
%     C(C>1) = 1;
    IPFCData = ReshapeIPF(a.XYUniqueIC,C);
    a.IPF{i} = matlab.graphics.primitive.Image;
    a.IPF{i}.XData = a.uniX;
    a.IPF{i}.YData = a.uniY;
    a.IPF{i}.CData = permute(IPFCData,[2,1,3]);
    a.IPF{i}.Parent = app.UIAxes;
    a.IPF{i}.Visible = 'off';
end

end