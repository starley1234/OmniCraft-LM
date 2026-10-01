$fn = 32;

// ----------------------------------------------------------------------
// Scaffold tower: 3 spans x 3 lifts
// ----------------------------------------------------------------------

// --- parameters (mm) ---
spans = 3;                // spans along X
levels = 3;               // lift levels
bay_l = 50;               // span length, X
tower_w = 24;             // tower width, Y
lift_h = 30;              // lift height, Z
post_r = 3;               // post and ledger radius
brace_r = 2.2;            // diagonal brace radius
joint_r = 3.4;            // joint ball radius

bbox_x = spans * bay_l + 2 * joint_r;  // overall X, joints included
bbox_y = tower_w + 2 * joint_r;  // overall Y, joints included
bbox_z = levels * lift_h + 2 * joint_r;  // overall Z, joints included
post_d = 2 * post_r;  // post stock diameter
brace_d = 2 * brace_r;  // brace stock diameter
tower_l = spans * bay_l;  // tower footprint length
tower_h = levels * lift_h;  // tower height
nodes = [for (lvl = [0 : levels], side = [0, 1], st = [0 : spans]) [st * bay_l, side * tower_w, lvl * lift_h]];

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
member(nodes[0], nodes[8], post_r);
member(nodes[1], nodes[9], post_r);
member(nodes[2], nodes[10], post_r);
member(nodes[3], nodes[11], post_r);
member(nodes[0], nodes[1], post_r);
member(nodes[1], nodes[2], post_r);
member(nodes[2], nodes[3], post_r);
member(nodes[4], nodes[12], post_r);
member(nodes[5], nodes[13], post_r);
member(nodes[6], nodes[14], post_r);
member(nodes[7], nodes[15], post_r);
member(nodes[4], nodes[5], post_r);
member(nodes[5], nodes[6], post_r);
member(nodes[6], nodes[7], post_r);
member(nodes[8], nodes[16], post_r);
member(nodes[9], nodes[17], post_r);
member(nodes[10], nodes[18], post_r);
member(nodes[11], nodes[19], post_r);
member(nodes[8], nodes[9], post_r);
member(nodes[9], nodes[10], post_r);
member(nodes[10], nodes[11], post_r);
member(nodes[12], nodes[20], post_r);
member(nodes[13], nodes[21], post_r);
member(nodes[14], nodes[22], post_r);
member(nodes[15], nodes[23], post_r);
member(nodes[12], nodes[13], post_r);
member(nodes[13], nodes[14], post_r);
member(nodes[14], nodes[15], post_r);
member(nodes[16], nodes[24], post_r);
member(nodes[17], nodes[25], post_r);
member(nodes[18], nodes[26], post_r);
member(nodes[19], nodes[27], post_r);
member(nodes[16], nodes[17], post_r);
member(nodes[17], nodes[18], post_r);
member(nodes[18], nodes[19], post_r);
member(nodes[20], nodes[28], post_r);
member(nodes[21], nodes[29], post_r);
member(nodes[22], nodes[30], post_r);
member(nodes[23], nodes[31], post_r);
member(nodes[20], nodes[21], post_r);
member(nodes[21], nodes[22], post_r);
member(nodes[22], nodes[23], post_r);
member(nodes[0], nodes[4], post_r);
member(nodes[1], nodes[5], post_r);
member(nodes[2], nodes[6], post_r);
member(nodes[3], nodes[7], post_r);
member(nodes[8], nodes[12], post_r);
member(nodes[9], nodes[13], post_r);
member(nodes[10], nodes[14], post_r);
member(nodes[11], nodes[15], post_r);
member(nodes[16], nodes[20], post_r);
member(nodes[17], nodes[21], post_r);
member(nodes[18], nodes[22], post_r);
member(nodes[19], nodes[23], post_r);
member(nodes[24], nodes[28], post_r);
member(nodes[25], nodes[29], post_r);
member(nodes[26], nodes[30], post_r);
member(nodes[27], nodes[31], post_r);
member(nodes[0], nodes[9], brace_r);
member(nodes[9], nodes[2], brace_r);
member(nodes[2], nodes[11], brace_r);
member(nodes[4], nodes[13], brace_r);
member(nodes[13], nodes[6], brace_r);
member(nodes[6], nodes[15], brace_r);
member(nodes[16], nodes[9], brace_r);
member(nodes[9], nodes[18], brace_r);
member(nodes[18], nodes[11], brace_r);
member(nodes[20], nodes[13], brace_r);
member(nodes[13], nodes[22], brace_r);
member(nodes[22], nodes[15], brace_r);
member(nodes[16], nodes[25], brace_r);
member(nodes[25], nodes[18], brace_r);
member(nodes[18], nodes[27], brace_r);
member(nodes[20], nodes[29], brace_r);
member(nodes[29], nodes[22], brace_r);
member(nodes[22], nodes[31], brace_r);

/* joint balls */
for (p = nodes) joint(p, joint_r);
