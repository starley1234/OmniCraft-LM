$fn = 32;

// ----------------------------------------------------------------------
// Corner plate 190 x 45 x 10
// 3 holes, centres taken from the edge offset
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate = [190, 45, 10];  // overall size (x, y, z)
holes = 3;              // number of holes the drawing asks for
hole_d = 8.4;           // hole diameter
edge = 10.5;            // hole centre offset from the plate edge

// --- derived feature positions (mm) ---
corner_x = plate[0] / 2 - edge;  // = 84.5   corner hole X
corner_y = plate[1] / 2 - edge;  // = 12   corner hole Y
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
