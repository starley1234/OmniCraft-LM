$fn = 32;

// ----------------------------------------------------------------------
// Display bezel: 140 x 50 mm frame, opening 124x34 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 140;             // frame outside length, X
width = 50;               // frame outside width, Y
frame_w = 8;              // frame width
thickness = 6;            // frame thickness
corner_r = 4;             // outside corner radius
chamfer = 0.9;            // outer wall taper
funnel = 0.97;            // inner opening taper
opening_l = 124;          // opening length
opening_w = 34;           // opening width
inner_r = 2;              // opening corner radius
hole_d = 3.4;             // mounting screw clearance
holes_per_side = 1;       // holes per short side
hole_inset = 4;           // hole centre inset from the outside edge

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
  /* mounting screws through the frame lands */
  for (sx = [-1, 1]) for (i = [1 : holes_per_side])
    translate([sx * (length / 2 - hole_inset),
               (i - (holes_per_side + 1) / 2) * width * 0.5, -1])
      cylinder(h = thickness + 2, d = hole_d);
}
