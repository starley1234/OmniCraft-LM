$fn = 32;

// ----------------------------------------------------------------------
// Boss field: plate with bosses at given coordinates
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 120;            // plate length, X
plate_w = 70;             // plate width, Y
plate_t = 5;              // plate thickness, Z
boss_d = 12;              // boss diameter
boss_h = 8;               // boss height above the plate
bore_d = 3;               // boss bore

total_h = plate_t + boss_h;  // overall height

difference() {
  union() {
    cube([plate_l, plate_w, plate_t]);
    translate([25, 15, plate_t]) cylinder(h = boss_h, d = boss_d);
    translate([45, 55, plate_t]) cylinder(h = boss_h, d = boss_d);
    translate([85, 35, plate_t]) cylinder(h = boss_h, d = boss_d);
  }
  translate([25, 15, -1]) cylinder(h = total_h + 2, d = bore_d);
  translate([45, 55, -1]) cylinder(h = total_h + 2, d = bore_d);
  translate([85, 35, -1]) cylinder(h = total_h + 2, d = bore_d);
}
