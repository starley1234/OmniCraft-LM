$fn = 32;

// ----------------------------------------------------------------------
// Warren through truss: span 84 mm, 3 panels, two trusses 30 mm apart
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panels = 3;               // number of equal panels per truss
panel_p = 28;             // panel length, X
span = 84;                // truss span between end joints
truss_h = 24;             // truss height, Z
track = 30;               // distance between the two trusses, Y
chord_r = 5;              // chord member radius
web_r = 4;                // web member radius
deck_r = 4;               // deck beam radius
joint_r = 5.4;            // joint ball radius
fit_tol = 0.02;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

bbox_x = span + 2 * joint_r;  // overall X, joints included
bbox_y = track + 2 * joint_r;  // overall Y, joints included
bbox_z = truss_h + 2 * joint_r;  // overall Z, joints included
chord_d = 2 * chord_r;  // chord stock diameter
web_d = 2 * web_r;  // web stock diameter
deck_d = 2 * deck_r;  // deck beam diameter
joint_d = 2 * joint_r;  // joint ball diameter
nodes = [for (side = [-1, 1], i = [0 : panels]) [i * panel_p, side * track / 2, 0], for (side = [-1, 1], i = [0 : panels - 1]) [(i + 0.5) * panel_p, side * track / 2, truss_h]];

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
member(nodes[8], nodes[9], chord_r);
member(nodes[9], nodes[10], chord_r);
member(nodes[0], nodes[8], web_r);
member(nodes[1], nodes[8], web_r);
member(nodes[1], nodes[9], web_r);
member(nodes[2], nodes[9], web_r);
member(nodes[2], nodes[10], web_r);
member(nodes[3], nodes[10], web_r);
member(nodes[4], nodes[5], chord_r);
member(nodes[5], nodes[6], chord_r);
member(nodes[6], nodes[7], chord_r);
member(nodes[11], nodes[12], chord_r);
member(nodes[12], nodes[13], chord_r);
member(nodes[4], nodes[11], web_r);
member(nodes[5], nodes[11], web_r);
member(nodes[5], nodes[12], web_r);
member(nodes[6], nodes[12], web_r);
member(nodes[6], nodes[13], web_r);
member(nodes[7], nodes[13], web_r);
member(nodes[0], nodes[4], deck_r);
member(nodes[1], nodes[5], deck_r);
member(nodes[2], nodes[6], deck_r);
member(nodes[3], nodes[7], deck_r);
member(nodes[0], nodes[5], deck_r);
member(nodes[4], nodes[1], deck_r);
member(nodes[1], nodes[6], deck_r);
member(nodes[5], nodes[2], deck_r);
member(nodes[2], nodes[7], deck_r);
member(nodes[6], nodes[3], deck_r);

/* joint balls */
for (p = nodes) joint(p, joint_r);
