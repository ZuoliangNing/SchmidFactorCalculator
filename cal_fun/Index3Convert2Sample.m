function val = Index3Convert2Sample(TransferMatrix,temp)
m = size(temp,2);
n = length(TransferMatrix)/3;
val = [ sum( reshape(TransferMatrix(:,1) .* temp,[3,m*n]),1 ); ...
        sum( reshape(TransferMatrix(:,2) .* temp,[3,m*n]),1 ); ...
        sum( reshape(TransferMatrix(:,3) .* temp,[3,m*n]),1 )];
end