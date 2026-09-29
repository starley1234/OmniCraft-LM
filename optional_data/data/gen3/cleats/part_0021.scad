$fn = 32;

// ----------------------------------------------------------------------
// Boat cleat: 80 mm base, horn 38 mm up
// ----------------------------------------------------------------------

// --- parameters (mm) ---
base_l = 80;              // base length
base_w = 26;              // base width
base_t = 8;               // base thickness
horn_len = 68;            // horn length
horn_d = 18;              // horn diameter at the middle
horn_z = 38;              // horn axis height
end_drop = 10;            // how far the horn tips drop
post_d = 9;               // centre post diameter
holes_d = 6.35;           // fixing holes
hole_x = 30;              // fixing hole spacing

difference() {
  union() {
    translate([-40, -13, 0]) cube([base_l, base_w, base_t]);
    /* centre post, sunk 1 mm into the base */
    translate([0, 0, 7]) cylinder(h = 31, d = post_d);
    /* horn: a hull chain of boxes, full in the middle and lighter at the tips */
    hull() {
      translate([-34, -4.05, 29]) cube([0.4, 8.1, 8.1], center = false);
      translate([-21.76, -7.2, 29]) cube([0.4, 14.4, 15.5], center = false);
    }
    hull() {
      translate([-21.76, -7.2, 29]) cube([0.4, 14.4, 15.5], center = false);
      translate([0, -9, 29]) cube([0.4, 18, 18], center = false);
    }
    hull() {
      translate([0, -9, 29]) cube([0.4, 18, 18], center = false);
      translate([21.76, -7.2, 29]) cube([0.4, 14.4, 15.5], center = false);
    }
    hull() {
      translate([21.76, -7.2, 29]) cube([0.4, 14.4, 15.5], center = false);
      translate([34, -4.05, 29]) cube([0.4, 8.1, 8.1], center = false);
    }
  }
  translate([-30, 0, -2.5]) cylinder(h = base_t + 5, d = holes_d);
  translate([30, 0, -2.5]) cylinder(h = base_t + 5, d = holes_d);
}
