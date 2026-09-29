// Solid rivet.
$fn = 60;
eps = 0.02;
shank_d = 8;
head_d = 16;
length = 24;
union() { cylinder(d=shank_d,h=length); cylinder(d1=head_d,d2=shank_d,h=head_d*0.35); }
