$fn = 32;

// ----------------------------------------------------------------------
// Tapered four-leg tower: 3 levels, base 90 mm, taper 0.78 per level
// ----------------------------------------------------------------------

// --- parameters (mm) ---
levels = 3;               // number of tower levels
base_w = 90;              // bottom ring width (X and Y)
taper = 0.78;             // ring width multiplier per level
level_h = 30;             // height of one level
leg_r = 4.5;              // leg / ring member radius
brace_r = 3.7;            // diagonal brace radius
joint_r = 4.9;            // joint ball radius

bbox_x = base_w + 2 * joint_r;  // overall X, joints included
bbox_y = base_w + 2 * joint_r;  // overall Y, joints included
bbox_z = levels * level_h + 2 * joint_r;  // overall Z, joints included
leg_d = 2 * leg_r;  // leg / ring stock diameter
brace_d = 2 * brace_r;  // brace stock diameter
joint_d = 2 * joint_r;  // joint ball diameter
top_w = base_w * pow(taper, levels);  // width of the top ring
nodes = [for (lvl = [0 : levels], sx = [-1, 1], sy = [-1, 1]) [sx * base_w * pow(taper, lvl) / 2, sy * base_w * pow(taper, lvl) / 2, lvl * level_h]];

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
member(nodes[0], nodes[4], leg_r);
member(nodes[1], nodes[5], leg_r);
member(nodes[2], nodes[6], leg_r);
member(nodes[3], nodes[7], leg_r);
member(nodes[4], nodes[8], leg_r);
member(nodes[5], nodes[9], leg_r);
member(nodes[6], nodes[10], leg_r);
member(nodes[7], nodes[11], leg_r);
member(nodes[8], nodes[12], leg_r);
member(nodes[9], nodes[13], leg_r);
member(nodes[10], nodes[14], leg_r);
member(nodes[11], nodes[15], leg_r);
member(nodes[0], nodes[1], leg_r);
member(nodes[2], nodes[3], leg_r);
member(nodes[0], nodes[2], leg_r);
member(nodes[1], nodes[3], leg_r);
member(nodes[4], nodes[5], leg_r);
member(nodes[6], nodes[7], leg_r);
member(nodes[4], nodes[6], leg_r);
member(nodes[5], nodes[7], leg_r);
member(nodes[8], nodes[9], leg_r);
member(nodes[10], nodes[11], leg_r);
member(nodes[8], nodes[10], leg_r);
member(nodes[9], nodes[11], leg_r);
member(nodes[12], nodes[13], leg_r);
member(nodes[14], nodes[15], leg_r);
member(nodes[12], nodes[14], leg_r);
member(nodes[13], nodes[15], leg_r);
member(nodes[0], nodes[5], brace_r);
member(nodes[3], nodes[6], brace_r);
member(nodes[0], nodes[6], brace_r);
member(nodes[3], nodes[5], brace_r);
member(nodes[5], nodes[8], brace_r);
member(nodes[6], nodes[11], brace_r);
member(nodes[6], nodes[8], brace_r);
member(nodes[5], nodes[11], brace_r);

/* joint balls */
for (p = nodes) joint(p, joint_r);
