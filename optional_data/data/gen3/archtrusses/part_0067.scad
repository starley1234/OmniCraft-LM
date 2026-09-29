$fn = 32;

// ----------------------------------------------------------------------
// Arched truss: span 176 mm, rise 59.84 mm, 8 panels
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panels = 8;               // number of panels
panel_p = 22;             // panel length, X
span = 176;               // span between the end joints
rise = 59.84;             // top chord rise above the springing
camber = 14.96;           // top chord height above the bottom chord at the ends
chord_r = 3.8;            // chord member radius
diag_r = 2.4;             // diagonal radius
joint_r = 6.74;           // joint ball radius

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

bottom = [[0, 0, 0], [22, 0, 0], [44, 0, 0], [66, 0, 0], [88, 0, 0], [110, 0, 0], [132, 0, 0], [154, 0, 0], [176, 0, 0]];
top = [[0, 0, 14.96], [22, 0, 41.14], [44, 0, 59.84], [66, 0, 71.06], [88, 0, 74.8], [110, 0, 71.06], [132, 0, 59.84], [154, 0, 41.14], [176, 0, 14.96]];

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
