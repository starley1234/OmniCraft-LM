$fn = 32;

// ----------------------------------------------------------------------
// A-frame ladder: 4 rungs, 110 mm tall
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_rung = 4;               // rungs per climbing face
height = 110;             // apex height
foot_w = 40;              // frame foot spread, X
lean = 35;                // rear frame foot offset
ladder_w = 34;            // ladder width, Y
plat_l = 28;              // top platform length
rail_r = 2.5;             // rail member radius
rung_r = 1.7;             // rung member radius
joint_r = 2.9;            // joint ball radius

bbox_x = 80.8;  // overall X, joints included
bbox_y = 39.8;  // overall Y, joints included
bbox_z = 115.8;  // overall Z, joints included
rail_d = 2 * rail_r;  // rail stock diameter
rung_d = 2 * rung_r;  // rung stock diameter
nodes = [[0.0, -17.0, 110.0], [-20.0, -17.0, 0.0], [20.0, -17.0, 0.0], [0.0, 17.0, 110.0], [-55.0, 17.0, 0.0], [-15.0, 17.0, 0.0], [-4.0, -17.0, 88.0], [4.0, -17.0, 88.0], [-8.0, -17.0, 66.0], [8.0, -17.0, 66.0], [-12.0, -17.0, 44.0], [12.0, -17.0, 44.0], [-16.0, -17.0, 22.0], [16.0, -17.0, 22.0], [-14.0, -17.0, 104.0], [14.0, -17.0, 104.0], [14.0, 17.0, 104.0], [-14.0, 17.0, 104.0]];

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
member(nodes[0], nodes[2], rail_r);
member(nodes[1], nodes[2], rung_r);
member(nodes[3], nodes[4], rail_r);
member(nodes[3], nodes[5], rail_r);
member(nodes[4], nodes[5], rung_r);
member(nodes[0], nodes[3], rail_r);
member(nodes[6], nodes[7], rung_r);
member(nodes[1], nodes[6], rung_r);
member(nodes[2], nodes[7], rung_r);
member(nodes[8], nodes[9], rung_r);
member(nodes[10], nodes[11], rung_r);
member(nodes[12], nodes[13], rung_r);
member(nodes[6], nodes[8], rung_r);
member(nodes[7], nodes[9], rung_r);
member(nodes[8], nodes[10], rung_r);
member(nodes[9], nodes[11], rung_r);
member(nodes[10], nodes[12], rung_r);
member(nodes[11], nodes[13], rung_r);
member(nodes[14], nodes[15], rung_r);
member(nodes[15], nodes[16], rung_r);
member(nodes[16], nodes[17], rung_r);
member(nodes[17], nodes[14], rung_r);
member(nodes[0], nodes[14], rung_r);
member(nodes[0], nodes[15], rung_r);
member(nodes[3], nodes[16], rung_r);
member(nodes[3], nodes[17], rung_r);

/* joint balls */
for (p = nodes) joint(p, joint_r);
