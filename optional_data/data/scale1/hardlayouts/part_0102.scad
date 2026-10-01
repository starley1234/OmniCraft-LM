$fn = 32;

// ----------------------------------------------------------------------
// Mixed field: bosses and holes at given coordinates
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 80;             // plate length, X
plate_w = 60;             // plate width, Y
plate_t = 4;              // plate thickness, Z
boss_d = 12;              // boss diameter
boss_h = 6;               // boss height above the plate
hole_d = 6;               // through hole diameter

total_h = plate_t + boss_h;  // overall height

difference() {
  union() {
    cube([plate_l, plate_w, plate_t]);
    translate([45, 15, plate_t]) cylinder(h = boss_h, d = boss_d);
    translate([55, 25, plate_t]) cylinder(h = boss_h, d = boss_d);
  }
  translate([45, 15, -1]) cylinder(h = total_h + 2, d = boss_d / 2);
  translate([55, 25, -1]) cylinder(h = total_h + 2, d = boss_d / 2);
  translate([15, 25, -1]) cylinder(h = plate_t + 2, d = hole_d);
  translate([25, 15, -1]) cylinder(h = plate_t + 2, d = hole_d);
  translate([55, 45, -1]) cylinder(h = plate_t + 2, d = hole_d);
}
