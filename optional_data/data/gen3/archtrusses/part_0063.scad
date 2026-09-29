$fn = 32;

// ----------------------------------------------------------------------
// Arched truss: span 234.4 mm, rise 51.57 mm, 8 panels
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panels = 8;               // number of panels
panel_p = 29.3;           // panel length, X
span = 234.4;             // span between the end joints
rise = 51.57;             // top chord rise above the springing
camber = 18.05;           // top chord height above the bottom chord at the ends
chord_r = 3.4;            // chord member radius
diag_r = 2.8;             // diagonal radius
joint_r = 6.61;           // joint ball radius

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

bottom = [[0, 0, 0], [29.3, 0, 0], [58.6, 0, 0], [87.9, 0, 0], [117.2, 0, 0], [146.5, 0, 0], [175.8, 0, 0], [205.1, 0, 0], [234.4, 0, 0]];
top = [[0, 0, 18.05], [29.3, 0, 40.612], [58.6, 0, 56.728], [87.9, 0, 66.397], [117.2, 0, 69.62], [146.5, 0, 66.397], [175.8, 0, 56.727], [205.1, 0, 40.612], [234.4, 0, 18.05]];

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
