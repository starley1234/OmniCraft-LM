$fn = 32;

// ----------------------------------------------------------------------
// Boss field: plate with bosses at given coordinates
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 80;             // plate length, X
plate_w = 80;             // plate width, Y
plate_t = 5;              // plate thickness, Z
boss_d = 12;              // boss diameter
boss_h = 6;               // boss height above the plate
bore_d = 3;               // boss bore

total_h = plate_t + boss_h;  // overall height

difference() {
  union() {
    cube([plate_l, plate_w, plate_t]);
    translate([25, 15, plate_t]) cylinder(h = boss_h, d = boss_d);
    translate([35, 65, plate_t]) cylinder(h = boss_h, d = boss_d);
    translate([45, 25, plate_t]) cylinder(h = boss_h, d = boss_d);
    translate([55, 45, plate_t]) cylinder(h = boss_h, d = boss_d);
  }
  translate([25, 15, -1]) cylinder(h = total_h + 2, d = bore_d);
  translate([35, 65, -1]) cylinder(h = total_h + 2, d = bore_d);
  translate([45, 25, -1]) cylinder(h = total_h + 2, d = bore_d);
  translate([55, 45, -1]) cylinder(h = total_h + 2, d = bore_d);
}
