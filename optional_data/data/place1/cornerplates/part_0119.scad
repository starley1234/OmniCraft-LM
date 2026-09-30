$fn = 32;

// ----------------------------------------------------------------------
// Corner plate 70 x 75 x 5
// 3 holes, centres taken from the edge offset
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate = [70, 75, 5];  // overall size (x, y, z)
seat_tol = 0.1;       // tolerance at the seating features
free_tol = 0.3;       // general tolerance on the free sizes
holes = 3;            // number of holes the drawing asks for
hole_d = 8.4;         // hole diameter
edge = 10;            // hole centre offset from the plate edge

// --- derived feature positions (mm) ---
corner_x = plate[0] / 2 - edge;  // = 25   corner hole X
corner_y = plate[1] / 2 - edge;  // = 27.5   corner hole Y
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
