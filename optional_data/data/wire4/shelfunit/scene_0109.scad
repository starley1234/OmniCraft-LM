$fn = 32;

// ----------------------------------------------------------------------
// Shelf unit: 3 shelves, 70 x 40 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_shelf = 3;              // number of shelf loops
width = 70;               // unit width, X
depth = 40;               // unit depth, Y
pitch = 40;               // shelf pitch
base_h = 12;              // foot height
bar_r = 2;                // frame bar radius
brace_r = 1.5;            // tie and brace member radius
joint_r = 2.4;            // joint ball radius

bbox_x = 74.8;  // overall X, joints included
bbox_y = 44.8;  // overall Y, joints included
bbox_z = 146.8;  // overall Z, joints included
bar_d = 2 * bar_r;  // bar diameter
brace_d = 2 * brace_r;  // brace stock diameter
top_z = base_h + n_shelf * pitch + 10;  // post top height
nodes = [[0.0, 0.0, 0.0], [0.0, 0.0, 142.0], [70.0, 0.0, 0.0], [70.0, 0.0, 142.0], [70.0, 40.0, 0.0], [70.0, 40.0, 142.0], [0.0, 40.0, 0.0], [0.0, 40.0, 142.0], [0.0, 0.0, 12.0], [70.0, 0.0, 12.0], [70.0, 40.0, 12.0], [0.0, 40.0, 12.0], [0.0, 0.0, 52.0], [70.0, 0.0, 52.0], [70.0, 40.0, 52.0], [0.0, 40.0, 52.0], [0.0, 0.0, 92.0], [70.0, 0.0, 92.0], [70.0, 40.0, 92.0], [0.0, 40.0, 92.0], [0.0, 0.0, 132.0], [70.0, 0.0, 132.0], [70.0, 40.0, 132.0], [0.0, 40.0, 132.0]];

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
member(nodes[2], nodes[3], bar_r);
member(nodes[4], nodes[5], bar_r);
member(nodes[6], nodes[7], bar_r);
member(nodes[8], nodes[9], bar_r);
member(nodes[9], nodes[10], bar_r);
member(nodes[10], nodes[11], bar_r);
member(nodes[11], nodes[8], bar_r);
member(nodes[8], nodes[1], brace_r);
member(nodes[9], nodes[3], brace_r);
member(nodes[10], nodes[5], brace_r);
member(nodes[11], nodes[7], brace_r);
member(nodes[12], nodes[13], bar_r);
member(nodes[13], nodes[14], bar_r);
member(nodes[14], nodes[15], bar_r);
member(nodes[15], nodes[12], bar_r);
member(nodes[12], nodes[1], brace_r);
member(nodes[13], nodes[3], brace_r);
member(nodes[14], nodes[5], brace_r);
member(nodes[15], nodes[7], brace_r);
member(nodes[16], nodes[17], bar_r);
member(nodes[17], nodes[18], bar_r);
member(nodes[18], nodes[19], bar_r);
member(nodes[19], nodes[16], bar_r);
member(nodes[16], nodes[1], brace_r);
member(nodes[17], nodes[3], brace_r);
member(nodes[18], nodes[5], brace_r);
member(nodes[19], nodes[7], brace_r);
member(nodes[20], nodes[21], bar_r);
member(nodes[21], nodes[22], bar_r);
member(nodes[22], nodes[23], bar_r);
member(nodes[23], nodes[20], bar_r);
member(nodes[20], nodes[1], brace_r);
member(nodes[21], nodes[3], brace_r);
member(nodes[22], nodes[5], brace_r);
member(nodes[23], nodes[7], brace_r);
member(nodes[0], nodes[3], brace_r);
member(nodes[2], nodes[1], brace_r);
member(nodes[2], nodes[5], brace_r);
member(nodes[6], nodes[5], brace_r);

/* joint balls */
for (p = nodes) joint(p, joint_r);
