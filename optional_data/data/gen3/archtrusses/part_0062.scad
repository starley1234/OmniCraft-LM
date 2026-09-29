$fn = 32;

// ----------------------------------------------------------------------
// Arched truss: span 236.8 mm, rise 66.3 mm, 8 panels
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panels = 8;               // number of panels
panel_p = 29.6;           // panel length, X
span = 236.8;             // span between the end joints
rise = 66.3;              // top chord rise above the springing
camber = 16.57;           // top chord height above the bottom chord at the ends
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

bottom = [[0, 0, 0], [29.6, 0, 0], [59.2, 0, 0], [88.8, 0, 0], [118.4, 0, 0], [148, 0, 0], [177.6, 0, 0], [207.2, 0, 0], [236.8, 0, 0]];
top = [[0, 0, 16.57], [29.6, 0, 45.576], [59.2, 0, 66.295], [88.8, 0, 78.726], [118.4, 0, 82.87], [148, 0, 78.726], [177.6, 0, 66.295], [207.2, 0, 45.576], [236.8, 0, 16.57]];

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
