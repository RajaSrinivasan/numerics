with numlib.statistics;
with numlib.polynomials;

package numlibfloat is
   package lib is new numlib (float);
   package statspkg is new lib.statistics;
   package polypkg is new lib.polynomials;
end numlibfloat;
