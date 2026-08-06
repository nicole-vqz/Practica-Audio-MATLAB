function [Yout] = cuantificador_2(Xin,Nbits)
    particion = (65536/(2^Nbits)) - 1 : (65536/(2^Nbits)) : 65535;
    Yout = quantiz(Xin,particion);
end