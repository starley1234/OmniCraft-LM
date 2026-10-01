$fn = 32;

// ----------------------------------------------------------------------
// Spur blank: bored gear blank
// ----------------------------------------------------------------------

// --- parameters (mm) ---
disc_r = 22;              // blank root radius
disc_t = 12;              // blank thickness
n_teeth = 18;             // stub tooth count
tooth_w = 4;              // tooth width at the root
tooth_h = 5;              // tooth height above the root
bore_r = 5;               // central bore radius

out_r = disc_r + tooth_h;  // tip radius
bbox_x = 54.0;  // measured width over the teeth
bbox_y = 53.87;  // measured depth over the teeth

difference() {
union() {
  cylinder(r = disc_r, h = disc_t);
  for (i = [0 : n_teeth - 1])
    rotate([0, 0, i * 360 / n_teeth])
      translate([disc_r - 1, -tooth_w / 2, 0])
        cube([tooth_h + 1, tooth_w, disc_t]);
}
  translate([0, 0, -1]) cylinder(r = bore_r, h = disc_t + 2);
}
