$fn = 32;

// ----------------------------------------------------------------------
// Scissor lattice: 4 x 3 cells of 42 mm, 168 x 126 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
columns = 4;              // cells along X
rows = 3;                 // cells along Y
cell = 42;                // cell size
chord_r = 3;              // boundary chord radius
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

/* X braces, one pair per cell */
for (i = [0 : columns - 1]) {
  for (j = [0 : rows - 1]) {
    member([i * cell, j * cell, 0], [(i + 1) * cell, (j + 1) * cell, 0], diag_r);
    member([(i + 1) * cell, j * cell, 0], [i * cell, (j + 1) * cell, 0], diag_r);
  }
}
/* boundary chords */
for (i = [0 : columns - 1]) {
  member([i * cell, 0, 0], [(i + 1) * cell, 0, 0], chord_r);
  member([i * cell, rows * cell, 0], [(i + 1) * cell, rows * cell, 0], chord_r);
}
for (j = [0 : rows - 1]) {
  member([0, j * cell, 0], [0, (j + 1) * cell, 0], chord_r);
  member([columns * cell, j * cell, 0], [columns * cell, (j + 1) * cell, 0], chord_r);
}
/* joint balls at every grid corner */
for (i = [0 : columns]) {
  for (j = [0 : rows]) joint([i * cell, j * cell, 0], joint_r);
}
