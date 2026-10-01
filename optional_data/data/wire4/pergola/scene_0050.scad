$fn = 32;

// ----------------------------------------------------------------------
// Pergola arch: 7-segment arches, span 120 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
span = 120;               // arch span, X
post_h = 30;              // post height
arch_r = 60;              // arch radius
depth = 60;               // frame spacing, Y
chord_r = 2.5;            // arch and post member radius
brace_r = 1.7;            // purlin member radius
joint_r = 2.9;            // joint ball radius

bbox_x = 125.8;  // overall X, joints included
bbox_y = 65.8;  // overall Y, joints included
bbox_z = 154.3;  // overall Z, joints included
chord_d = 2 * chord_r;  // arch stock diameter
brace_d = 2 * brace_r;  // purlin stock diameter
nodes = [[0.0, 0.0, 0.0], [120.0, 0.0, 0.0], [0.0, 0.0, 30.0], [120.0, 0.0, 30.0], [0.0, 0.0, 90.0], [5.9419, 0.0, 116.033], [22.5906, 0.0, 136.9099], [46.6487, 0.0, 148.4957], [73.3513, 0.0, 148.4957], [97.4094, 0.0, 136.9099], [114.0581, 0.0, 116.033], [120.0, 0.0, 90.0], [0.0, 60.0, 0.0], [120.0, 60.0, 0.0], [0.0, 60.0, 30.0], [120.0, 60.0, 30.0], [0.0, 60.0, 90.0], [5.9419, 60.0, 116.033], [22.5906, 60.0, 136.9099], [46.6487, 60.0, 148.4957], [73.3513, 60.0, 148.4957], [97.4094, 60.0, 136.9099], [114.0581, 60.0, 116.033], [120.0, 60.0, 90.0]];

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
member(nodes[0], nodes[4], chord_r);
member(nodes[1], nodes[11], chord_r);
member(nodes[0], nodes[1], chord_r);
member(nodes[4], nodes[5], chord_r);
member(nodes[5], nodes[6], chord_r);
member(nodes[6], nodes[7], chord_r);
member(nodes[7], nodes[8], chord_r);
member(nodes[8], nodes[9], chord_r);
member(nodes[9], nodes[10], chord_r);
member(nodes[10], nodes[11], chord_r);
member(nodes[2], nodes[4], brace_r);
member(nodes[3], nodes[11], brace_r);
member(nodes[12], nodes[16], chord_r);
member(nodes[13], nodes[23], chord_r);
member(nodes[12], nodes[13], chord_r);
member(nodes[16], nodes[17], chord_r);
member(nodes[17], nodes[18], chord_r);
member(nodes[18], nodes[19], chord_r);
member(nodes[19], nodes[20], chord_r);
member(nodes[20], nodes[21], chord_r);
member(nodes[21], nodes[22], chord_r);
member(nodes[22], nodes[23], chord_r);
member(nodes[14], nodes[16], brace_r);
member(nodes[15], nodes[23], brace_r);
member(nodes[4], nodes[16], brace_r);
member(nodes[5], nodes[17], brace_r);
member(nodes[6], nodes[18], brace_r);
member(nodes[7], nodes[19], brace_r);
member(nodes[8], nodes[20], brace_r);
member(nodes[9], nodes[21], brace_r);
member(nodes[10], nodes[22], brace_r);
member(nodes[11], nodes[23], brace_r);

/* joint balls */
for (p = nodes) joint(p, joint_r);
