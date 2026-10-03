$fn = 32;
// ----------------------------------------------------------------------
// Arched truss: span 238.4 mm, rise 66.75 mm, 8 panels
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panels = 8;               // number of panels
panel_p = 29.8;           // panel length, X
span = 238.4;             // span between the end joints
rise = 66.75;             // top chord rise above the springing
camber = 23.36;           // top chord height above the bottom chord at the ends
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

bottom = [[0, 0, 0], [29.8, 0, 0], [59.6, 0, 0], [89.4, 0, 0], [119.2, 0, 0], [149, 0, 0], [178.8, 0, 0], [208.6, 0, 0], [238.4, 0, 0]];
top = [[0, 0, 23.36], [29.8, 0, 54.662], [59.6, 0, 75.583], [89.4, 0, 86.948], [119.2, 0, 90.11], [149, 0, 86.948], [178.8, 0, 75.583], [208.6, 0, 54.662], [238.4, 0, 23.36]];

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
