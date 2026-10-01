$fn = 32;

// ----------------------------------------------------------------------
// Roll cage: 3 bays x 2 sections, bays 46 mm, 34 x 30 mm section
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bays = 3;                 // number of bays along X
sections = 2;             // levels of the cage
bay_l = 46;               // bay length, X
cage_w = 34;              // cage width, Y
cage_h = 30;              // cage height, Z
rail_r = 4.5;             // rail and hoop radius
diag_r = 3.7;             // diagonal brace radius
joint_r = 4.9;            // joint ball radius

bbox_x = bays * bay_l + 2 * joint_r;  // overall X, joints included
bbox_y = cage_w + 2 * joint_r;  // overall Y, joints included
bbox_z = cage_h + 2 * joint_r;  // overall Z, joints included
rail_d = 2 * rail_r;  // rail stock diameter
diag_d = 2 * diag_r;  // diagonal stock diameter
joint_d = 2 * joint_r;  // joint ball diameter
cage_l = bays * bay_l;  // overall cage length
nodes = [for (lvl = [0, 1], side = [0, 1], st = [0 : bays]) [st * bay_l, side * cage_w, lvl * cage_h]];

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
member(nodes[0], nodes[1], rail_r);
member(nodes[1], nodes[2], rail_r);
member(nodes[2], nodes[3], rail_r);
member(nodes[4], nodes[5], rail_r);
member(nodes[5], nodes[6], rail_r);
member(nodes[6], nodes[7], rail_r);
member(nodes[8], nodes[9], rail_r);
member(nodes[9], nodes[10], rail_r);
member(nodes[10], nodes[11], rail_r);
member(nodes[12], nodes[13], rail_r);
member(nodes[13], nodes[14], rail_r);
member(nodes[14], nodes[15], rail_r);
member(nodes[0], nodes[8], rail_r);
member(nodes[1], nodes[9], rail_r);
member(nodes[2], nodes[10], rail_r);
member(nodes[3], nodes[11], rail_r);
member(nodes[4], nodes[12], rail_r);
member(nodes[5], nodes[13], rail_r);
member(nodes[6], nodes[14], rail_r);
member(nodes[7], nodes[15], rail_r);
member(nodes[8], nodes[12], rail_r);
member(nodes[9], nodes[13], rail_r);
member(nodes[10], nodes[14], rail_r);
member(nodes[11], nodes[15], rail_r);
member(nodes[0], nodes[4], rail_r);
member(nodes[3], nodes[7], rail_r);
member(nodes[0], nodes[9], diag_r);
member(nodes[8], nodes[1], diag_r);
member(nodes[1], nodes[10], diag_r);
member(nodes[9], nodes[2], diag_r);
member(nodes[2], nodes[11], diag_r);
member(nodes[10], nodes[3], diag_r);
member(nodes[4], nodes[13], diag_r);
member(nodes[12], nodes[5], diag_r);
member(nodes[5], nodes[14], diag_r);
member(nodes[13], nodes[6], diag_r);
member(nodes[6], nodes[15], diag_r);
member(nodes[14], nodes[7], diag_r);
member(nodes[9], nodes[14], diag_r);
member(nodes[13], nodes[10], diag_r);

/* joint balls */
for (p = nodes) joint(p, joint_r);
