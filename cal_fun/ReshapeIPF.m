function val = ReshapeIPF(ind,IPFCData)
ind = uint32(ind);
m = max(ind);
val = nan([m,3]);
temp_val = nan(prod(m),1);
temp = ind(:,1)+(ind(:,2)-1)*m(1);
for i = 1:3
    temp_val(temp) = IPFCData(:,i);
    val(:,:,i) = reshape(temp_val,m);
end
ind_nan = isnan(val);
if sum(ind_nan,'all') > size(ind,1) * 0.1
temp = circshift(val,1,1); temp(1,:,:) = 0;
temp1 = temp;
temp = circshift(val,-1,1); temp(end,:,:) = 0;
temp1 = temp1 + temp;
temp = circshift(val,1,2); temp(:,1,:) = 0;
temp1 = temp1 + temp;
temp = circshift(val,-1,2); temp(:,end,:) = 0;
temp1 = temp1 + temp;
temp = 3*ones(m); temp(2:end-1,2:end-1) = 4;
temp1 = temp1./temp;
val(ind_nan) = temp1(ind_nan);
end