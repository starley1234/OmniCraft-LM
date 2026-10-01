$fn = 32;

// ----------------------------------------------------------------------
// Mixed field: bosses and holes at given coordinates
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 120;            // plate length, X
plate_w = 80;             // plate width, Y
plate_t = 6;              // plate thickness, Z
boss_d = 12;              // boss diameter
boss_h = 8;               // boss height above the plate
hole_d = 6;               // through hole diameter
fit_tol = 0.1;            // tolerance for press fits, mm
free_tol = 0.5;           // tolerance for clearance fits, mm

total_h = plate_t + boss_h;  // overall height

difference() {
  union() {
    cube([plate_l, plate_w, plate_t]);
    translate([85, 15, plate_t]) cylinder(h = boss_h, d = boss_d);
    translate([95, 45, plate_t]) cylinder(h = boss_h, d = boss_d);
  }
  translate([85, 15, -1]) cylinder(h = total_h + 2, d = boss_d / 2);
  translate([95, 45, -1]) cylinder(h = total_h + 2, d = boss_d / 2);
  translate([25, 35, -1]) cylinder(h = plate_t + 2, d = hole_d);
  translate([25, 55, -1]) cylinder(h = plate_t + 2, d = hole_d);
  translate([35, 15, -1]) cylinder(h = plate_t + 2, d = hole_d);
}
