$fn = 32;

// ----------------------------------------------------------------------
// Thin tube: 1.2 mm wall
// ----------------------------------------------------------------------

// --- parameters (mm) ---
tube_od = 60;             // outer diameter
tube_h = 60;              // height, Z
wall = 1.2;               // wall thickness

difference() {
  cylinder(h = tube_h, d = tube_od);
  translate([0, 0, -1]) cylinder(h = tube_h + 2, d = tube_od - 2 * wall);
}
