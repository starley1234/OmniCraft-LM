$fn = 32;

// ----------------------------------------------------------------------
// A-frame ladder: 3 rungs, 110 mm tall
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_rung = 3;               // rungs per climbing face
height = 110;             // apex height
foot_w = 45;              // frame foot spread, X
lean = 25;                // rear frame foot offset
ladder_w = 38;            // ladder width, Y
plat_l = 28;              // top platform length
rail_r = 3;               // rail member radius
rung_r = 2.2;             // rung member radius
joint_r = 3.4;            // joint ball radius
fit_tol = 0.05;           // declared fit tolerance (prompt contract)
free_tol = 0.3;           // declared free tolerance (prompt contract)

bbox_x = 76.8;  // overall X, joints included
bbox_y = 44.8;  // overall Y, joints included
bbox_z = 116.8;  // overall Z, joints included
rail_d = 2 * rail_r;  // rail stock diameter
rung_d = 2 * rung_r;  // rung stock diameter
nodes = [[0.0, -19.0, 110.0], [-22.5, -19.0, 0.0], [22.5, -19.0, 0.0], [0.0, 19.0, 110.0], [-47.5, 19.0, 0.0], [-2.5, 19.0, 0.0], [-5.625, -19.0, 82.5], [5.625, -19.0, 82.5], [-11.25, -19.0, 55.0], [11.25, -19.0, 55.0], [-16.875, -19.0, 27.5], [16.875, -19.0, 27.5], [-14.0, -19.0, 104.0], [14.0, -19.0, 104.0], [14.0, 19.0, 104.0], [-14.0, 19.0, 104.0]];

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
member(nodes[6], nodes[8], rung_r);
member(nodes[7], nodes[9], rung_r);
member(nodes[8], nodes[10], rung_r);
member(nodes[9], nodes[11], rung_r);
member(nodes[12], nodes[13], rung_r);
member(nodes[13], nodes[14], rung_r);
member(nodes[14], nodes[15], rung_r);
member(nodes[15], nodes[12], rung_r);
member(nodes[0], nodes[12], rung_r);
member(nodes[0], nodes[13], rung_r);
member(nodes[3], nodes[14], rung_r);
member(nodes[3], nodes[15], rung_r);

/* joint balls */
for (p = nodes) joint(p, joint_r);
