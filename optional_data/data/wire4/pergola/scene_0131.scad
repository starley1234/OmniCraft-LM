$fn = 32;

// ----------------------------------------------------------------------
// Pergola arch: 5-segment arches, span 100 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
span = 100;               // arch span, X
post_h = 30;              // post height
arch_r = 50;              // arch radius
depth = 60;               // frame spacing, Y
chord_r = 3;              // arch and post member radius
brace_r = 2.2;            // purlin member radius
joint_r = 3.4;            // joint ball radius

bbox_x = 106.8;  // overall X, joints included
bbox_y = 66.8;  // overall Y, joints included
bbox_z = 84.35;  // overall Z, joints included
chord_d = 2 * chord_r;  // arch stock diameter
brace_d = 2 * brace_r;  // purlin stock diameter
nodes = [[0.0, 0.0, 0.0], [100.0, 0.0, 0.0], [0.0, 0.0, 30.0], [9.5492, 0.0, 59.3893], [34.5492, 0.0, 77.5528], [65.4508, 0.0, 77.5528], [90.4508, 0.0, 59.3893], [100.0, 0.0, 30.0], [0.0, 60.0, 0.0], [100.0, 60.0, 0.0], [0.0, 60.0, 30.0], [9.5492, 60.0, 59.3893], [34.5492, 60.0, 77.5528], [65.4508, 60.0, 77.5528], [90.4508, 60.0, 59.3893], [100.0, 60.0, 30.0]];

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
member(nodes[1], nodes[7], chord_r);
member(nodes[0], nodes[1], chord_r);
member(nodes[2], nodes[3], chord_r);
member(nodes[3], nodes[4], chord_r);
member(nodes[4], nodes[5], chord_r);
member(nodes[5], nodes[6], chord_r);
member(nodes[6], nodes[7], chord_r);
member(nodes[8], nodes[10], chord_r);
member(nodes[9], nodes[15], chord_r);
member(nodes[8], nodes[9], chord_r);
member(nodes[10], nodes[11], chord_r);
member(nodes[11], nodes[12], chord_r);
member(nodes[12], nodes[13], chord_r);
member(nodes[13], nodes[14], chord_r);
member(nodes[14], nodes[15], chord_r);
member(nodes[2], nodes[10], brace_r);
member(nodes[3], nodes[11], brace_r);
member(nodes[4], nodes[12], brace_r);
member(nodes[5], nodes[13], brace_r);
member(nodes[6], nodes[14], brace_r);
member(nodes[7], nodes[15], brace_r);

/* joint balls */
for (p = nodes) joint(p, joint_r);
