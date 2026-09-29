$fn = 32;

// ----------------------------------------------------------------------
// Bearing block: 100 x 52 mm base, 25.4 mm bore at 31.7 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
base_w = 100;             // base width
base_d = 52;              // base depth
base_t = 12;              // base thickness
bore_d = 25.4;            // shaft / bearing bore
house_r = 20.7;           // housing outer radius
house_len = 34.32;        // housing length along the shaft
foot_w = 41.4;            // foot width under the housing
foot_len = 24.32;         // foot length along the shaft
axis_z = 31.7;            // bore axis height above the base
holes_d = 13;             // mounting holes
hole_x = 38;              // mounting hole spacing
groove_w = 3.6;           // oil groove width

difference() {
  union() {
    /* base plate with its underside on z = 0 */
    translate([0, 0, base_t / 2]) cube([base_w, base_d, base_t], center = true);
    /* hull foot: a straight web blending into the round housing */
    hull() {
      translate([0, 0, base_t - 0.5]) cube([foot_w, foot_len, 1.6], center = true);
      translate([0, 0, axis_z]) rotate([-90, 0, 0]) cylinder(h = house_len, d = 2 * house_r, center = true);
    }
  }
  /* bore through the housing, 2.5 mm clear on both sides */
  translate([0, 0, axis_z]) rotate([-90, 0, 0]) cylinder(h = house_len + 5, d = bore_d, center = true);
  /* oil groove from the top of the housing into the bore */
  translate([-groove_w / 2, -house_len / 2 - 2.5, axis_z + bore_d * 0.17]) cube([groove_w, house_len + 5, house_r + 5]);
  /* mounting holes through the base plate */
  for (hx = [-38, 38]) {
    for (hy = [-13, 13]) {
      translate([hx, hy, -2.5]) cylinder(h = base_t + 5, d = holes_d);
    }
  }
}
