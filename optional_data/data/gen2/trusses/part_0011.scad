$fn = 32;

// ----------------------------------------------------------------------
// Pratt truss: span 175 mm, height 80 mm, 5 equal panels
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panels = 5;               // number of equal panels
panel_p = 35;             // panel length, X
span = 175;               // span between the end joints
frame_h = 80;             // truss height, Z
chord_r = 3.5;            // chord member radius
diag_r = 2.6;             // diagonal member radius
vert_r = 2.6;             // vertical post radius
joint_r = 4.2;            // joint ball radius

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

bottom = [for (i = [0 : panels]) [i * panel_p, 0, 0]];
top = [for (i = [0 : panels]) [i * panel_p, 0, frame_h]];

for (i = [0 : panels - 1]) member(bottom[i], bottom[i + 1], chord_r);
for (i = [0 : 4]) member(top[i], top[i + 1], chord_r);

/* vertical posts */
for (i = [1 : panels - 1]) member(bottom[i], top[i], vert_r);

/* diagonals lean toward mid-span */
for (i = [0 : panels - 1]) {
  if (i < panels / 2) {
    member(bottom[i], top[i + 1], diag_r);
  } else {
    member(top[i], bottom[i + 1], diag_r);
  }
}

/* joint balls */
for (i = [0 : panels]) joint(bottom[i], joint_r);
for (i = [0 : 5]) joint(top[i], joint_r);
