$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 7-point blunt, R40
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 7;             // number of points / teeth
r_out = 40;               // tip radius
r_in = 28;                // root radius
bore_r = 5;               // centre bore radius
plate_t = 8;              // plate thickness, Z (extrusion height)
bore_d = 10;              // centre bore diameter

profile = [[0, 38.997], [14.773, 26.848], [15.06, 7.724], [33.769, 11.699], [48.901, 0], [57.458, 17.106], [76.039, 21.642], [68, 38.997], [76.039, 56.352], [57.458, 60.888], [48.901, 77.994], [33.769, 66.295], [15.06, 70.27], [14.773, 51.146]];  // primary outline, 14 points, counter clockwise
void_1 = [[44.908, 39.951], [44.286, 41.572], [43.147, 42.883], [41.628, 43.725], [39.913, 43.996], [38.208, 43.665], [36.72, 42.771], [35.627, 41.421], [35.062, 39.779], [35.092, 38.043], [35.714, 36.422], [36.853, 35.111], [38.372, 34.27], [40.087, 33.998], [41.792, 34.329], [43.28, 35.224], [44.373, 36.573], [44.938, 38.215]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
