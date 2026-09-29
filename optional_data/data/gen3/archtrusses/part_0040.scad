$fn = 32;

// ----------------------------------------------------------------------
// Arched truss: span 235.2 mm, rise 65.86 mm, 8 panels
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panels = 8;               // number of panels
panel_p = 29.4;           // panel length, X
span = 235.2;             // span between the end joints
rise = 65.86;             // top chord rise above the springing
camber = 23.05;           // top chord height above the bottom chord at the ends
chord_r = 3.8;            // chord member radius
diag_r = 2;               // diagonal radius
joint_r = 6.44;           // joint ball radius

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

bottom = [[0, 0, 0], [29.4, 0, 0], [58.8, 0, 0], [88.2, 0, 0], [117.6, 0, 0], [147, 0, 0], [176.4, 0, 0], [205.8, 0, 0], [235.2, 0, 0]];
top = [[0, 0, 23.05], [29.4, 0, 51.864], [58.8, 0, 72.445], [88.2, 0, 84.794], [117.6, 0, 88.91], [147, 0, 84.794], [176.4, 0, 72.445], [205.8, 0, 51.864], [235.2, 0, 23.05]];

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
