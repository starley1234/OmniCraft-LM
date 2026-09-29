$fn = 32;

// ----------------------------------------------------------------------
// Arched truss: span 182 mm, rise 40.04 mm, 7 panels
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panels = 7;               // number of panels
panel_p = 26;             // panel length, X
span = 182;               // span between the end joints
rise = 40.04;             // top chord rise above the springing
camber = 14.01;           // top chord height above the bottom chord at the ends
chord_r = 2.6;            // chord member radius
diag_r = 2;               // diagonal radius
joint_r = 4.92;           // joint ball radius

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

bottom = [[0, 0, 0], [26, 0, 0], [52, 0, 0], [78, 0, 0], [104, 0, 0], [130, 0, 0], [156, 0, 0], [182, 0, 0]];
top = [[0, 0, 14.01], [26, 0, 33.621], [52, 0, 46.696], [78, 0, 53.233], [104, 0, 53.233], [130, 0, 46.696], [156, 0, 33.621], [182, 0, 14.01]];

for (i = [0 : panels - 1]) member(bottom[i], bottom[i + 1], chord_r);
for (i = [0 : panels - 1]) member(top[i], top[i + 1], chord_r);
/* verticals */
for (i = [1 : panels - 1]) member(bottom[i], top[i], diag_r);
/* diagonals lean toward mid span */
for (i = [0 : panels - 1]) {
  if (i < panels / 2) {
    member(bottom[i], top[i + 1], diag_r);
  } else {
    member(top[i], bottom[i + 1], diag_r);
  }
}
/* joint balls */
for (i = [0 : panels]) joint(bottom[i], joint_r);
for (i = [0 : panels]) joint(top[i], joint_r);
