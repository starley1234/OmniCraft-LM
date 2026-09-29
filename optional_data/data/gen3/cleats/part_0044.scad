$fn = 32;

// ----------------------------------------------------------------------
// Boat cleat: 80 mm base, horn 38 mm up
// ----------------------------------------------------------------------

// --- parameters (mm) ---
base_l = 80;              // base length
base_w = 34;              // base width
base_t = 8;               // base thickness
horn_len = 76;            // horn length
horn_d = 14;              // horn diameter at the middle
horn_z = 38;              // horn axis height
end_drop = 8;             // how far the horn tips drop
post_d = 8.4;             // centre post diameter
holes_d = 7.94;           // fixing holes
hole_x = 28;              // fixing hole spacing

difference() {
  union() {
    translate([-40, -17, 0]) cube([base_l, base_w, base_t]);
    /* centre post, sunk 1 mm into the base */
    translate([0, 0, 7]) cylinder(h = 31, d = post_d);
    /* horn: a hull chain of boxes, full in the middle and lighter at the tips */
    hull() {
      translate([-38, -3.15, 31]) cube([0.4, 6.3, 6.3], center = false);
      translate([-24.32, -5.6, 31]) cube([0.4, 11.2, 12], center = false);
    }
    hull() {
      translate([-24.32, -5.6, 31]) cube([0.4, 11.2, 12], center = false);
      translate([0, -7, 31]) cube([0.4, 14, 14], center = false);
    }
    hull() {
      translate([0, -7, 31]) cube([0.4, 14, 14], center = false);
      translate([24.32, -5.6, 31]) cube([0.4, 11.2, 12], center = false);
    }
    hull() {
      translate([24.32, -5.6, 31]) cube([0.4, 11.2, 12], center = false);
      translate([38, -3.15, 31]) cube([0.4, 6.3, 6.3], center = false);
    }
  }
  translate([-28, 0, -2.5]) cylinder(h = base_t + 5, d = holes_d);
  translate([28, 0, -2.5]) cylinder(h = base_t + 5, d = holes_d);
}
