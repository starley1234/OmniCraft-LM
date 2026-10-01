$fn = 32;

// ----------------------------------------------------------------------
// Open box: 1.4 mm walls
// ----------------------------------------------------------------------

// --- parameters (mm) ---
box_l = 80;               // outer length, X
box_w = 50;               // outer width, Y
box_h = 40;               // outer height, Z
wall = 1.4;               // wall thickness
floor = 1.5;              // floor thickness
fit_tol = 0.1;            // tolerance for press fits, mm
free_tol = 0.3;           // tolerance for clearance fits, mm

difference() {
  cube([box_l, box_w, box_h]);
  translate([wall, wall, floor])
    cube([box_l - 2 * wall, box_w - 2 * wall, box_h]);
}
