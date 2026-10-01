$fn = 32;

// ----------------------------------------------------------------------
// Scaffold tower: 2 spans x 3 lifts
// ----------------------------------------------------------------------

// --- parameters (mm) ---
spans = 2;                // spans along X
levels = 3;               // lift levels
bay_l = 50;               // span length, X
tower_w = 24;             // tower width, Y
lift_h = 30;              // lift height, Z
post_r = 2.5;             // post and ledger radius
brace_r = 1.7;            // diagonal brace radius
joint_r = 2.9;            // joint ball radius

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
member(nodes[0], nodes[6], post_r);
member(nodes[1], nodes[7], post_r);
member(nodes[2], nodes[8], post_r);
member(nodes[0], nodes[1], post_r);
member(nodes[1], nodes[2], post_r);
member(nodes[3], nodes[9], post_r);
member(nodes[4], nodes[10], post_r);
member(nodes[5], nodes[11], post_r);
member(nodes[3], nodes[4], post_r);
member(nodes[4], nodes[5], post_r);
member(nodes[6], nodes[12], post_r);
member(nodes[7], nodes[13], post_r);
member(nodes[8], nodes[14], post_r);
member(nodes[6], nodes[7], post_r);
member(nodes[7], nodes[8], post_r);
member(nodes[9], nodes[15], post_r);
member(nodes[10], nodes[16], post_r);
member(nodes[11], nodes[17], post_r);
member(nodes[9], nodes[10], post_r);
member(nodes[10], nodes[11], post_r);
member(nodes[12], nodes[18], post_r);
member(nodes[13], nodes[19], post_r);
member(nodes[14], nodes[20], post_r);
member(nodes[12], nodes[13], post_r);
member(nodes[13], nodes[14], post_r);
member(nodes[15], nodes[21], post_r);
member(nodes[16], nodes[22], post_r);
member(nodes[17], nodes[23], post_r);
member(nodes[15], nodes[16], post_r);
member(nodes[16], nodes[17], post_r);
member(nodes[0], nodes[3], post_r);
member(nodes[1], nodes[4], post_r);
member(nodes[2], nodes[5], post_r);
member(nodes[6], nodes[9], post_r);
member(nodes[7], nodes[10], post_r);
member(nodes[8], nodes[11], post_r);
member(nodes[12], nodes[15], post_r);
member(nodes[13], nodes[16], post_r);
member(nodes[14], nodes[17], post_r);
member(nodes[18], nodes[21], post_r);
member(nodes[19], nodes[22], post_r);
member(nodes[20], nodes[23], post_r);
member(nodes[0], nodes[7], brace_r);
member(nodes[7], nodes[2], brace_r);
member(nodes[3], nodes[10], brace_r);
member(nodes[10], nodes[5], brace_r);
member(nodes[12], nodes[7], brace_r);
member(nodes[7], nodes[14], brace_r);
member(nodes[15], nodes[10], brace_r);
member(nodes[10], nodes[17], brace_r);
member(nodes[12], nodes[19], brace_r);
member(nodes[19], nodes[14], brace_r);
member(nodes[15], nodes[22], brace_r);
member(nodes[22], nodes[17], brace_r);

/* joint balls */
for (p = nodes) joint(p, joint_r);
