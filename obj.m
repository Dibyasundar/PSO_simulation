function[o]=obj(x,y)
%o=x^2+y^2+10*cos(2*pi*x);
o=x*exp(-(x^2+y^2));
end