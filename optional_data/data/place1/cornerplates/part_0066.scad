$fn = 32;

// ----------------------------------------------------------------------
// Corner plate 130 x 75 x 5
// 8 holes, centres taken from the edge offset
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate = [130, 75, 5];   // overall size (x, y, z)
holes = 8;              // number of holes the drawing asks for
bore_d = 6.6;           // nominal hole diameter from the drawing
print_allowance = 0.2;  // clearance added for printing
edge = 15;              // hole centre offset from the plate edge

// --- derived feature positions (mm) ---
hole_d = bore_d + print_allowance;  // = 6.8   hole diameter as printed
corner_x = plate[0] / 2 - edge;     // = 50   corner hole X
corner_y = plate[1] / 2 - edge;     // = 22.5   corner hole Y
feature_centers = [
  [corner_x, corner_y],
  [-corner_x, corner_y],
  [-corner_x, -corner_y],
  [corner_x, -corner_y],
  [0, corner_y],
  [0, -corner_y],
  [corner_x, 0],
  [-corner_x, 0]
];   // hole centres the loop below drills

// plate outline, every hole drilled through with the same cutters
difference() {
  cube(plate, center = true);
  for (centre = feature_centers)
    translate([centre[0], centre[1], 0])
      cylinder(d = hole_d, h = plate[2] + 2, center = true);
}
