$fn = 32;

// ----------------------------------------------------------------------
// Arched truss: span 233.6 mm, rise 51.39 mm, 8 panels
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panels = 8;               // number of panels
panel_p = 29.2;           // panel length, X
span = 233.6;             // span between the end joints
rise = 51.39;             // top chord rise above the springing
camber = 12.85;           // top chord height above the bottom chord at the ends
chord_r = 3.8;            // chord member radius
diag_r = 2.8;             // diagonal radius
joint_r = 7.08;           // joint ball radius

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

bottom = [[0, 0, 0], [29.2, 0, 0], [58.4, 0, 0], [87.6, 0, 0], [116.8, 0, 0], [146, 0, 0], [175.2, 0, 0], [204.4, 0, 0], [233.6, 0, 0]];
top = [[0, 0, 12.85], [29.2, 0, 32.516], [58.4, 0, 49.188], [87.6, 0, 60.328], [116.8, 0, 64.24], [146, 0, 60.328], [175.2, 0, 49.188], [204.4, 0, 32.516], [233.6, 0, 12.85]];

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
