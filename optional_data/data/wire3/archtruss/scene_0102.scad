$fn = 32;

// ----------------------------------------------------------------------
// Arch truss pair: 4 bays of 25 mm, rise 25 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bays = 4;                 // number of arch bays
arch_bay = 25;            // bay length, X
rise = 25;                // arch rise over the tie
col_h = 10;               // end post height
arch_w = 30;              // distance between the two trusses, Y
chord_r = 2.2;            // chord radius
brace_r = 1.5;            // web and cross brace radius
joint_r = 2.6;            // joint ball radius

bbox_x = bays * arch_bay + 2 * joint_r;  // overall X, joints included
bbox_y = arch_w + 2 * joint_r;  // overall Y, joints included
bbox_z = col_h + rise + 2 * joint_r;  // overall Z, joints included
chord_d = 2 * chord_r;  // chord stock diameter
brace_d = 2 * brace_r;  // web stock diameter
arch_span = bays * arch_bay;  // truss span
crown_z = col_h + rise;  // crown height over the tie
nodes = concat([for (i = [0 : bays]) [i * arch_bay, 0, col_h + 4 * rise * (i / bays) * (1 - i / bays)]], [for (i = [0 : bays]) [i * arch_bay, 0, 0]], [for (i = [0 : bays]) [i * arch_bay, arch_w, col_h + 4 * rise * (i / bays) * (1 - i / bays)]], [for (i = [0 : bays]) [i * arch_bay, arch_w, 0]]);

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
member(nodes[0], nodes[1], chord_r);
member(nodes[5], nodes[6], chord_r);
member(nodes[1], nodes[2], chord_r);
member(nodes[6], nodes[7], chord_r);
member(nodes[2], nodes[3], chord_r);
member(nodes[7], nodes[8], chord_r);
member(nodes[3], nodes[4], chord_r);
member(nodes[8], nodes[9], chord_r);
member(nodes[0], nodes[5], chord_r);
member(nodes[1], nodes[6], chord_r);
member(nodes[2], nodes[7], chord_r);
member(nodes[3], nodes[8], chord_r);
member(nodes[4], nodes[9], chord_r);
member(nodes[5], nodes[1], brace_r);
member(nodes[1], nodes[7], brace_r);
member(nodes[7], nodes[3], brace_r);
member(nodes[3], nodes[9], brace_r);
member(nodes[10], nodes[11], chord_r);
member(nodes[15], nodes[16], chord_r);
member(nodes[11], nodes[12], chord_r);
member(nodes[16], nodes[17], chord_r);
member(nodes[12], nodes[13], chord_r);
member(nodes[17], nodes[18], chord_r);
member(nodes[13], nodes[14], chord_r);
member(nodes[18], nodes[19], chord_r);
member(nodes[10], nodes[15], chord_r);
member(nodes[11], nodes[16], chord_r);
member(nodes[12], nodes[17], chord_r);
member(nodes[13], nodes[18], chord_r);
member(nodes[14], nodes[19], chord_r);
member(nodes[15], nodes[11], brace_r);
member(nodes[11], nodes[17], brace_r);
member(nodes[17], nodes[13], brace_r);
member(nodes[13], nodes[19], brace_r);
member(nodes[0], nodes[10], brace_r);
member(nodes[1], nodes[11], brace_r);
member(nodes[2], nodes[12], brace_r);
member(nodes[3], nodes[13], brace_r);
member(nodes[4], nodes[14], brace_r);

/* joint balls */
for (p = nodes) joint(p, joint_r);
