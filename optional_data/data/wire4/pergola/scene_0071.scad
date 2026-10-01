$fn = 32;

// ----------------------------------------------------------------------
// Pergola arch: 7-segment arches, span 90 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
span = 90;                // arch span, X
post_h = 50;              // post height
arch_r = 45;              // arch radius
depth = 60;               // frame spacing, Y
chord_r = 2.5;            // arch and post member radius
brace_r = 1.7;            // purlin member radius
joint_r = 2.9;            // joint ball radius

bbox_x = 95.8;  // overall X, joints included
bbox_y = 65.8;  // overall Y, joints included
bbox_z = 99.67;  // overall Z, joints included
chord_d = 2 * chord_r;  // arch stock diameter
brace_d = 2 * brace_r;  // purlin stock diameter
nodes = [[0.0, 0.0, 0.0], [90.0, 0.0, 0.0], [0.0, 0.0, 50.0], [4.4564, 0.0, 69.5248], [16.943, 0.0, 85.1824], [34.9866, 0.0, 93.8718], [55.0134, 0.0, 93.8718], [73.057, 0.0, 85.1824], [85.5436, 0.0, 69.5248], [90.0, 0.0, 50.0], [0.0, 60.0, 0.0], [90.0, 60.0, 0.0], [0.0, 60.0, 50.0], [4.4564, 60.0, 69.5248], [16.943, 60.0, 85.1824], [34.9866, 60.0, 93.8718], [55.0134, 60.0, 93.8718], [73.057, 60.0, 85.1824], [85.5436, 60.0, 69.5248], [90.0, 60.0, 50.0]];

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
