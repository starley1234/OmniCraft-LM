$fn = 32;

// ----------------------------------------------------------------------
// Arched truss: span 236 mm, rise 51.92 mm, 8 panels
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panels = 8;               // number of panels
panel_p = 29.5;           // panel length, X
span = 236;               // span between the end joints
rise = 51.92;             // top chord rise above the springing
camber = 12.98;           // top chord height above the bottom chord at the ends
chord_r = 3;              // chord member radius
diag_r = 2.8;             // diagonal radius
joint_r = 6.16;           // joint ball radius

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

bottom = [[0, 0, 0], [29.5, 0, 0], [59, 0, 0], [88.5, 0, 0], [118, 0, 0], [147.5, 0, 0], [177, 0, 0], [206.5, 0, 0], [236, 0, 0]];
top = [[0, 0, 12.98], [29.5, 0, 32.849], [59, 0, 49.693], [88.5, 0, 60.948], [118, 0, 64.9], [147.5, 0, 60.948], [177, 0, 49.693], [206.5, 0, 32.849], [236, 0, 12.98]];

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
