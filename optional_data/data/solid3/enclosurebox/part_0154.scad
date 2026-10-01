$fn = 32;

// ----------------------------------------------------------------------
// Enclosure box: notch enclosure
// ----------------------------------------------------------------------

// --- parameters (mm) ---
box_l = 90;               // outer length, X
box_w = 70;               // outer width, Y
box_h = 40;               // outer height
wall_t = 2.5;             // wall thickness
notch_w = 8;              // cable notch width
notch_h = 12;             // cable notch height

inner_h = box_h - wall_t;  // cavity depth
boss_h = inner_h - 2;  // corner boss height

difference() {
  union() {
    difference() {
      cube([box_l, box_w, box_h]);
      translate([wall_t, wall_t, wall_t])
        cube([box_l - 2 * wall_t, box_w - 2 * wall_t, box_h]);
    }
  }
  translate([box_l / 2 - notch_w / 2, -1, box_h - notch_h])
    cube([notch_w, wall_t + 2, notch_h + 1]);
}
