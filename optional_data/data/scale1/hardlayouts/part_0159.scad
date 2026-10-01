$fn = 32;

// ----------------------------------------------------------------------
// Boss field: plate with bosses at given coordinates
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 120;            // plate length, X
plate_w = 80;             // plate width, Y
plate_t = 6;              // plate thickness, Z
boss_d = 12;              // boss diameter
boss_h = 8;               // boss height above the plate
bore_d = 4;               // boss bore
fit_tol = 0.1;            // tolerance for press fits, mm
free_tol = 0.3;           // tolerance for clearance fits, mm

total_h = plate_t + boss_h;  // overall height

difference() {
  union() {
    cube([plate_l, plate_w, plate_t]);
    translate([25, 55, plate_t]) cylinder(h = boss_h, d = boss_d);
    translate([45, 55, plate_t]) cylinder(h = boss_h, d = boss_d);
    translate([65, 55, plate_t]) cylinder(h = boss_h, d = boss_d);
    translate([75, 15, plate_t]) cylinder(h = boss_h, d = boss_d);
    translate([95, 45, plate_t]) cylinder(h = boss_h, d = boss_d);
  }
  translate([25, 55, -1]) cylinder(h = total_h + 2, d = bore_d);
  translate([45, 55, -1]) cylinder(h = total_h + 2, d = bore_d);
  translate([65, 55, -1]) cylinder(h = total_h + 2, d = bore_d);
  translate([75, 15, -1]) cylinder(h = total_h + 2, d = bore_d);
  translate([95, 45, -1]) cylinder(h = total_h + 2, d = bore_d);
}
