// Blind cap nut.
$fn = 60;
eps = 0.02;
thread_d = 10.5;
flat = 17;
height = 12;
body_h = height*0.65;
difference() {
    union() {
        cylinder(d=flat/cos(30),h=body_h,$fn=6);
        translate([0,0,body_h]) cylinder(d1=flat/cos(30),d2=thread_d+4,h=height-body_h,$fn=6);
    }
    translate([0,0,-eps]) cylinder(d=thread_d,h=height-1+eps);
}
