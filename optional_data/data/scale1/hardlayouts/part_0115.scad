$fn = 32;

// ----------------------------------------------------------------------
// Boss field: plate with bosses at given coordinates
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 120;            // plate length, X
plate_w = 70;             // plate width, Y
plate_t = 6;              // plate thickness, Z
boss_d = 10;              // boss diameter
boss_h = 6;               // boss height above the plate
bore_d = 4;               // boss bore

total_h = plate_t + boss_h;  // overall height

difference() {
  union() {
    cube([plate_l, plate_w, plate_t]);
    translate([15, 15, plate_t]) cylinder(h = boss_h, d = boss_d);
    translate([55, 25, plate_t]) cylinder(h = boss_h, d = boss_d);
    translate([105, 25, plate_t]) cylinder(h = boss_h, d = boss_d);
  }
  translate([15, 15, -1]) cylinder(h = total_h + 2, d = bore_d);
  translate([55, 25, -1]) cylinder(h = total_h + 2, d = bore_d);
  translate([105, 25, -1]) cylinder(h = total_h + 2, d = bore_d);
}
