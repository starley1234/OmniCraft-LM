$fn = 32;

// ----------------------------------------------------------------------
// Box beam: 200-250 mm hollow beam
// ----------------------------------------------------------------------

// --- parameters (mm) ---
beam_l = 240;             // beam length, X
beam_w = 50;              // beam width, Y
beam_h = 50;              // beam height, Z
wall = 4;                 // wall thickness
fit_tol = 0.1;            // tolerance for press fits, mm
free_tol = 0.3;           // tolerance for clearance fits, mm

difference() {
  cube([beam_l, beam_w, beam_h]);
  translate([-1, wall, wall])
    cube([beam_l + 2, beam_w - 2 * wall, beam_h - 2 * wall]);
}
