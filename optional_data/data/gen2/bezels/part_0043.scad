$fn = 32;

// ----------------------------------------------------------------------
// Display bezel: 180 x 40 mm frame, opening 156x16 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 180;             // frame outside length, X
width = 40;               // frame outside width, Y
frame_w = 12;             // frame width
thickness = 8;            // frame thickness
corner_r = 4;             // outside corner radius
chamfer = 0.9;            // outer wall taper
funnel = 0.9;             // inner opening taper
opening_l = 156;          // opening length
opening_w = 16;           // opening width
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
