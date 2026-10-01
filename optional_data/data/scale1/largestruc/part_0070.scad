$fn = 32;

// ----------------------------------------------------------------------
// Box beam: 200-250 mm hollow beam
// ----------------------------------------------------------------------

// --- parameters (mm) ---
beam_l = 220;             // beam length, X
beam_w = 40;              // beam width, Y
beam_h = 30;              // beam height, Z
wall = 5;                 // wall thickness

difference() {
  cube([beam_l, beam_w, beam_h]);
  translate([-1, wall, wall])
    cube([beam_l + 2, beam_w - 2 * wall, beam_h - 2 * wall]);
}
