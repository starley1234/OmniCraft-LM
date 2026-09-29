$fn = 32;

// ----------------------------------------------------------------------
// Bearing block: 100 x 52 mm base, 31.75 mm bore at 32.88 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
base_w = 100;             // base width
base_d = 52;              // base depth
base_t = 10;              // base thickness
bore_d = 31.75;           // shaft / bearing bore
house_r = 23.88;          // housing outer radius
house_len = 40.56;        // housing length along the shaft
foot_w = 47.76;           // foot width under the housing
foot_len = 30.56;         // foot length along the shaft
axis_z = 32.88;           // bore axis height above the base
holes_d = 11;             // mounting holes
hole_x = 34;              // mounting hole spacing

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
  /* mounting holes through the base plate */
  for (hx = [-34, 34]) {
    for (hy = [-13, 13]) {
      translate([hx, hy, -2.5]) cylinder(h = base_t + 5, d = holes_d);
    }
  }
}
