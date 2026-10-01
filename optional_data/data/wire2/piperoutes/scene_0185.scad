$fn = 32;

// ----------------------------------------------------------------------
// Pipe route
// ----------------------------------------------------------------------

// --- parameters (mm) ---
pipe_r = 3;               // pipe radius
collar_r = 3.6;           // joint collar radius
turn_90 = 90;             // right-angle elbow, degrees
turn_45 = 45;             // diagonal elbow angle, degrees
leg_1 = 44;               // length of pipe segment 1
leg_2 = 48;               // length of pipe segment 2
leg_3 = 48;               // length of pipe segment 3
leg_4 = 32;               // length of pipe segment 4
leg_5 = 40;               // length of pipe segment 5
segments = 5;             // number of straight pipe segments
stub_3 = 28;              // branch stub length at node 3
stub_1 = 24;              // branch stub length at node 1
stub_2 = 24;              // branch stub length at node 2

bbox_x = (leg_2 + leg_5 / sqrt(2)) - (0) + 2 * collar_r;  // overall X, joints included
bbox_y = (leg_1 + leg_3) - (0) + 2 * collar_r;  // overall Y, joints included
bbox_z = (leg_4 + leg_5 / sqrt(2)) - (0) + 2 * collar_r;  // overall Z, joints included
pipe_d = 2 * pipe_r;  // pipe outer diameter
collar_d = 2 * collar_r;  // collar diameter
p0 = [0, 0, 0];
p1 = p0 + [0, 1, 0] * leg_1;
p2 = p1 + [1, 0, 0] * leg_2;
p3 = p2 + [0, 1, 0] * leg_3;
p4 = p3 + [0, 0, 1] * leg_4;
p5 = p4 + [1 / sqrt(2), 0, 1 / sqrt(2)] * leg_5;
b3 = p3 + [0, 0, 1] * stub_3;
b1 = p1 + [0, 0, 1] * stub_1;
b2 = p2 + [0, -1, 0] * stub_2;
nodes = [p0, p1, p2, p3, p4, p5, b3, b1, b2];

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
member(nodes[0], nodes[1], pipe_r);
member(nodes[1], nodes[2], pipe_r);
member(nodes[2], nodes[3], pipe_r);
member(nodes[3], nodes[4], pipe_r);
member(nodes[4], nodes[5], pipe_r);
member(nodes[3], nodes[6], pipe_r);
member(nodes[1], nodes[7], pipe_r);
member(nodes[2], nodes[8], pipe_r);

/* joint balls */
for (p = nodes) joint(p, collar_r);
