$fn = 32;

// ----------------------------------------------------------------------
// Bearing block: 90 x 60 mm base, 31.75 mm bore at 33.88 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
base_w = 90;              // base width
base_d = 60;              // base depth
base_t = 12;              // base thickness
bore_d = 31.75;           // shaft / bearing bore
house_r = 22.88;          // housing outer radius
house_len = 39.6;         // housing length along the shaft
foot_w = 45.76;           // foot width under the housing
foot_len = 29.6;          // foot length along the shaft
axis_z = 33.88;           // bore axis height above the base
holes_d = 11;             // mounting holes
hole_x = 31;              // mounting hole spacing

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
  for (hx = [-31, 31]) {
    for (hy = [-15, 15]) {
      translate([hx, hy, -2.5]) cylinder(h = base_t + 5, d = holes_d);
    }
  }
}
