$fn = 32;

// ----------------------------------------------------------------------
// Thin tube: 1.4 mm wall
// ----------------------------------------------------------------------

// --- parameters (mm) ---
tube_od = 50;             // outer diameter
tube_h = 30;              // height, Z
wall = 1.4;               // wall thickness

difference() {
  cylinder(h = tube_h, d = tube_od);
  translate([0, 0, -1]) cylinder(h = tube_h + 2, d = tube_od - 2 * wall);
}
