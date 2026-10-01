$fn = 32;

// ----------------------------------------------------------------------
// Space frame
// ----------------------------------------------------------------------

// --- parameters (mm) ---
chord_r = 4.5;            // chord / longeron radius
web_r = 3.5;              // diagonal and strut radius
joint_r = 4.9;            // joint ball radius
cells_x = 3;              // cells along X
cells_y = 2;              // cells along Y
pitch = 36;               // grid pitch (X and Y)
grid_h = 20;              // layer spacing, Z
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.3;           // declared free tolerance (prompt contract)

bbox_x = cells_x * pitch + 2 * joint_r;  // overall X, joints included
bbox_y = cells_y * pitch + 2 * joint_r;  // overall Y, joints included
bbox_z = grid_h + 2 * joint_r;  // overall Z, joints included
chord_d = 2 * chord_r;  // chord stock diameter
web_d = 2 * web_r;  // web stock diameter
joint_d = 2 * joint_r;  // joint ball diameter
plan_x = cells_x * pitch;  // chord plan length, X
plan_y = cells_y * pitch;  // chord plan width, Y
nodes = [for (lvl = [0, 1], i = [0 : cells_x], j = [0 : cells_y]) [i * pitch, j * pitch, lvl * grid_h]];

module member(a, b, r) {
  /* round stock from joint a to joint b, ends buried in the joint balls */
  d = b - a;
  length = norm(d);
  translate(a) rotate([0, acos(d[2] / length), atan2(d[1], d[0])])
    cylinder(h = length, r = r);
}

module joint(p, r) {
  /* ball at the joint centre, fatter than every member meeting there */
  translate(p) sphere(r = r);
}

/* members - each call is one graph edge */
member(nodes[0], nodes[3], chord_r);
member(nodes[1], nodes[4], chord_r);
member(nodes[2], nodes[5], chord_r);
member(nodes[3], nodes[6], chord_r);
member(nodes[4], nodes[7], chord_r);
member(nodes[5], nodes[8], chord_r);
member(nodes[6], nodes[9], chord_r);
member(nodes[7], nodes[10], chord_r);
member(nodes[8], nodes[11], chord_r);
member(nodes[0], nodes[1], chord_r);
member(nodes[1], nodes[2], chord_r);
member(nodes[3], nodes[4], chord_r);
member(nodes[4], nodes[5], chord_r);
member(nodes[6], nodes[7], chord_r);
member(nodes[7], nodes[8], chord_r);
member(nodes[9], nodes[10], chord_r);
member(nodes[10], nodes[11], chord_r);
member(nodes[12], nodes[15], chord_r);
member(nodes[13], nodes[16], chord_r);
member(nodes[14], nodes[17], chord_r);
member(nodes[15], nodes[18], chord_r);
member(nodes[16], nodes[19], chord_r);
member(nodes[17], nodes[20], chord_r);
member(nodes[18], nodes[21], chord_r);
member(nodes[19], nodes[22], chord_r);
member(nodes[20], nodes[23], chord_r);
member(nodes[12], nodes[13], chord_r);
member(nodes[13], nodes[14], chord_r);
member(nodes[15], nodes[16], chord_r);
member(nodes[16], nodes[17], chord_r);
member(nodes[18], nodes[19], chord_r);
member(nodes[19], nodes[20], chord_r);
member(nodes[21], nodes[22], chord_r);
member(nodes[22], nodes[23], chord_r);
member(nodes[0], nodes[12], web_r);
member(nodes[1], nodes[13], web_r);
member(nodes[2], nodes[14], web_r);
member(nodes[3], nodes[15], web_r);
member(nodes[4], nodes[16], web_r);
member(nodes[5], nodes[17], web_r);
member(nodes[6], nodes[18], web_r);
member(nodes[7], nodes[19], web_r);
member(nodes[8], nodes[20], web_r);
member(nodes[9], nodes[21], web_r);
member(nodes[10], nodes[22], web_r);
member(nodes[11], nodes[23], web_r);
member(nodes[0], nodes[15], web_r);
member(nodes[12], nodes[3], web_r);
member(nodes[1], nodes[16], web_r);
member(nodes[13], nodes[4], web_r);
member(nodes[2], nodes[17], web_r);
member(nodes[14], nodes[5], web_r);
member(nodes[3], nodes[18], web_r);
member(nodes[15], nodes[6], web_r);
member(nodes[4], nodes[19], web_r);
member(nodes[16], nodes[7], web_r);
member(nodes[5], nodes[20], web_r);
member(nodes[17], nodes[8], web_r);
member(nodes[6], nodes[21], web_r);
member(nodes[18], nodes[9], web_r);
member(nodes[7], nodes[22], web_r);
member(nodes[19], nodes[10], web_r);
member(nodes[8], nodes[23], web_r);
member(nodes[20], nodes[11], web_r);
member(nodes[0], nodes[13], web_r);
member(nodes[12], nodes[1], web_r);
member(nodes[1], nodes[14], web_r);
member(nodes[13], nodes[2], web_r);
member(nodes[3], nodes[16], web_r);
member(nodes[15], nodes[4], web_r);
member(nodes[4], nodes[17], web_r);
member(nodes[16], nodes[5], web_r);
member(nodes[6], nodes[19], web_r);
member(nodes[18], nodes[7], web_r);
member(nodes[7], nodes[20], web_r);
member(nodes[19], nodes[8], web_r);
member(nodes[9], nodes[22], web_r);
member(nodes[21], nodes[10], web_r);
member(nodes[10], nodes[23], web_r);
member(nodes[22], nodes[11], web_r);

/* joint balls */
for (p = nodes) joint(p, joint_r);
