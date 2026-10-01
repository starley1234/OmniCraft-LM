$fn = 32;

// ----------------------------------------------------------------------
// Howe through truss: span 112 mm, 4 panels, two trusses 44 mm apart
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panels = 4;               // number of equal panels per truss
panel_p = 28;             // panel length, X
span = 112;               // truss span between end joints
truss_h = 32;             // truss height, Z
track = 44;               // distance between the two trusses, Y
chord_r = 5;              // chord member radius
web_r = 3.4;              // web member radius
deck_r = 3.4;             // deck beam radius
joint_r = 5.4;            // joint ball radius
fit_tol = 0.05;           // declared fit tolerance (prompt contract)
free_tol = 0.3;           // declared free tolerance (prompt contract)

bbox_x = span + 2 * joint_r;  // overall X, joints included
bbox_y = track + 2 * joint_r;  // overall Y, joints included
bbox_z = truss_h + 2 * joint_r;  // overall Z, joints included
chord_d = 2 * chord_r;  // chord stock diameter
web_d = 2 * web_r;  // web stock diameter
deck_d = 2 * deck_r;  // deck beam diameter
joint_d = 2 * joint_r;  // joint ball diameter
nodes = [for (side = [-1, 1], i = [0 : panels]) [i * panel_p, side * track / 2, 0], for (side = [-1, 1], i = [0 : panels]) [i * panel_p, side * track / 2, truss_h]];

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
member(nodes[10], nodes[11], chord_r);
member(nodes[11], nodes[12], chord_r);
member(nodes[12], nodes[13], chord_r);
member(nodes[13], nodes[14], chord_r);
member(nodes[1], nodes[11], web_r);
member(nodes[2], nodes[12], web_r);
member(nodes[3], nodes[13], web_r);
member(nodes[10], nodes[1], web_r);
member(nodes[11], nodes[2], web_r);
member(nodes[2], nodes[13], web_r);
member(nodes[3], nodes[14], web_r);
member(nodes[5], nodes[6], chord_r);
member(nodes[6], nodes[7], chord_r);
member(nodes[7], nodes[8], chord_r);
member(nodes[8], nodes[9], chord_r);
member(nodes[15], nodes[16], chord_r);
member(nodes[16], nodes[17], chord_r);
member(nodes[17], nodes[18], chord_r);
member(nodes[18], nodes[19], chord_r);
member(nodes[6], nodes[16], web_r);
member(nodes[7], nodes[17], web_r);
member(nodes[8], nodes[18], web_r);
member(nodes[15], nodes[6], web_r);
member(nodes[16], nodes[7], web_r);
member(nodes[7], nodes[18], web_r);
member(nodes[8], nodes[19], web_r);
member(nodes[0], nodes[5], deck_r);
member(nodes[1], nodes[6], deck_r);
member(nodes[2], nodes[7], deck_r);
member(nodes[3], nodes[8], deck_r);
member(nodes[4], nodes[9], deck_r);
member(nodes[0], nodes[6], deck_r);
member(nodes[5], nodes[1], deck_r);
member(nodes[1], nodes[7], deck_r);
member(nodes[6], nodes[2], deck_r);
member(nodes[2], nodes[8], deck_r);
member(nodes[7], nodes[3], deck_r);
member(nodes[3], nodes[9], deck_r);
member(nodes[8], nodes[4], deck_r);

/* joint balls */
for (p = nodes) joint(p, joint_r);
