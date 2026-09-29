$fn = 32;

// ----------------------------------------------------------------------
// Arched truss: span 150 mm, rise 33 mm, 5 panels
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panels = 5;               // number of panels
panel_p = 30;             // panel length, X
span = 150;               // span between the end joints
rise = 33;                // top chord rise above the springing
camber = 11.55;           // top chord height above the bottom chord at the ends
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

bottom = [[0, 0, 0], [30, 0, 0], [60, 0, 0], [90, 0, 0], [120, 0, 0], [150, 0, 0]];
top = [[0, 0, 11.55], [30, 0, 32.67], [60, 0, 43.23], [90, 0, 43.23], [120, 0, 32.67], [150, 0, 11.55]];

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
