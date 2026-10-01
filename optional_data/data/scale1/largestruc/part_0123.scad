$fn = 32;

// ----------------------------------------------------------------------
// Long rail: 200-250 mm mounting rail
// ----------------------------------------------------------------------

// --- parameters (mm) ---
rail_l = 210;             // rail length, X
rail_w = 30;              // rail width, Y
rail_t = 10;              // rail thickness, Z
hole_d = 6;               // mounting hole diameter
hole_start = 30;          // first hole offset from the end
hole_pitch = 40;          // hole pitch
holes = 4;                // number of holes

difference() {
  cube([rail_l, rail_w, rail_t]);
  for (i = [0 : holes - 1])
    translate([hole_start + i * hole_pitch, rail_w / 2, -1])
      cylinder(h = rail_t + 2, d = hole_d);
}
