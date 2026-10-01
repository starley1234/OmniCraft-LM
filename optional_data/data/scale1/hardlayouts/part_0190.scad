$fn = 32;

// ----------------------------------------------------------------------
// Boss field: plate with bosses at given coordinates
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 120;            // plate length, X
plate_w = 80;             // plate width, Y
plate_t = 6;              // plate thickness, Z
boss_d = 10;              // boss diameter
boss_h = 8;               // boss height above the plate
bore_d = 3;               // boss bore
fit_tol = 0.02;           // tolerance for press fits, mm
free_tol = 0.2;           // tolerance for clearance fits, mm

total_h = plate_t + boss_h;  // overall height

difference() {
  union() {
    cube([plate_l, plate_w, plate_t]);
    translate([15, 65, plate_t]) cylinder(h = boss_h, d = boss_d);
    translate([25, 25, plate_t]) cylinder(h = boss_h, d = boss_d);
    translate([35, 15, plate_t]) cylinder(h = boss_h, d = boss_d);
  }
  translate([15, 65, -1]) cylinder(h = total_h + 2, d = bore_d);
  translate([25, 25, -1]) cylinder(h = total_h + 2, d = bore_d);
  translate([35, 15, -1]) cylinder(h = total_h + 2, d = bore_d);
}
