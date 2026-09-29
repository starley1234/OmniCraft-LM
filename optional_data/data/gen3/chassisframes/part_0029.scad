$fn = 32;

// ----------------------------------------------------------------------
// Chassis frame: 190 x 70 mm, 28 mm tall, 2 cross members
// ----------------------------------------------------------------------

// --- parameters (mm) ---
frame_l = 190;            // frame length, X
frame_w = 70;             // frame width, Y
frame_h = 28;             // frame height, Z
crossings = 2;            // number of cross members
chord_r = 3.4;            // main tube radius
diag_r = 2.4;             // brace radius
joint_r = 6.24;           // joint ball radius

cross_x = [-31.67, 31.67];
floor_nodes = [[-31.67, -35, 0], [31.67, 35, 0]];
bottom = [[-95, -35, 0], [95, -35, 0], [95, 35, 0], [-95, 35, 0]];
top = [[-95, -35, 28], [95, -35, 28], [95, 35, 28], [-95, 35, 28]];

module member(a, b, r) {
  /* rod: cylinder from joint a to joint b */
  d = b - a;
  length = norm(d);
  translate(a) rotate([0, acos(d[2] / length), atan2(d[1], d[0])])
    cylinder(h = length, r = r);
}

module joint(p, r) {
  /* ball at the joint centre */
  translate(p) sphere(r = r);
}

/* bottom rails, one member per side */
member(bottom[0], bottom[1], chord_r);
member(bottom[1], bottom[2], chord_r);
member(bottom[2], bottom[3], chord_r);
member(bottom[3], bottom[0], chord_r);
/* cross members */
for (i = [0 : crossings - 1]) {
  member([cross_x[i], -frame_w / 2, 0], [cross_x[i], frame_w / 2, 0], diag_r);
}
/* floor zig-zag brace between the cross member ends */
member(bottom[0], floor_nodes[0], diag_r);
for (i = [0 : crossings - 2]) member(floor_nodes[i], floor_nodes[i + 1], diag_r);
member(floor_nodes[crossings - 1], bottom[1], diag_r);
/* corner posts and top ring */
for (c = [0 : 3]) member(bottom[c], top[c], chord_r);
member(top[0], top[1], diag_r);
member(top[1], top[2], diag_r);
member(top[2], top[3], diag_r);
member(top[3], top[0], diag_r);
/* face crosses on the two long sides */
member(bottom[0], top[1], diag_r);
member(top[0], bottom[1], diag_r);
member(bottom[3], top[2], diag_r);
member(top[3], bottom[2], diag_r);
/* joint balls */
for (c = [0 : 3]) joint(bottom[c], joint_r);
for (c = [0 : 3]) joint(top[c], joint_r);
for (i = [0 : crossings - 1]) joint([cross_x[i], -frame_w / 2, 0], joint_r);
for (i = [0 : crossings - 1]) joint([cross_x[i], frame_w / 2, 0], joint_r);
