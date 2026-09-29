$fn = 32;

// ----------------------------------------------------------------------
// Boat cleat: 90 mm base, horn 34 mm up
// ----------------------------------------------------------------------

// --- parameters (mm) ---
base_l = 90;              // base length
base_w = 30;              // base width
base_t = 10;              // base thickness
horn_len = 85.5;          // horn length
horn_d = 22;              // horn diameter at the middle
horn_z = 34;              // horn axis height
end_drop = 10;            // how far the horn tips drop
post_d = 11;              // centre post diameter
holes_d = 6.35;           // fixing holes
hole_x = 33;              // fixing hole spacing

difference() {
  union() {
    translate([-45, -15, 0]) cube([base_l, base_w, base_t]);
    /* centre post, sunk 1 mm into the base */
    translate([0, 0, 9]) cylinder(h = 25, d = post_d);
    /* horn: a hull chain of boxes, full in the middle and lighter at the tips */
    hull() {
      translate([-42.75, -4.95, 23]) cube([0.4, 9.9, 12], center = false);
      translate([-27.36, -8.8, 23]) cube([0.4, 17.6, 19.5], center = false);
    }
    hull() {
      translate([-27.36, -8.8, 23]) cube([0.4, 17.6, 19.5], center = false);
      translate([0, -11, 23]) cube([0.4, 22, 22], center = false);
    }
    hull() {
      translate([0, -11, 23]) cube([0.4, 22, 22], center = false);
      translate([27.36, -8.8, 23]) cube([0.4, 17.6, 19.5], center = false);
    }
    hull() {
      translate([27.36, -8.8, 23]) cube([0.4, 17.6, 19.5], center = false);
      translate([42.75, -4.95, 23]) cube([0.4, 9.9, 12], center = false);
    }
  }
  translate([-33, 0, -2.5]) cylinder(h = base_t + 5, d = holes_d);
  translate([33, 0, -2.5]) cylinder(h = base_t + 5, d = holes_d);
}
