$fn = 32;

// ----------------------------------------------------------------------
// Long rail: 200-250 mm mounting rail
// ----------------------------------------------------------------------

// --- parameters (mm) ---
rail_l = 230;             // rail length, X
rail_w = 25;              // rail width, Y
rail_t = 12;              // rail thickness, Z
hole_d = 5;               // mounting hole diameter
hole_start = 30;          // first hole offset from the end
hole_pitch = 50;          // hole pitch
holes = 4;                // number of holes
fit_tol = 0.1;            // tolerance for press fits, mm
free_tol = 0.5;           // tolerance for clearance fits, mm

difference() {
  cube([rail_l, rail_w, rail_t]);
  for (i = [0 : holes - 1])
    translate([hole_start + i * hole_pitch, rail_w / 2, -1])
      cylinder(h = rail_t + 2, d = hole_d);
}
