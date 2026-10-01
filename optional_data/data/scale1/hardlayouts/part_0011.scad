$fn = 32;

// ----------------------------------------------------------------------
// Boss field: plate with bosses at given coordinates
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 110;            // plate length, X
plate_w = 50;             // plate width, Y
plate_t = 5;              // plate thickness, Z
boss_d = 12;              // boss diameter
boss_h = 5;               // boss height above the plate
bore_d = 4;               // boss bore

total_h = plate_t + boss_h;  // overall height

difference() {
  union() {
    cube([plate_l, plate_w, plate_t]);
    translate([25, 35, plate_t]) cylinder(h = boss_h, d = boss_d);
    translate([35, 15, plate_t]) cylinder(h = boss_h, d = boss_d);
    translate([35, 25, plate_t]) cylinder(h = boss_h, d = boss_d);
    translate([45, 25, plate_t]) cylinder(h = boss_h, d = boss_d);
  }
  translate([25, 35, -1]) cylinder(h = total_h + 2, d = bore_d);
  translate([35, 15, -1]) cylinder(h = total_h + 2, d = bore_d);
  translate([35, 25, -1]) cylinder(h = total_h + 2, d = bore_d);
  translate([45, 25, -1]) cylinder(h = total_h + 2, d = bore_d);
}
