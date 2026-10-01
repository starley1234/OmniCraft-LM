$fn = 32;

// ----------------------------------------------------------------------
// Mixed field: bosses and holes at given coordinates
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 110;            // plate length, X
plate_w = 80;             // plate width, Y
plate_t = 6;              // plate thickness, Z
boss_d = 12;              // boss diameter
boss_h = 6;               // boss height above the plate
hole_d = 5;               // through hole diameter
fit_tol = 0.02;           // tolerance for press fits, mm
free_tol = 0.2;           // tolerance for clearance fits, mm

total_h = plate_t + boss_h;  // overall height

difference() {
  union() {
    cube([plate_l, plate_w, plate_t]);
    translate([45, 35, plate_t]) cylinder(h = boss_h, d = boss_d);
    translate([95, 65, plate_t]) cylinder(h = boss_h, d = boss_d);
  }
  translate([45, 35, -1]) cylinder(h = total_h + 2, d = boss_d / 2);
  translate([95, 65, -1]) cylinder(h = total_h + 2, d = boss_d / 2);
  translate([45, 55, -1]) cylinder(h = plate_t + 2, d = hole_d);
  translate([85, 35, -1]) cylinder(h = plate_t + 2, d = hole_d);
}
