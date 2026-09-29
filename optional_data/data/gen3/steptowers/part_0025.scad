$fn = 32;

// ----------------------------------------------------------------------
// Stepped tower: 72 mm base, 5 tiers to 210 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
tiers = 5;                // number of tiers
tier_h = 42;              // tier height
base_w = 72;              // bottom footprint width
taper = 0.86;             // footprint shrink per tier
chord_r = 2.4;            // leg radius
diag_r = 2.8;             // brace radius
joint_r = 5.53;           // joint ball radius

cx = [-1, 1, 1, -1];
cy = [-1, -1, 1, 1];
widths = [72, 61.92, 53.25, 45.8, 39.38, 33.87];
heights = [0, 42, 84, 126, 168, 210];

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

/* legs */
for (l = [0 : tiers - 1]) {
  for (c = [0 : 3]) {
    member([cx[c] * widths[l] / 2, cy[c] * widths[l] / 2, heights[l]], [cx[c] * widths[l + 1] / 2, cy[c] * widths[l + 1] / 2, heights[l + 1]], chord_r);
  }
}
/* ring at every level */
for (l = [0 : tiers]) {
  member([cx[0] * widths[l] / 2, cy[0] * widths[l] / 2, heights[l]], [cx[1] * widths[l] / 2, cy[1] * widths[l] / 2, heights[l]], diag_r);
  member([cx[1] * widths[l] / 2, cy[1] * widths[l] / 2, heights[l]], [cx[2] * widths[l] / 2, cy[2] * widths[l] / 2, heights[l]], diag_r);
  member([cx[2] * widths[l] / 2, cy[2] * widths[l] / 2, heights[l]], [cx[3] * widths[l] / 2, cy[3] * widths[l] / 2, heights[l]], diag_r);
  member([cx[3] * widths[l] / 2, cy[3] * widths[l] / 2, heights[l]], [cx[0] * widths[l] / 2, cy[0] * widths[l] / 2, heights[l]], diag_r);
}
/* face crosses, one X per face per tier */
for (l = [0 : tiers - 1]) {
  member([cx[0] * widths[l] / 2, cy[0] * widths[l] / 2, heights[l]], [cx[1] * widths[l + 1] / 2, cy[1] * widths[l + 1] / 2, heights[l + 1]], diag_r);
  member([cx[1] * widths[l] / 2, cy[1] * widths[l] / 2, heights[l]], [cx[2] * widths[l + 1] / 2, cy[2] * widths[l + 1] / 2, heights[l + 1]], diag_r);
  member([cx[2] * widths[l] / 2, cy[2] * widths[l] / 2, heights[l]], [cx[3] * widths[l + 1] / 2, cy[3] * widths[l + 1] / 2, heights[l + 1]], diag_r);
  member([cx[3] * widths[l] / 2, cy[3] * widths[l] / 2, heights[l]], [cx[0] * widths[l + 1] / 2, cy[0] * widths[l + 1] / 2, heights[l + 1]], diag_r);
}
/* joint balls */
for (l = [0 : tiers]) {
  for (c = [0 : 3]) joint([cx[c] * widths[l] / 2, cy[c] * widths[l] / 2, heights[l]], joint_r);
}
