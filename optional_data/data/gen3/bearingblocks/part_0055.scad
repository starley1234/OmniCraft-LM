$fn = 32;

// ----------------------------------------------------------------------
// Bearing block: 80 x 60 mm base, 22.23 mm bore at 25.11 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
base_w = 80;              // base width
base_d = 60;              // base depth
base_t = 8;               // base thickness
bore_d = 22.23;           // shaft / bearing bore
house_r = 18.11;          // housing outer radius
house_len = 43.2;         // housing length along the shaft
foot_w = 36.22;           // foot width under the housing
foot_len = 33.2;          // foot length along the shaft
axis_z = 25.11;           // bore axis height above the base
holes_d = 9;              // mounting holes
hole_x = 24.11;           // mounting hole spacing

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
  for (hx = [-24.11, 24.11]) {
    for (hy = [-15, 15]) {
      translate([hx, hy, -2.5]) cylinder(h = base_t + 5, d = holes_d);
    }
  }
}
