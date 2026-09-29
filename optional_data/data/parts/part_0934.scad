// Shoulder bolt.
$fn = 60;
eps = 0.02;
thread_d = 14;
shoulder_d = 18;
shoulder_l = 24;
thread_l = 20;
head_d = shoulder_d + 5;
union() {
    cylinder(d=thread_d,h=thread_l);
    translate([0,0,thread_l]) cylinder(d=shoulder_d,h=shoulder_l);
    translate([0,0,thread_l+shoulder_l]) cylinder(d=head_d,h=shoulder_d*0.35);
}
