$fn = 32;

// ----------------------------------------------------------------------
// Long rail: 200-250 mm mounting rail
// ----------------------------------------------------------------------

// --- parameters (mm) ---
rail_l = 250;             // rail length, X
rail_w = 25;              // rail width, Y
rail_t = 12;              // rail thickness, Z
hole_d = 5;               // mounting hole diameter
hole_start = 25;          // first hole offset from the end
hole_pitch = 45;          // hole pitch
holes = 5;                // number of holes

difference() {
  cube([rail_l, rail_w, rail_t]);
  for (i = [0 : holes - 1])
    translate([hole_start + i * hole_pitch, rail_w / 2, -1])
      cylinder(h = rail_t + 2, d = hole_d);
}
