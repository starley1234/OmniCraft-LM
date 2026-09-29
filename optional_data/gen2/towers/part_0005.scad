$fn = 32;

// ----------------------------------------------------------------------
// Four-leg tower: 50 x 50 x 238.5 mm, 5 bays of 47.7 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
size = 50;                // footprint across the legs
lvl = 47.7;               // bay height between the rings
levels = 5;               // number of bays
tower_h = 238.5;          // overall height
leg_r = 4;                // leg tube radius
brace_r = 3.4;            // brace tube radius
joint_r = 4.8;            // joint ball radius

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

p = [[1, 1], [1, -1], [-1, -1], [-1, 1]];

/* legs */
for (i = [0 : levels - 1]) {
  for (j = [0 : 3]) {
    member([p[j][0] * size / 2, p[j][1] * size / 2, i * lvl],
           [p[j][0] * size / 2, p[j][1] * size / 2, (i + 1) * lvl], leg_r);
  }
}

/* rings at every level */
for (i = [0 : levels]) {
  for (j = [0 : 3]) {
    member([p[j][0] * size / 2, p[j][1] * size / 2, i * lvl],
           [p[(j + 1) % 4][0] * size / 2, p[(j + 1) % 4][1] * size / 2, i * lvl], brace_r);
  }
}

/* cross bracing in every bay */
for (i = [0 : levels - 1]) {
  for (j = [0 : 3]) {
    member([p[j][0] * size / 2, p[j][1] * size / 2, i * lvl],
           [p[(j + 1) % 4][0] * size / 2, p[(j + 1) % 4][1] * size / 2, (i + 1) * lvl], brace_r);
    member([p[(j + 1) % 4][0] * size / 2, p[(j + 1) % 4][1] * size / 2, i * lvl],
           [p[j][0] * size / 2, p[j][1] * size / 2, (i + 1) * lvl], brace_r);
  }
}

/* joint balls */
for (i = [0 : levels]) {
  for (j = [0 : 3]) {
    joint([p[j][0] * size / 2, p[j][1] * size / 2, i * lvl], joint_r);
  }
}
