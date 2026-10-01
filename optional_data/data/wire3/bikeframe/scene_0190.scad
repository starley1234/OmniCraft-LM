$fn = 32;

// ----------------------------------------------------------------------
// Bicycle frame: diamond frame, wheelbase 128 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
track = 52;               // distance between the rear dropouts
hub_z = 22;               // wheel hub height
bb_x = 85;                // bottom bracket X
bb_z = 28;                // bottom bracket height
ht_bot_x = 36;            // head tube bottom X
ht_bot_z = 68;            // head tube bottom height
ht_top_x = 18;            // head tube top X
ht_top_z = 100;           // head tube top height
st_x = 93;                // seat cluster X
st_z = 108;               // seat cluster height
fh_x = 128;               // front hub X (wheelbase)
tube_r = 2.5;             // frame tube radius
joint_r = 3;              // joint ball radius

bbox_x = fh_x + 2 * joint_r;  // overall X, joints included
bbox_y = track + 2 * joint_r;  // overall Y, joints included
bbox_z = 108 - hub_z + 2 * joint_r;  // overall Z, joints included
tube_d = 2 * tube_r;  // frame tube diameter
wheelbase = fh_x;  // rear axle to front hub
nodes = [[bb_x, 0, bb_z], [ht_bot_x, 0, ht_bot_z], [ht_top_x, 0, ht_top_z], [st_x, 0, st_z], [0, track / 2, hub_z], [0, -track / 2, hub_z], [fh_x, track / 2, hub_z], [fh_x, -track / 2, hub_z]];

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
member(nodes[1], nodes[2], tube_r);
member(nodes[1], nodes[0], tube_r);
member(nodes[2], nodes[3], tube_r);
member(nodes[3], nodes[0], tube_r);
member(nodes[0], nodes[4], tube_r);
member(nodes[0], nodes[5], tube_r);
member(nodes[3], nodes[4], tube_r);
member(nodes[3], nodes[5], tube_r);
member(nodes[1], nodes[6], tube_r);
member(nodes[1], nodes[7], tube_r);
member(nodes[6], nodes[7], tube_r);
member(nodes[4], nodes[5], tube_r);

/* joint balls */
for (p = nodes) joint(p, joint_r);
