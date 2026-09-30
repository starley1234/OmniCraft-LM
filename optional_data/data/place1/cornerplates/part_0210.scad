$fn = 32;

// ----------------------------------------------------------------------
// Corner plate 110 x 60 x 5
// 3 holes, centres taken from the edge offset
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate = [110, 60, 5];  // overall size (x, y, z)
holes = 3;             // number of holes the drawing asks for
hole_d = 6.6;          // hole diameter
edge = 15;             // hole centre offset from the plate edge

// --- derived feature positions (mm) ---
corner_x = plate[0] / 2 - edge;  // = 40   corner hole X
corner_y = plate[1] / 2 - edge;  // = 15   corner hole Y
feature_centers = [
  [corner_x, corner_y],
  [-corner_x, corner_y],
  [-corner_x, -corner_y]
];   // hole centres the loop below drills

// plate outline, every hole drilled through with the same cutters
difference() {
  cube(plate, center = true);
  for (centre = feature_centers)
    translate([centre[0], centre[1], 0])
      cylinder(d = hole_d, h = plate[2] + 2, center = true);
}
