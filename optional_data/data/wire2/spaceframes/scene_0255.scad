$fn = 32;

// ----------------------------------------------------------------------
// Space frame
// ----------------------------------------------------------------------

// --- parameters (mm) ---
chord_r = 3.5;            // chord / longeron radius
web_r = 2.5;              // diagonal and strut radius
joint_r = 3.9;            // joint ball radius
bays = 5;                 // number of bays along X
bay_p = 38;               // bay length, X
girder_w = 26;            // triangle base width, Y
girder_h = 32;            // triangle height, Z

bbox_x = bays * bay_p + 2 * joint_r;  // overall X, joints included
bbox_y = girder_w + 2 * joint_r;  // overall Y, joints included
bbox_z = girder_h + 2 * joint_r;  // overall Z, joints included
chord_d = 2 * chord_r;  // chord stock diameter
web_d = 2 * web_r;  // web stock diameter
joint_d = 2 * joint_r;  // joint ball diameter
span_x = bays * bay_p;  // overall girder length
nodes = [for (i = [0 : bays], k = [0 : 2]) [i * bay_p, k == 1 ? girder_w : k == 2 ? girder_w / 2 : 0, k == 2 ? girder_h : 0]];

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
member(nodes[3], nodes[6], chord_r);
member(nodes[6], nodes[9], chord_r);
member(nodes[9], nodes[12], chord_r);
member(nodes[12], nodes[15], chord_r);
member(nodes[1], nodes[4], chord_r);
member(nodes[4], nodes[7], chord_r);
member(nodes[7], nodes[10], chord_r);
member(nodes[10], nodes[13], chord_r);
member(nodes[13], nodes[16], chord_r);
member(nodes[2], nodes[5], chord_r);
member(nodes[5], nodes[8], chord_r);
member(nodes[8], nodes[11], chord_r);
member(nodes[11], nodes[14], chord_r);
member(nodes[14], nodes[17], chord_r);
member(nodes[0], nodes[1], chord_r);
member(nodes[1], nodes[2], chord_r);
member(nodes[0], nodes[2], chord_r);
member(nodes[3], nodes[4], chord_r);
member(nodes[4], nodes[5], chord_r);
member(nodes[3], nodes[5], chord_r);
member(nodes[6], nodes[7], chord_r);
member(nodes[7], nodes[8], chord_r);
member(nodes[6], nodes[8], chord_r);
member(nodes[9], nodes[10], chord_r);
member(nodes[10], nodes[11], chord_r);
member(nodes[9], nodes[11], chord_r);
member(nodes[12], nodes[13], chord_r);
member(nodes[13], nodes[14], chord_r);
member(nodes[12], nodes[14], chord_r);
member(nodes[15], nodes[16], chord_r);
member(nodes[16], nodes[17], chord_r);
member(nodes[15], nodes[17], chord_r);
member(nodes[0], nodes[4], web_r);
member(nodes[2], nodes[4], web_r);
member(nodes[0], nodes[5], web_r);
member(nodes[4], nodes[6], web_r);
member(nodes[4], nodes[8], web_r);
member(nodes[5], nodes[6], web_r);
member(nodes[6], nodes[10], web_r);
member(nodes[8], nodes[10], web_r);
member(nodes[6], nodes[11], web_r);
member(nodes[10], nodes[12], web_r);
member(nodes[10], nodes[14], web_r);
member(nodes[11], nodes[12], web_r);
member(nodes[12], nodes[16], web_r);
member(nodes[14], nodes[16], web_r);
member(nodes[12], nodes[17], web_r);

/* joint balls */
for (p = nodes) joint(p, joint_r);
