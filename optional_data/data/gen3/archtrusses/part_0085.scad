$fn = 32;

// ----------------------------------------------------------------------
// Arched truss: span 235.2 mm, rise 65.86 mm, 7 panels
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panels = 7;               // number of panels
panel_p = 33.6;           // panel length, X
span = 235.2;             // span between the end joints
rise = 65.86;             // top chord rise above the springing
camber = 23.05;           // top chord height above the bottom chord at the ends
chord_r = 3.4;            // chord member radius
diag_r = 2.4;             // diagonal radius
joint_r = 6.24;           // joint ball radius

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

bottom = [[0, 0, 0], [33.6, 0, 0], [67.2, 0, 0], [100.8, 0, 0], [134.4, 0, 0], [168, 0, 0], [201.6, 0, 0], [235.2, 0, 0]];
top = [[0, 0, 23.05], [33.6, 0, 55.308], [67.2, 0, 76.813], [100.8, 0, 87.566], [134.4, 0, 87.566], [168, 0, 76.813], [201.6, 0, 55.308], [235.2, 0, 23.05]];

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
