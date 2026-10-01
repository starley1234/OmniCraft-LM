$fn = 32;

// ----------------------------------------------------------------------
// Boss field: plate with bosses at given coordinates
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 120;            // plate length, X
plate_w = 50;             // plate width, Y
plate_t = 5;              // plate thickness, Z
boss_d = 10;              // boss diameter
boss_h = 5;               // boss height above the plate
bore_d = 3;               // boss bore

total_h = plate_t + boss_h;  // overall height

difference() {
  union() {
    cube([plate_l, plate_w, plate_t]);
    translate([45, 25, plate_t]) cylinder(h = boss_h, d = boss_d);
    translate([55, 15, plate_t]) cylinder(h = boss_h, d = boss_d);
    translate([85, 15, plate_t]) cylinder(h = boss_h, d = boss_d);
    translate([95, 15, plate_t]) cylinder(h = boss_h, d = boss_d);
    translate([95, 25, plate_t]) cylinder(h = boss_h, d = boss_d);
  }
  translate([45, 25, -1]) cylinder(h = total_h + 2, d = bore_d);
  translate([55, 15, -1]) cylinder(h = total_h + 2, d = bore_d);
  translate([85, 15, -1]) cylinder(h = total_h + 2, d = bore_d);
  translate([95, 15, -1]) cylinder(h = total_h + 2, d = bore_d);
  translate([95, 25, -1]) cylinder(h = total_h + 2, d = bore_d);
}
