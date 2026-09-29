// Solid rivet.
$fn = 60;
eps = 0.02;
shank_d = 6;
head_d = 12;
length = 20;
union() { cylinder(d=shank_d,h=length); cylinder(d1=head_d,d2=shank_d,h=head_d*0.35); }
