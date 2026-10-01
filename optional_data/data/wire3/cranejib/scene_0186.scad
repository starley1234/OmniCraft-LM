$fn = 32;

// ----------------------------------------------------------------------
// Crane jib: pyramid jib, 90 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
jib_l = 90;               // jib length, X
root_w = 18;              // half width of the root ring
tip_w = 8;                // half width of the tip ring
deck_h = 20;              // height of the jib axis
chord_r = 2.5;            // ring and chord radius
brace_r = 1.8;            // diagonal radius
joint_r = 2.9;            // joint ball radius
mid_w = 13;               // half width of the middle ring

bbox_x = jib_l + 2 * joint_r;  // overall X, joints included
bbox_y = 2 * root_w + 2 * joint_r;  // overall Y, joints included
bbox_z = 36 + 2 * joint_r;  // overall Z, joints included
chord_d = 2 * chord_r;  // chord stock diameter
brace_d = 2 * brace_r;  // brace stock diameter
root_d = 2 * root_w;  // root ring section
tip_d = 2 * tip_w;  // tip ring section
mid_d = 2 * mid_w;  // middle ring section
jib_h = 2 * root_w;  // root ring height
nodes = [[0, -root_w, deck_h - root_w], [0, root_w, deck_h - root_w], [0, root_w, deck_h + root_w], [0, -root_w, deck_h + root_w], [jib_l / 2, -mid_w, deck_h - mid_w], [jib_l / 2, mid_w, deck_h - mid_w], [jib_l / 2, mid_w, deck_h + mid_w], [jib_l / 2, -mid_w, deck_h + mid_w], [jib_l, 0, deck_h]];

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
member(nodes[1], nodes[2], chord_r);
member(nodes[2], nodes[3], chord_r);
member(nodes[3], nodes[0], chord_r);
member(nodes[4], nodes[5], chord_r);
member(nodes[5], nodes[6], chord_r);
member(nodes[6], nodes[7], chord_r);
member(nodes[7], nodes[4], chord_r);
member(nodes[0], nodes[4], chord_r);
member(nodes[4], nodes[8], chord_r);
member(nodes[0], nodes[5], brace_r);
member(nodes[1], nodes[5], chord_r);
member(nodes[5], nodes[8], chord_r);
member(nodes[1], nodes[6], brace_r);
member(nodes[2], nodes[6], chord_r);
member(nodes[6], nodes[8], chord_r);
member(nodes[2], nodes[7], brace_r);
member(nodes[3], nodes[7], chord_r);
member(nodes[7], nodes[8], chord_r);
member(nodes[3], nodes[4], brace_r);

/* joint balls */
for (p = nodes) joint(p, joint_r);
