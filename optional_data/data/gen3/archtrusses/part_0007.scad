$fn = 32;

// ----------------------------------------------------------------------
// Arched truss: span 237.6 mm, rise 80.78 mm, 8 panels
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panels = 8;               // number of panels
panel_p = 29.7;           // panel length, X
span = 237.6;             // span between the end joints
rise = 80.78;             // top chord rise above the springing
camber = 20.2;            // top chord height above the bottom chord at the ends
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

bottom = [[0, 0, 0], [29.7, 0, 0], [59.4, 0, 0], [89.1, 0, 0], [118.8, 0, 0], [148.5, 0, 0], [178.2, 0, 0], [207.9, 0, 0], [237.6, 0, 0]];
top = [[0, 0, 20.2], [29.7, 0, 55.541], [59.4, 0, 80.785], [89.1, 0, 95.931], [118.8, 0, 100.98], [148.5, 0, 95.931], [178.2, 0, 80.785], [207.9, 0, 55.541], [237.6, 0, 20.2]];

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
