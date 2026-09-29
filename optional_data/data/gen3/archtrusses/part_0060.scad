$fn = 32;

// ----------------------------------------------------------------------
// Arched truss: span 180 mm, rise 61.2 mm, 6 panels
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panels = 6;               // number of panels
panel_p = 30;             // panel length, X
span = 180;               // span between the end joints
rise = 61.2;              // top chord rise above the springing
camber = 27.54;           // top chord height above the bottom chord at the ends
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

bottom = [[0, 0, 0], [30, 0, 0], [60, 0, 0], [90, 0, 0], [120, 0, 0], [150, 0, 0], [180, 0, 0]];
top = [[0, 0, 27.54], [30, 0, 58.14], [60, 0, 80.541], [90, 0, 88.74], [120, 0, 80.541], [150, 0, 58.14], [180, 0, 27.54]];

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
