$fn = 32;

// ----------------------------------------------------------------------
// Arched truss: span 204 mm, rise 44.88 mm, 6 panels
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panels = 6;               // number of panels
panel_p = 34;             // panel length, X
span = 204;               // span between the end joints
rise = 44.88;             // top chord rise above the springing
camber = 11.22;           // top chord height above the bottom chord at the ends
chord_r = 2.6;            // chord member radius
diag_r = 2.4;             // diagonal radius
joint_r = 5.31;           // joint ball radius

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

bottom = [[0, 0, 0], [34, 0, 0], [68, 0, 0], [102, 0, 0], [136, 0, 0], [170, 0, 0], [204, 0, 0]];
top = [[0, 0, 11.22], [34, 0, 37.707], [68, 0, 52.097], [102, 0, 56.1], [136, 0, 52.097], [170, 0, 37.707], [204, 0, 11.22]];

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
