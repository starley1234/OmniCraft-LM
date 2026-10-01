$fn = 32;

// ----------------------------------------------------------------------
// Control knob: skirt knob with grip ribs
// ----------------------------------------------------------------------

// --- parameters (mm) ---
skirt_d = 42;             // skirt diameter
skirt_t = 5;              // skirt thickness
rib_w = 5;                // grip rib width
rib_out = 3;              // grip rib radial protrusion
n_ribs = 10;              // number of grip ribs
knob_d = 30;              // knob body diameter
knob_h = 18;              // knob body height
bore_d = 4;               // shaft bore diameter
set_d = 3;                // set screw bore diameter
fit_tol = 0.1;            // tolerance for press fits, mm
free_tol = 0.3;           // tolerance for clearance fits, mm

rib_step = 360 / n_ribs;  // rib angular step
total_h = skirt_t + knob_h;  // overall height

difference() {
  union() {
    translate([0, 0, skirt_t]) cylinder(h = knob_h, d = knob_d);
    cylinder(h = skirt_t, d = skirt_d);
    for (i = [0 : n_ribs - 1])
      rotate([0, 0, i * rib_step])
        translate([knob_d / 2 - 1, -rib_w / 2, skirt_t])
          cube([rib_out, rib_w, knob_h]);
  }
  translate([0, 0, skirt_t - 1]) cylinder(h = knob_h + 2, d = bore_d);
  translate([-1, 0, skirt_t + knob_h / 2]) rotate([0, 90, 0])
    cylinder(h = knob_d / 2 + bore_d / 2 + 2, d = set_d);
}
