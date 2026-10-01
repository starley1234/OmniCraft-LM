$fn = 32;

// ----------------------------------------------------------------------
// Spur blank: lightened gear blank
// ----------------------------------------------------------------------

// --- parameters (mm) ---
disc_r = 22;              // blank root radius
disc_t = 14;              // blank thickness
n_teeth = 16;             // stub tooth count
tooth_w = 6;              // tooth width at the root
tooth_h = 3;              // tooth height above the root
bore_r = 6;               // central bore radius
ring_r = 12;              // lightening pocket ring radius
pocket_r = 3.5;           // lightening pocket radius

out_r = disc_r + tooth_h;  // tip radius
bbox_x = 50.0;  // measured width over the teeth
bbox_y = 50.0;  // measured depth over the teeth

difference() {
union() {
  cylinder(r = disc_r, h = disc_t);
  for (i = [0 : n_teeth - 1])
    rotate([0, 0, i * 360 / n_teeth])
      translate([disc_r - 1, -tooth_w / 2, 0])
        cube([tooth_h + 1, tooth_w, disc_t]);
}
  translate([0, 0, -1]) cylinder(r = bore_r, h = disc_t + 2);
  for (i = [0 : 5])
    rotate([0, 0, i * 72])
      translate([ring_r, 0, disc_t - 4])
        cylinder(r = pocket_r, h = 5);
}
