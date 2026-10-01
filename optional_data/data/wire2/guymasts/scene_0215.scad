$fn = 32;

// ----------------------------------------------------------------------
// Guyed mast: 4 sections of 35 mm, 4 anchors on R70
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sections = 4;             // number of mast sections
seg_h = 35;               // section height
mast_r = 4.5;             // mast member radius
guy_r = 2;                // guy wire radius
joint_r = 5;              // joint ball radius
anchors_n = 4;            // number of ground anchors
anchor_r = 70;            // anchor ring radius
anchor_step = 90;         // angle between anchors, degrees
anchor_a0 = 15;           // angle of the first anchor, degrees
tiers = 2;                // number of guy tiers
guy_h_4 = 140;            // guy tier height (section 4)
guy_h_2 = 70;             // guy tier height (section 2)
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.3;           // declared free tolerance (prompt contract)

bbox_x = anchor_r * (cos(anchor_a0 + 0 * anchor_step) - cos(anchor_a0 + 2 * anchor_step)) + 2 * joint_r;  // overall X, joints included
bbox_y = anchor_r * (sin(anchor_a0 + 1 * anchor_step) - sin(anchor_a0 + 3 * anchor_step)) + 2 * joint_r;  // overall Y, joints included
bbox_z = sections * seg_h + 2 * joint_r;  // overall Z, joints included
mast_d = 2 * mast_r;  // mast trunk diameter
guy_d = 2 * guy_r;  // guy wire diameter
joint_d = 2 * joint_r;  // joint ball diameter
nodes = concat([for (i = [0 : sections]) [0, 0, i * seg_h]], [for (k = [0 : anchors_n - 1]) [anchor_r * cos(anchor_a0 + k * anchor_step), anchor_r * sin(anchor_a0 + k * anchor_step), 0]]);

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
member(nodes[0], nodes[1], mast_r);
member(nodes[1], nodes[2], mast_r);
member(nodes[2], nodes[3], mast_r);
member(nodes[3], nodes[4], mast_r);
member(nodes[4], nodes[5], guy_r);
member(nodes[4], nodes[6], guy_r);
member(nodes[4], nodes[7], guy_r);
member(nodes[4], nodes[8], guy_r);
member(nodes[2], nodes[5], guy_r);
member(nodes[2], nodes[6], guy_r);
member(nodes[2], nodes[7], guy_r);
member(nodes[2], nodes[8], guy_r);

/* joint balls */
for (p = nodes) joint(p, joint_r);
