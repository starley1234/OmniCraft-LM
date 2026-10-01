$fn = 32;

// ----------------------------------------------------------------------
// Boss field: plate with bosses at given coordinates
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 110;            // plate length, X
plate_w = 50;             // plate width, Y
plate_t = 4;              // plate thickness, Z
boss_d = 12;              // boss diameter
boss_h = 6;               // boss height above the plate
bore_d = 4;               // boss bore
fit_tol = 0.05;           // tolerance for press fits, mm
free_tol = 0.2;           // tolerance for clearance fits, mm

total_h = plate_t + boss_h;  // overall height

difference() {
  union() {
    cube([plate_l, plate_w, plate_t]);
    translate([45, 35, plate_t]) cylinder(h = boss_h, d = boss_d);
    translate([55, 35, plate_t]) cylinder(h = boss_h, d = boss_d);
    translate([75, 25, plate_t]) cylinder(h = boss_h, d = boss_d);
    translate([75, 35, plate_t]) cylinder(h = boss_h, d = boss_d);
  }
  translate([45, 35, -1]) cylinder(h = total_h + 2, d = bore_d);
  translate([55, 35, -1]) cylinder(h = total_h + 2, d = bore_d);
  translate([75, 25, -1]) cylinder(h = total_h + 2, d = bore_d);
  translate([75, 35, -1]) cylinder(h = total_h + 2, d = bore_d);
}
