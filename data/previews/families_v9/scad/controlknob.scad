$fn = 32;
// target_bbox: 35, 35, 24
// ----------------------------------------------------------------------
// Control knob: pointer knob
// ----------------------------------------------------------------------

// --- parameters (mm) ---
rib_w = 3;                // pointer rib width
rib_h = 5;                // pointer rib height
knob_d = 35;              // knob body diameter
knob_h = 20;              // knob body height
bore_d = 5;               // shaft bore diameter
set_d = 3.5;              // set screw bore diameter

rib_poke = rib_h - 1;  // rib height above the top
total_h = knob_h + rib_h - 1;  // overall height

difference() {
  union() {
    cylinder(h = knob_h, d = knob_d);
    translate([-rib_w / 2, 0, knob_h - 1])
      cube([rib_w, knob_d / 2 - 2, rib_h]);
  }
  translate([0, 0, -1]) cylinder(h = knob_h + 2, d = bore_d);
  translate([-1, 0, knob_h / 2]) rotate([0, 90, 0])
    cylinder(h = knob_d / 2 + bore_d / 2 + 2, d = set_d);}
