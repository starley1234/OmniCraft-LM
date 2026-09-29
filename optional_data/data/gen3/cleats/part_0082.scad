$fn = 32;

// ----------------------------------------------------------------------
// Boat cleat: 70 mm base, horn 34 mm up
// ----------------------------------------------------------------------

// --- parameters (mm) ---
base_l = 70;              // base length
base_w = 26;              // base width
base_t = 10;              // base thickness
horn_len = 59.5;          // horn length
horn_d = 14;              // horn diameter at the middle
horn_z = 34;              // horn axis height
end_drop = 8;             // how far the horn tips drop
post_d = 8.4;             // centre post diameter
holes_d = 6.35;           // fixing holes
hole_x = 23;              // fixing hole spacing

difference() {
  union() {
    translate([-35, -13, 0]) cube([base_l, base_w, base_t]);
    /* centre post, sunk 1 mm into the base */
    translate([0, 0, 9]) cylinder(h = 25, d = post_d);
    /* horn: a hull chain of boxes, full in the middle and lighter at the tips */
    hull() {
      translate([-29.75, -3.15, 27]) cube([0.4, 6.3, 6.3], center = false);
      translate([-19.04, -5.6, 27]) cube([0.4, 11.2, 12], center = false);
    }
    hull() {
      translate([-19.04, -5.6, 27]) cube([0.4, 11.2, 12], center = false);
      translate([0, -7, 27]) cube([0.4, 14, 14], center = false);
    }
    hull() {
      translate([0, -7, 27]) cube([0.4, 14, 14], center = false);
      translate([19.04, -5.6, 27]) cube([0.4, 11.2, 12], center = false);
    }
    hull() {
      translate([19.04, -5.6, 27]) cube([0.4, 11.2, 12], center = false);
      translate([29.75, -3.15, 27]) cube([0.4, 6.3, 6.3], center = false);
    }
  }
  translate([-23, 0, -2.5]) cylinder(h = base_t + 5, d = holes_d);
  translate([23, 0, -2.5]) cylinder(h = base_t + 5, d = holes_d);
}
