$fn = 32;

// ----------------------------------------------------------------------
// Control knob: dimpled knob
// ----------------------------------------------------------------------

// --- parameters (mm) ---
dimp_d = 4;               // finger dimple diameter
n_dimp = 5;               // number of dimples
dimp_r = 16;              // dimple ring radius
knob_d = 40;              // knob body diameter
knob_h = 16;              // knob body height
bore_d = 6;               // shaft bore diameter
set_d = 3;                // set screw bore diameter

dimp_step = 360 / n_dimp;  // dimple angular step

difference() {
  cylinder(h = knob_h, d = knob_d);
  translate([0, 0, -1]) cylinder(h = knob_h + 2, d = bore_d);
  translate([-1, 0, knob_h / 2]) rotate([0, 90, 0])
    cylinder(h = knob_d / 2 + bore_d / 2 + 2, d = set_d);  for (i = [0 : n_dimp - 1])
    rotate([0, 0, i * dimp_step])
      translate([dimp_r, 0, knob_h - 1])
        cylinder(h = 2, d = dimp_d);
}
