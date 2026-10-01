$fn = 32;

// ----------------------------------------------------------------------
// Pergola arch: 7-segment arches, span 110 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
span = 110;               // arch span, X
post_h = 50;              // post height
arch_r = 55;              // arch radius
depth = 40;               // frame spacing, Y
chord_r = 2.5;            // arch and post member radius
brace_r = 1.7;            // purlin member radius
joint_r = 2.9;            // joint ball radius
fit_tol = 0.02;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

bbox_x = 115.8;  // overall X, joints included
bbox_y = 45.8;  // overall Y, joints included
bbox_z = 109.42;  // overall Z, joints included
chord_d = 2 * chord_r;  // arch stock diameter
brace_d = 2 * brace_r;  // purlin stock diameter
nodes = [[0.0, 0.0, 0.0], [110.0, 0.0, 0.0], [0.0, 0.0, 50.0], [5.4467, 0.0, 73.8636], [20.7081, 0.0, 93.0007], [42.7613, 0.0, 103.621], [67.2387, 0.0, 103.621], [89.2919, 0.0, 93.0007], [104.5533, 0.0, 73.8636], [110.0, 0.0, 50.0], [0.0, 40.0, 0.0], [110.0, 40.0, 0.0], [0.0, 40.0, 50.0], [5.4467, 40.0, 73.8636], [20.7081, 40.0, 93.0007], [42.7613, 40.0, 103.621], [67.2387, 40.0, 103.621], [89.2919, 40.0, 93.0007], [104.5533, 40.0, 73.8636], [110.0, 40.0, 50.0]];

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
member(nodes[0], nodes[2], chord_r);
member(nodes[1], nodes[9], chord_r);
member(nodes[0], nodes[1], chord_r);
member(nodes[2], nodes[3], chord_r);
member(nodes[3], nodes[4], chord_r);
member(nodes[4], nodes[5], chord_r);
member(nodes[5], nodes[6], chord_r);
member(nodes[6], nodes[7], chord_r);
member(nodes[7], nodes[8], chord_r);
member(nodes[8], nodes[9], chord_r);
member(nodes[10], nodes[12], chord_r);
member(nodes[11], nodes[19], chord_r);
member(nodes[10], nodes[11], chord_r);
member(nodes[12], nodes[13], chord_r);
member(nodes[13], nodes[14], chord_r);
member(nodes[14], nodes[15], chord_r);
member(nodes[15], nodes[16], chord_r);
member(nodes[16], nodes[17], chord_r);
member(nodes[17], nodes[18], chord_r);
member(nodes[18], nodes[19], chord_r);
member(nodes[2], nodes[12], brace_r);
member(nodes[3], nodes[13], brace_r);
member(nodes[4], nodes[14], brace_r);
member(nodes[5], nodes[15], brace_r);
member(nodes[6], nodes[16], brace_r);
member(nodes[7], nodes[17], brace_r);
member(nodes[8], nodes[18], brace_r);
member(nodes[9], nodes[19], brace_r);

/* joint balls */
for (p = nodes) joint(p, joint_r);
