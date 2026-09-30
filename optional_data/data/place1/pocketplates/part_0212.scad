$fn = 32;

// ----------------------------------------------------------------------
// Pocket plate 63 x 63 x 20
// 2 x 2 pockets 26 mm square, 17 mm deep
// ----------------------------------------------------------------------

// --- parameters (mm) ---
thickness = 20;  // plate thickness
floor_t = 3;     // material left under each pocket
pocket = 26;     // pocket side length
pitch_x = 31;    // pocket pitch along X
pitch_y = 31;    // pocket pitch along Y
cols = 2;        // pockets per row
rows = 2;        // rows of pockets

// --- derived feature positions (mm) ---
depth = thickness - floor_t;        // = 17   pocket depth, down to the floor
span_x = (cols - 1) * pitch_x;      // = 31   distance between outer pockets
span_y = (rows - 1) * pitch_y;      // = 31   distance between outer pocket rows
origin_x = -span_x / 2;             // = -15.5   X of the first pocket
origin_y = -span_y / 2;             // = -15.5   Y of the first pocket
plate = [span_x + pocket + 6, span_y + pocket + 6, thickness];  // = [63, 63, 20]   overall size: pockets plus 3 mm of wall on each side
feature_centers = [
  [origin_x + 0 * pitch_x, origin_y + 0 * pitch_y],
  [origin_x + 1 * pitch_x, origin_y + 0 * pitch_y],
  [origin_x + 0 * pitch_x, origin_y + 1 * pitch_y],
  [origin_x + 1 * pitch_x, origin_y + 1 * pitch_y]
];   // pocket centres, used verbatim by the cutter loop

// plate outline, then one pocket per centre in feature_centers
difference() {
  cube(plate, center = true);
  for (centre = feature_centers)
    translate([centre[0] - pocket / 2, centre[1] - pocket / 2, plate[2] / 2 - depth])
      cube([pocket, pocket, depth + 1]);  // centred on the declared pocket centre
}
