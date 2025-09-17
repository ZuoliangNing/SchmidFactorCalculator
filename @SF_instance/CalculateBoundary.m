function a = CalculateBoundary(a,app)
A = a.EulerAngles;

a1 = ReshapeSchmidtFactorsMatrix(a.XYUniqueIC,A(:,1));
a2 = ReshapeSchmidtFactorsMatrix(a.XYUniqueIC,A(:,2));
a3 = ReshapeSchmidtFactorsMatrix(a.XYUniqueIC,A(:,3));
figure
image(a1,'CDataMapping','scaled');
figure
image(a2,'CDataMapping','scaled');
figure
image(a3,'CDataMapping','scaled');
c = colorbar;
c.Limits = [0,6.29];
[FX,FY] = gradient(F) 