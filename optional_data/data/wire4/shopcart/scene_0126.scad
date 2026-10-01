$fn = 32;

// ----------------------------------------------------------------------
// Shop cart frame: basket trolley
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bed_l = 80;               // bed length, X
bed_w = 45;               // bed width, Y
bed_h = 12;               // bed height (caster stubs)
top_h = 45;               // rim height
top_dx = 8;               // rim slant, X
handle_up = 18;           // handle rise above the rim
handle_dx = 10;           // handle reach, -X
tube_r = 2;               // frame tube radius
joint_r = 2.4;            // joint ball radius

bbox_x = 94.8;  // overall X, joints included
bbox_y = 49.8;  // overall Y, joints included
bbox_z = 67.8;  // overall Z, joints included
tube_d = 2 * tube_r;  // tube diameter
nodes = [[0.0, 0.0, 12.0], [80.0, 0.0, 12.0], [80.0, 45.0, 12.0], [0.0, 45.0, 12.0], [8.0, 0.0, 45.0], [88.0, 0.0, 45.0], [88.0, 45.0, 45.0], [8.0, 45.0, 45.0], [-2.0, 0.0, 63.0], [-2.0, 45.0, 63.0], [0.0, 0.0, 0.0], [80.0, 0.0, 0.0], [80.0, 45.0, 0.0], [0.0, 45.0, 0.0]];

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
member(nodes[0], nodes[1], tube_r);
member(nodes[1], nodes[2], tube_r);
member(nodes[2], nodes[3], tube_r);
member(nodes[3], nodes[0], tube_r);
member(nodes[4], nodes[5], tube_r);
member(nodes[5], nodes[6], tube_r);
member(nodes[6], nodes[7], tube_r);
member(nodes[7], nodes[4], tube_r);
member(nodes[0], nodes[4], tube_r);
member(nodes[1], nodes[5], tube_r);
member(nodes[2], nodes[6], tube_r);
member(nodes[3], nodes[7], tube_r);
member(nodes[4], nodes[8], tube_r);
member(nodes[7], nodes[9], tube_r);
member(nodes[8], nodes[9], tube_r);
member(nodes[0], nodes[10], tube_r);
member(nodes[1], nodes[11], tube_r);
member(nodes[2], nodes[12], tube_r);
member(nodes[3], nodes[13], tube_r);

/* joint balls */
for (p = nodes) joint(p, joint_r);
