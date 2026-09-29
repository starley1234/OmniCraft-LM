$fn = 32;

// ----------------------------------------------------------------------
// Arched truss: span 110 mm, rise 37.4 mm, 5 panels
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panels = 5;               // number of panels
panel_p = 22;             // panel length, X
span = 110;               // span between the end joints
rise = 37.4;              // top chord rise above the springing
camber = 13.09;           // top chord height above the bottom chord at the ends
chord_r = 3;              // chord member radius
diag_r = 2.4;             // diagonal radius
joint_r = 5.76;           // joint ball radius

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

bottom = [[0, 0, 0], [22, 0, 0], [44, 0, 0], [66, 0, 0], [88, 0, 0], [110, 0, 0]];
top = [[0, 0, 13.09], [22, 0, 35.073], [44, 0, 48.66], [66, 0, 48.66], [88, 0, 35.073], [110, 0, 13.09]];

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
