$fn = 32;

// ----------------------------------------------------------------------
// Pipe route
// ----------------------------------------------------------------------

// --- parameters (mm) ---
pipe_r = 4.5;             // pipe radius
collar_r = 5.1;           // joint collar radius
turn_90 = 90;             // right-angle elbow, degrees
turn_45 = 45;             // diagonal elbow angle, degrees
leg_1 = 26;               // length of pipe segment 1
leg_2 = 30;               // length of pipe segment 2
leg_3 = 40;               // length of pipe segment 3
leg_4 = 36;               // length of pipe segment 4
leg_5 = 26;               // length of pipe segment 5
leg_6 = 36;               // length of pipe segment 6
leg_7 = 26;               // length of pipe segment 7
leg_8 = 24;               // length of pipe segment 8
leg_9 = 26;               // length of pipe segment 9
segments = 9;             // number of straight pipe segments

bbox_x = (leg_2 / sqrt(2) + leg_6 / sqrt(2) + leg_8) - (0) + 2 * collar_r;  // overall X, joints included
bbox_y = (leg_4 / sqrt(2)) - (0) + 2 * collar_r;  // overall Y, joints included
bbox_z = (leg_1 + leg_2 / sqrt(2) + leg_3 + leg_4 / sqrt(2) + leg_5 + leg_6 / sqrt(2) + leg_7 + leg_9) - (0) + 2 * collar_r;  // overall Z, joints included
pipe_d = 2 * pipe_r;  // pipe outer diameter
collar_d = 2 * collar_r;  // collar diameter
p0 = [0, 0, 0];
p1 = p0 + [0, 0, 1] * leg_1;
p2 = p1 + [1 / sqrt(2), 0, 1 / sqrt(2)] * leg_2;
p3 = p2 + [0, 0, 1] * leg_3;
p4 = p3 + [0, 1 / sqrt(2), 1 / sqrt(2)] * leg_4;
p5 = p4 + [0, 0, 1] * leg_5;
p6 = p5 + [1 / sqrt(2), 0, 1 / sqrt(2)] * leg_6;
p7 = p6 + [0, 0, 1] * leg_7;
p8 = p7 + [1, 0, 0] * leg_8;
p9 = p8 + [0, 0, 1] * leg_9;
nodes = [p0, p1, p2, p3, p4, p5, p6, p7, p8, p9];

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
member(nodes[5], nodes[6], pipe_r);
member(nodes[6], nodes[7], pipe_r);
member(nodes[7], nodes[8], pipe_r);
member(nodes[8], nodes[9], pipe_r);

/* joint balls */
for (p = nodes) joint(p, collar_r);
