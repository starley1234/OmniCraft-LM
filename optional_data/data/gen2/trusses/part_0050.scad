$fn = 32;

// ----------------------------------------------------------------------
// Warren truss: span 239.4 mm, height 100 mm, 7 equal panels
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panels = 7;               // number of equal panels
panel_p = 34.2;           // panel length, X
span = 239.4;             // span between the end joints
frame_h = 100;            // truss height, Z
chord_r = 3.5;            // chord member radius
diag_r = 2.6;             // diagonal member radius
joint_r = 4.2;            // joint ball radius

module member(a, b, r) {
  /* rod: cylinder from joint a to joint b */
  d = b - a;
  length = norm(d);
  translate(a) rotate([0, acos(d[2] / length), atan2(d[1], d[0])])
    cylinder(h = length, r = r);
}

module joint(p, r) {
  /* ball at the joint centre */
  translate(p) sphere(r = r);
}

bottom = [for (i = [0 : panels]) [i * panel_p, 0, 0]];
top = [for (i = [0 : panels - 1]) [i * panel_p + panel_p / 2, 0, frame_h]];

for (i = [0 : panels - 1]) member(bottom[i], bottom[i + 1], chord_r);
for (i = [0 : 5]) member(top[i], top[i + 1], chord_r);

/* zig-zag diagonals up to the mid-panel joints */
for (i = [0 : panels - 1]) {
  member(bottom[i], top[i], diag_r);
  member(bottom[i + 1], top[i], diag_r);
}

/* joint balls */
for (i = [0 : panels]) joint(bottom[i], joint_r);
for (i = [0 : 6]) joint(top[i], joint_r);
