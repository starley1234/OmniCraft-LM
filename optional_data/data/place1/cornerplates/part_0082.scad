$fn = 32;

// ----------------------------------------------------------------------
// Corner plate 190 x 60 x 10
// 4 holes, centres taken from the edge offset
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate = [190, 60, 10];   // overall size (x, y, z)
holes = 4;               // number of holes the drawing asks for
bore_d = 4.5;            // nominal hole diameter from the drawing
print_allowance = 0.15;  // clearance added for printing
edge = 10;               // hole centre offset from the plate edge

// --- derived feature positions (mm) ---
hole_d = bore_d + print_allowance;  // = 4.65   hole diameter as printed
corner_x = plate[0] / 2 - edge;     // = 85   corner hole X
corner_y = plate[1] / 2 - edge;     // = 20   corner hole Y
feature_centers = [
  [corner_x, corner_y],
  [-corner_x, corner_y],
  [-corner_x, -corner_y],
  [corner_x, -corner_y]
];   // hole centres the loop below drills

// plate outline, every hole drilled through with the same cutters
difference() {
  cube(plate, center = true);
  for (centre = feature_centers)
    translate([centre[0], centre[1], 0])
      cylinder(d = hole_d, h = plate[2] + 2, center = true);
}
