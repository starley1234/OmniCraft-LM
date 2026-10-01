$fn = 32;

// ----------------------------------------------------------------------
// Vent box: louvers enclosure
// ----------------------------------------------------------------------

// --- parameters (mm) ---
box_l = 110;              // box length, X
box_w = 70;               // box width, Y
box_h = 45;               // box height, Z
wall_t = 2.5;             // shell wall thickness
win_l = 50;               // vent window width, X
win_h = 32;               // vent window height, Z
slat_t = 2.5;             // louver slat thickness
slat_d = 8;               // louver slat depth
slat_a = 45;              // louver slat angle, degrees
slat_pitch = 10;          // louver pitch
slat_yc = 64.79;          // slat centreline Y
fit_tol = 0.1;            // tolerance for press fits, mm
free_tol = 0.3;           // tolerance for clearance fits, mm

win_z0 = (box_h - win_h) / 2;  // window lower edge Z
n_slats = 3;  // louver count
slat_z0 = win_z0 + (win_h - (n_slats - 1) * slat_pitch) / 2;

difference() {
  union() {
    difference() {
      cube([box_l, box_w, box_h]);
  translate([wall_t, wall_t, wall_t])
    cube([box_l - 2 * wall_t, box_w - 2 * wall_t, box_h]);
  translate([(box_l - win_l) / 2, box_w - wall_t - 1, win_z0])
    cube([win_l, wall_t + 2, win_h]);
    }
    for (i = [0 : n_slats - 1])
      translate([box_l / 2, slat_yc, slat_z0 + i * slat_pitch])
        rotate([slat_a, 0, 0])
          cube([win_l + 1, slat_d, slat_t], center = true);
  }
}
