$fn = 32;

// ----------------------------------------------------------------------
// Thin tube: 1.3 mm wall
// ----------------------------------------------------------------------

// --- parameters (mm) ---
tube_od = 60;             // outer diameter
tube_h = 20;              // height, Z
wall = 1.3;               // wall thickness
fit_tol = 0.05;           // tolerance for press fits, mm
free_tol = 0.2;           // tolerance for clearance fits, mm

difference() {
  cylinder(h = tube_h, d = tube_od);
  translate([0, 0, -1]) cylinder(h = tube_h + 2, d = tube_od - 2 * wall);
}
