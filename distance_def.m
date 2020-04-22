function D=distance_def(X,Y)
L=length(X);
if(L~=length(Y))
    D=-1;
else
    D_square=sum((X-Y).^2);
    D=sqrt(D_square);
%    D=D_square;
end
        
    