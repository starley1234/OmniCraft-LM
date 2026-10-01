$fn = 32;

// ----------------------------------------------------------------------
// Chair frame: seat 38 mm, splay 6 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
seat = 38;                // seat side, X and Y
seat_h = 42;              // seat height
splay = 6;                // leg splay at the floor
str_h = 18;               // stretcher ring height
back_h = 42;              // backrest height above the seat
bar_r = 2;                // frame bar radius
joint_r = 2.4;            // joint ball radius

bbox_x = 54.8;  // overall X, joints included
bbox_y = 54.8;  // overall Y, joints included
bbox_z = 88.8;  // overall Z, joints included
bar_d = 2 * bar_r;  // bar diameter
nodes = [[-19.0, -19.0, 42.0], [19.0, -19.0, 42.0], [19.0, 19.0, 42.0], [-19.0, 19.0, 42.0], [-25.0, -25.0, 0.0], [25.0, -25.0, 0.0], [25.0, 25.0, 0.0], [-25.0, 25.0, 0.0], [-21.5714, -21.5714, 18.0], [21.5714, -21.5714, 18.0], [21.5714, 21.5714, 18.0], [-21.5714, 21.5714, 18.0], [-19.0, -19.0, 84.0], [-19.0, 19.0, 84.0], [-19.0, -19.0, 63.0], [-19.0, 19.0, 63.0]];

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
member(nodes[0], nodes[1], bar_r);
member(nodes[4], nodes[5], bar_r);
member(nodes[0], nodes[4], bar_r);
member(nodes[8], nodes[9], bar_r);
member(nodes[4], nodes[8], bar_r);
member(nodes[1], nodes[2], bar_r);
member(nodes[5], nodes[6], bar_r);
member(nodes[1], nodes[5], bar_r);
member(nodes[9], nodes[10], bar_r);
member(nodes[5], nodes[9], bar_r);
member(nodes[2], nodes[3], bar_r);
member(nodes[6], nodes[7], bar_r);
member(nodes[2], nodes[6], bar_r);
member(nodes[10], nodes[11], bar_r);
member(nodes[6], nodes[10], bar_r);
member(nodes[3], nodes[0], bar_r);
member(nodes[7], nodes[4], bar_r);
member(nodes[3], nodes[7], bar_r);
member(nodes[11], nodes[8], bar_r);
member(nodes[7], nodes[11], bar_r);
member(nodes[0], nodes[12], bar_r);
member(nodes[3], nodes[13], bar_r);
member(nodes[12], nodes[13], bar_r);
member(nodes[12], nodes[14], bar_r);
member(nodes[14], nodes[15], bar_r);
member(nodes[15], nodes[13], bar_r);

/* joint balls */
for (p = nodes) joint(p, joint_r);
