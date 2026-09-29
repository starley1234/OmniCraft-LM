$fn = 32;

// ----------------------------------------------------------------------
// Boat cleat: 80 mm base, horn 44 mm up
// ----------------------------------------------------------------------

// --- parameters (mm) ---
base_l = 80;              // base length
base_w = 26;              // base width
base_t = 8;               // base thickness
horn_len = 68;            // horn length
horn_d = 22;              // horn diameter at the middle
horn_z = 44;              // horn axis height
end_drop = 10;            // how far the horn tips drop
post_d = 11;              // centre post diameter
holes_d = 7.94;           // fixing holes
hole_x = 28;              // fixing hole spacing

difference() {
  union() {
    translate([-40, -13, 0]) cube([base_l, base_w, base_t]);
    /* centre post, sunk 1 mm into the base */
    translate([0, 0, 7]) cylinder(h = 37, d = post_d);
    /* horn: a hull chain of boxes, full in the middle and lighter at the tips */
    hull() {
      translate([-34, -4.95, 33]) cube([0.4, 9.9, 12], center = false);
      translate([-21.76, -8.8, 33]) cube([0.4, 17.6, 19.5], center = false);
    }
    hull() {
      translate([-21.76, -8.8, 33]) cube([0.4, 17.6, 19.5], center = false);
      translate([0, -11, 33]) cube([0.4, 22, 22], center = false);
    }
    hull() {
      translate([0, -11, 33]) cube([0.4, 22, 22], center = false);
      translate([21.76, -8.8, 33]) cube([0.4, 17.6, 19.5], center = false);
    }
    hull() {
      translate([21.76, -8.8, 33]) cube([0.4, 17.6, 19.5], center = false);
      translate([34, -4.95, 33]) cube([0.4, 9.9, 12], center = false);
    }
  }
  translate([-28, 0, -2.5]) cylinder(h = base_t + 5, d = holes_d);
  translate([28, 0, -2.5]) cylinder(h = base_t + 5, d = holes_d);
}
