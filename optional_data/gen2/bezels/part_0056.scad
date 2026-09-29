$fn = 32;

// ----------------------------------------------------------------------
// Display bezel: 60 x 60 mm frame, opening 36x36 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 60;              // frame outside length, X
width = 60;               // frame outside width, Y
frame_w = 12;             // frame width
thickness = 12;           // frame thickness
corner_r = 4;             // outside corner radius
chamfer = 0.85;           // outer wall taper
funnel = 0.94;            // inner opening taper
opening_l = 36;           // opening length
opening_w = 36;           // opening width
inner_r = 2;              // opening corner radius

/* rounded-rectangle outlines, generated with loops */
module rounded_ring(l_nom, w_nom, r) {
  hull() {
    for (sx = [-1, 1]) for (sy = [-1, 1])
      translate([sx * (l_nom / 2 - r), sy * (w_nom / 2 - r)]) circle(r = r);
  }
}

difference() {
  /* frame body, drafted so the outer edge is a variable-depth chamfer */
  linear_extrude(height = thickness, scale = chamfer)
    rounded_ring(length, width, corner_r);
  /* viewing opening, drafted the other way for a funnel edge */
  linear_extrude(height = thickness + 2, scale = funnel)
    translate([0, 0, -1]) rounded_ring(opening_l, opening_w, inner_r);
}
