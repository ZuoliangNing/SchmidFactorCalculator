function C = getIPFlegendCData
aLim = pi/6;
PosPre = [0.01,0.01];

x = 0:PosPre(1):1;
Nx = length(x);
y = 0:PosPre(1):0.5;
Ny = length(y);
[X,Y] = meshgrid(x,y);
[theta,rho] = cart2pol(X(:),Y(:)); % theta \ rho
p = [theta,rho];
N = length(p);

c(:,1) = 1 - p(:,2).^0.7 + 0.1;
c(:,3) = p(:,1)/aLim;
c(:,2) = 1-c(:,3);
c(:,2:3) = c(:,2:3).*p(:,2) + 0.1;
c(c>1) = 1;
temp = max(c,[],2);
c = c./temp;

ind = p(:,1)>aLim | p(:,2)>1;
% c(ind,:) = 0.94;
c(ind,:) = 1;

C = zeros(Ny,Nx,3);
for i = 1:3
   C(:,:,i) = reshape(c(:,i),Ny,Nx); 
end
end