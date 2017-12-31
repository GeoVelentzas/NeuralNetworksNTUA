function somUpdate(pattern,learningRate,neighborDist)
global  N IW index a;

%compute activations
a = somActivation(pattern,neighborDist);

%Change weights from Kohonen Rule
for i=1:N
    IW(i,:)=IW(i,:)+learningRate*a(i)*(pattern'-IW(i,:));
end


end
