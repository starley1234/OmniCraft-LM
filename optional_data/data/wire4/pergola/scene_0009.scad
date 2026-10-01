$fn = 32;

// ----------------------------------------------------------------------
// Pergola arch: 7-segment arches, span 110 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
span = 110;               // arch span, X
post_h = 40;              // post height
arch_r = 55;              // arch radius
depth = 40;               // frame spacing, Y
chord_r = 3;              // arch and post member radius
brace_r = 2.2;            // purlin member radius
joint_r = 3.4;            // joint ball radius

bbox_x = 116.8;  // overall X, joints included
bbox_y = 46.8;  // overall Y, joints included
bbox_z = 155.42;  // overall Z, joints included
chord_d = 2 * chord_r;  // arch stock diameter
brace_d = 2 * brace_r;  // purlin stock diameter
nodes = [[0.0, 0.0, 0.0], [110.0, 0.0, 0.0], [0.0, 0.0, 40.0], [110.0, 0.0, 40.0], [0.0, 0.0, 95.0], [5.4467, 0.0, 118.8636], [20.7081, 0.0, 138.0007], [42.7613, 0.0, 148.621], [67.2387, 0.0, 148.621], [89.2919, 0.0, 138.0007], [104.5533, 0.0, 118.8636], [110.0, 0.0, 95.0], [0.0, 40.0, 0.0], [110.0, 40.0, 0.0], [0.0, 40.0, 40.0], [110.0, 40.0, 40.0], [0.0, 40.0, 95.0], [5.4467, 40.0, 118.8636], [20.7081, 40.0, 138.0007], [42.7613, 40.0, 148.621], [67.2387, 40.0, 148.621], [89.2919, 40.0, 138.0007], [104.5533, 40.0, 118.8636], [110.0, 40.0, 95.0]];

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
