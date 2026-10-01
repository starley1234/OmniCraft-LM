$fn = 32;

// ----------------------------------------------------------------------
// Open box: 1.5 mm walls
// ----------------------------------------------------------------------

// --- parameters (mm) ---
box_l = 70;               // outer length, X
box_w = 60;               // outer width, Y
box_h = 20;               // outer height, Z
wall = 1.5;               // wall thickness
floor = 2;                // floor thickness

difference() {
  cube([box_l, box_w, box_h]);
  translate([wall, wall, floor])
    cube([box_l - 2 * wall, box_w - 2 * wall, box_h]);
}
