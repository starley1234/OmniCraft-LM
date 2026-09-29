$fn = 32;

// ----------------------------------------------------------------------
// Bearing block: 80 x 52 mm base, 19.05 mm bore at 25.52 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
base_w = 80;              // base width
base_d = 52;              // base depth
base_t = 10;              // base thickness
bore_d = 19.05;           // shaft / bearing bore
house_r = 16.52;          // housing outer radius
house_len = 40.56;        // housing length along the shaft
foot_w = 33.04;           // foot width under the housing
foot_len = 30.56;         // foot length along the shaft
axis_z = 25.52;           // bore axis height above the base
holes_d = 11;             // mounting holes
hole_x = 28;              // mounting hole spacing
seat_d = 8;               // bearing seat depth
seat_wall = 4;            // seat wall thickness

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
  for (hx = [-28, 28]) {
    for (hy = [-13, 13]) {
      translate([hx, hy, -2.5]) cylinder(h = base_t + 5, d = holes_d);
    }
  }
}
