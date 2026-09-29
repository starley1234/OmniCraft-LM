// Acorn nut with domed top.
$fn = 60;
eps = 0.02;
thread_d = 10.5;
flat = 17;
height = 13;
body_h = height*0.55;
difference() {
    union() {
        cylinder(d=flat/cos(30),h=body_h,$fn=6);
        translate([0,0,body_h]) scale([1,1,0.65]) sphere(d=flat/cos(30));
    }
    translate([0,0,-eps]) cylinder(d=thread_d,h=height-1+eps);
}
