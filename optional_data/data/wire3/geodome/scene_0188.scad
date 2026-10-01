$fn = 32;

// ----------------------------------------------------------------------
// Geodesic dome: 6-gon rings, base R45, top R16
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 6;                // polygon order of both rings
base_r = 45;              // base ring radius
top_r = 16;               // top ring radius
ring_h = 25;              // height of the top ring
rise = 25;                // apex rise above the top ring
twist = 30;               // angular offset of the top ring, degrees
chord_r = 2.5;            // ring member radius
brace_r = 1.7;            // web member radius
joint_r = 2.9;            // joint ball radius

bbox_x = 95.8;  // overall X, joints included
bbox_y = 83.74;  // overall Y, joints included
bbox_z = 55.8;  // overall Z, joints included
chord_d = 2 * chord_r;  // ring stock diameter
brace_d = 2 * brace_r;  // web stock diameter
apex_z = ring_h + rise;  // apex height
nodes = concat([for (i = [0 : sides - 1]) [base_r * cos(i * 360 / sides), base_r * sin(i * 360 / sides), 0]], [for (i = [0 : sides - 1]) [top_r * cos(i * 360 / sides + twist), top_r * sin(i * 360 / sides + twist), ring_h]], [[0, 0, apex_z]]);

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
member(nodes[0], nodes[1], chord_r);
member(nodes[1], nodes[2], chord_r);
member(nodes[2], nodes[3], chord_r);
member(nodes[3], nodes[4], chord_r);
member(nodes[4], nodes[5], chord_r);
member(nodes[5], nodes[0], chord_r);
member(nodes[6], nodes[7], chord_r);
member(nodes[7], nodes[8], chord_r);
member(nodes[8], nodes[9], chord_r);
member(nodes[9], nodes[10], chord_r);
member(nodes[10], nodes[11], chord_r);
member(nodes[11], nodes[6], chord_r);
member(nodes[0], nodes[6], brace_r);
member(nodes[6], nodes[1], brace_r);
member(nodes[1], nodes[7], brace_r);
member(nodes[7], nodes[2], brace_r);
member(nodes[2], nodes[8], brace_r);
member(nodes[8], nodes[3], brace_r);
member(nodes[3], nodes[9], brace_r);
member(nodes[9], nodes[4], brace_r);
member(nodes[4], nodes[10], brace_r);
member(nodes[10], nodes[5], brace_r);
member(nodes[5], nodes[11], brace_r);
member(nodes[11], nodes[0], brace_r);
member(nodes[12], nodes[6], brace_r);
member(nodes[12], nodes[7], brace_r);
member(nodes[12], nodes[8], brace_r);
member(nodes[12], nodes[9], brace_r);
member(nodes[12], nodes[10], brace_r);
member(nodes[12], nodes[11], brace_r);

/* joint balls */
for (p = nodes) joint(p, joint_r);
