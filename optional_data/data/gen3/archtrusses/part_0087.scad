$fn = 32;

// ----------------------------------------------------------------------
// Arched truss: span 132 mm, rise 44.88 mm, 6 panels
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panels = 6;               // number of panels
panel_p = 22;             // panel length, X
span = 132;               // span between the end joints
rise = 44.88;             // top chord rise above the springing
camber = 15.71;           // top chord height above the bottom chord at the ends
chord_r = 2.6;            // chord member radius
diag_r = 2.8;             // diagonal radius
joint_r = 5.73;           // joint ball radius

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

bottom = [[0, 0, 0], [22, 0, 0], [44, 0, 0], [66, 0, 0], [88, 0, 0], [110, 0, 0], [132, 0, 0]];
top = [[0, 0, 15.71], [22, 0, 40.643], [44, 0, 55.603], [66, 0, 60.59], [88, 0, 55.603], [110, 0, 40.643], [132, 0, 15.71]];

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
