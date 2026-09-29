$fn = 32;

// ----------------------------------------------------------------------
// Four-leg tower: 100 x 100 x 120 mm, 3 bays of 40 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
size = 100;               // footprint across the legs
lvl = 40;                 // bay height between the rings
levels = 3;               // number of bays
tower_h = 120;            // overall height
leg_r = 5;                // leg tube radius
brace_r = 3;              // brace tube radius
joint_r = 6;              // joint ball radius
plate_t = 6;              // top plate thickness
plate_hole_d = 9;         // top plate bolt holes
inset = 12;               // bolt hole inset from the corner

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

/* braces alternate direction bay by bay */
for (i = [0 : levels - 1]) {
  for (j = [0 : 3]) {
    if (i % 2 == 0) {
      member([p[j][0] * size / 2, p[j][1] * size / 2, i * lvl],
             [p[(j + 1) % 4][0] * size / 2, p[(j + 1) % 4][1] * size / 2, (i + 1) * lvl], brace_r);
    } else {
      member([p[(j + 1) % 4][0] * size / 2, p[(j + 1) % 4][1] * size / 2, i * lvl],
             [p[j][0] * size / 2, p[j][1] * size / 2, (i + 1) * lvl], brace_r);
    }
  }
}

/* joint balls */
for (i = [0 : levels]) {
  for (j = [0 : 3]) {
    joint([p[j][0] * size / 2, p[j][1] * size / 2, i * lvl], joint_r);
  }
}

module top_plate() {
  /* sunk 1 mm into the top ring so the joint overlaps */
  translate([-size / 2, -size / 2, tower_h - 1]) cube([size, size, plate_t + 1]);
}

difference() {
  top_plate();
  for (sx = [-1, 1]) for (sy = [-1, 1])
    translate([sx * (size / 2 - inset), sy * (size / 2 - inset), tower_h - 2])
      cylinder(h = plate_t + 3, d = plate_hole_d);
}
