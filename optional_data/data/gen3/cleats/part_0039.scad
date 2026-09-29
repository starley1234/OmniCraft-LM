$fn = 32;

// ----------------------------------------------------------------------
// Boat cleat: 70 mm base, horn 32 mm up
// ----------------------------------------------------------------------

// --- parameters (mm) ---
base_l = 70;              // base length
base_w = 30;              // base width
base_t = 8;               // base thickness
horn_len = 66.5;          // horn length
horn_d = 18;              // horn diameter at the middle
horn_z = 32;              // horn axis height
end_drop = 6;             // how far the horn tips drop
post_d = 10.8;            // centre post diameter
holes_d = 6.35;           // fixing holes
hole_x = 23;              // fixing hole spacing

difference() {
  union() {
    translate([-35, -15, 0]) cube([base_l, base_w, base_t]);
    /* centre post, sunk 1 mm into the base */
    translate([0, 0, 7]) cylinder(h = 25, d = post_d);
    /* horn: a hull chain of boxes, full in the middle and lighter at the tips */
    hull() {
      translate([-33.25, -4.05, 23]) cube([0.4, 8.1, 12], center = false);
      translate([-21.28, -7.2, 23]) cube([0.4, 14.4, 16.5], center = false);
    }
    hull() {
      translate([-21.28, -7.2, 23]) cube([0.4, 14.4, 16.5], center = false);
      translate([0, -9, 23]) cube([0.4, 18, 18], center = false);
    }
    hull() {
      translate([0, -9, 23]) cube([0.4, 18, 18], center = false);
      translate([21.28, -7.2, 23]) cube([0.4, 14.4, 16.5], center = false);
    }
    hull() {
      translate([21.28, -7.2, 23]) cube([0.4, 14.4, 16.5], center = false);
      translate([33.25, -4.05, 23]) cube([0.4, 8.1, 12], center = false);
    }
  }
  translate([-23, 0, -2.5]) cylinder(h = base_t + 5, d = holes_d);
  translate([23, 0, -2.5]) cylinder(h = base_t + 5, d = holes_d);
}
