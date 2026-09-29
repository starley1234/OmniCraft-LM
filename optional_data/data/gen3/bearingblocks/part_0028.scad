$fn = 32;

// ----------------------------------------------------------------------
// Bearing block: 90 x 52 mm base, 22.23 mm bore at 26.11 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
base_w = 90;              // base width
base_d = 52;              // base depth
base_t = 8;               // base thickness
bore_d = 22.23;           // shaft / bearing bore
house_r = 19.11;          // housing outer radius
house_len = 37.44;        // housing length along the shaft
foot_w = 38.22;           // foot width under the housing
foot_len = 27.44;         // foot length along the shaft
axis_z = 26.11;           // bore axis height above the base
holes_d = 9;              // mounting holes
hole_x = 33;              // mounting hole spacing
seat_d = 10;              // bearing seat depth
seat_wall = 3;            // seat wall thickness

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
  /* bearing seats, recessed into both ends of the housing */
  for (sy = [-1, 1]) {
    translate([0, sy * (house_len / 2 - seat_d + 2.5), axis_z]) rotate([-90, 0, 0]) cylinder(h = seat_d + 5, d = bore_d + 2 * seat_wall);
  }
  /* mounting holes through the base plate */
  for (hx = [-33, 33]) {
    for (hy = [-13, 13]) {
      translate([hx, hy, -2.5]) cylinder(h = base_t + 5, d = holes_d);
    }
  }
}
