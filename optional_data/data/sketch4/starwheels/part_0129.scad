$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 5-point blunt, R45
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 5;             // number of points / teeth
r_out = 45;               // tip radius
r_in = 29.25;             // root radius
bore_r = 6;               // centre bore radius
plate_t = 6;              // plate thickness, Z (extrusion height)
bore_d = 12;              // centre bore diameter

profile = [[81.406, 42.798], [60.07, 59.99], [50.312, 85.595], [27.367, 70.616], [0, 69.248], [7.156, 42.798], [0, 16.347], [27.367, 14.979], [50.312, 0], [60.07, 25.605]];  // primary outline, 10 points, counter clockwise
void_1 = [[42.296, 43.942], [41.549, 45.888], [40.182, 47.46], [38.359, 48.471], [36.301, 48.797], [34.256, 48.399], [32.469, 47.326], [31.158, 45.706], [30.48, 43.736], [30.516, 41.653], [31.263, 39.707], [32.63, 38.135], [34.452, 37.124], [36.51, 36.798], [38.556, 37.196], [40.342, 38.269], [41.653, 39.889], [42.332, 41.859]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
