$fn = 32;

// ----------------------------------------------------------------------
// Boat cleat: 70 mm base, horn 42 mm up
// ----------------------------------------------------------------------

// --- parameters (mm) ---
base_l = 70;              // base length
base_w = 34;              // base width
base_t = 6;               // base thickness
horn_len = 59.5;          // horn length
horn_d = 18;              // horn diameter at the middle
horn_z = 42;              // horn axis height
end_drop = 10;            // how far the horn tips drop
post_d = 10.8;            // centre post diameter
holes_d = 6.35;           // fixing holes
hole_x = 23;              // fixing hole spacing

difference() {
  union() {
    translate([-35, -17, 0]) cube([base_l, base_w, base_t]);
    /* centre post, sunk 1 mm into the base */
    translate([0, 0, 5]) cylinder(h = 37, d = post_d);
    /* horn: a hull chain of boxes, full in the middle and lighter at the tips */
    hull() {
      translate([-29.75, -4.05, 33]) cube([0.4, 8.1, 8.1], center = false);
      translate([-19.04, -7.2, 33]) cube([0.4, 14.4, 15.5], center = false);
    }
    hull() {
      translate([-19.04, -7.2, 33]) cube([0.4, 14.4, 15.5], center = false);
      translate([0, -9, 33]) cube([0.4, 18, 18], center = false);
    }
    hull() {
      translate([0, -9, 33]) cube([0.4, 18, 18], center = false);
      translate([19.04, -7.2, 33]) cube([0.4, 14.4, 15.5], center = false);
    }
    hull() {
      translate([19.04, -7.2, 33]) cube([0.4, 14.4, 15.5], center = false);
      translate([29.75, -4.05, 33]) cube([0.4, 8.1, 8.1], center = false);
    }
  }
  translate([-23, 0, -2.5]) cylinder(h = base_t + 5, d = holes_d);
  translate([23, 0, -2.5]) cylinder(h = base_t + 5, d = holes_d);
}
