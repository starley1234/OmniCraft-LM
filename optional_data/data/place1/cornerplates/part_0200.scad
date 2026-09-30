$fn = 32;

// ----------------------------------------------------------------------
// Corner plate 190 x 60 x 5
// 6 holes, centres taken from the edge offset
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate = [190, 60, 5];  // overall size (x, y, z)
holes = 6;             // number of holes the drawing asks for
hole_d = 10.5;         // hole diameter
edge = 12;             // hole centre offset from the plate edge

// --- derived feature positions (mm) ---
corner_x = plate[0] / 2 - edge;  // = 83   corner hole X
corner_y = plate[1] / 2 - edge;  // = 18   corner hole Y
feature_centers = [
  [corner_x, corner_y],
  [-corner_x, corner_y],
  [-corner_x, -corner_y],
  [corner_x, -corner_y],
  [0, corner_y],
  [0, -corner_y]
];   // hole centres the loop below drills

// plate outline, every hole drilled through with the same cutters
difference() {
  cube(plate, center = true);
  for (centre = feature_centers)
    translate([centre[0], centre[1], 0])
      cylinder(d = hole_d, h = plate[2] + 2, center = true);
}
