function [matrix,n] = getSymmetryMatrix(type)
switch type
    case 'HCP'
        D6 = [1/2 , -sqrt(3)/2 , 0;
             sqrt(3)/2 , 1/2 , 0;
             0 , 0 , 1];
        D6 = [D6;D6^2;D6^3;D6^4;D6^5;D6^6];
        Dm = [1 , 0 , 0;
              0 , 1 , 0;
              0 , 0 , -1];
        Dm = [Dm,Dm^2];
        Dm2 = [-1 , 0 , 0;
              0 , 1 , 0;
              0 , 0 , 1];
        Dm2 = [Dm2;Dm2^2];
        D = mat2cell(D6*Dm,3*ones(6,1),[3,3]);
        D = cell2mat(D(:)');
        D = mat2cell(Dm2*D,3*ones(2,1),3*ones(12,1));
        D = cell2mat(D(:)');
end
ND = size(D,2)/3;
ind = false(ND,1);
matrix = [];
for i = 1:ND
    temp = D(:,1+(i-1)*3:i*3);
    if det(temp) > 0
        matrix = [matrix,temp]; %#ok<AGROW>
        ind(i) = true;
    end
end
n =sum(ind);