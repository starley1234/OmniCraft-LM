$fn = 32;

// ----------------------------------------------------------------------
// Boat cleat: 90 mm base, horn 34 mm up
// ----------------------------------------------------------------------

// --- parameters (mm) ---
base_l = 90;              // base length
base_w = 34;              // base width
base_t = 10;              // base thickness
horn_len = 85.5;          // horn length
horn_d = 18;              // horn diameter at the middle
horn_z = 34;              // horn axis height
end_drop = 8;             // how far the horn tips drop
post_d = 10.8;            // centre post diameter
holes_d = 7.94;           // fixing holes
hole_x = 35;              // fixing hole spacing

difference() {
  union() {
    translate([-45, -17, 0]) cube([base_l, base_w, base_t]);
    /* centre post, sunk 1 mm into the base */
    translate([0, 0, 9]) cylinder(h = 25, d = post_d);
    /* horn: a hull chain of boxes, full in the middle and lighter at the tips */
    hull() {
      translate([-42.75, -4.05, 25]) cube([0.4, 8.1, 10], center = false);
      translate([-27.36, -7.2, 25]) cube([0.4, 14.4, 16], center = false);
    }
    hull() {
      translate([-27.36, -7.2, 25]) cube([0.4, 14.4, 16], center = false);
      translate([0, -9, 25]) cube([0.4, 18, 18], center = false);
    }
    hull() {
      translate([0, -9, 25]) cube([0.4, 18, 18], center = false);
      translate([27.36, -7.2, 25]) cube([0.4, 14.4, 16], center = false);
    }
    hull() {
      translate([27.36, -7.2, 25]) cube([0.4, 14.4, 16], center = false);
      translate([42.75, -4.05, 25]) cube([0.4, 8.1, 10], center = false);
    }
  }
  translate([-35, 0, -2.5]) cylinder(h = base_t + 5, d = holes_d);
  translate([35, 0, -2.5]) cylinder(h = base_t + 5, d = holes_d);
}
