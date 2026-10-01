$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 5-point blunt, R35
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 5;             // number of points / teeth
r_out = 35;               // tip radius
r_in = 24.5;              // root radius
bore_r = 4;               // centre bore radius
plate_t = 8;              // plate thickness, Z (extrusion height)
bore_d = 8;               // centre bore diameter

profile = [[63.316, 33.287], [48.137, 47.688], [39.131, 66.574], [20.745, 56.588], [0, 53.859], [3.816, 33.287], [0, 12.714], [20.745, 9.986], [39.131, 0], [48.137, 18.886]];  // primary outline, 10 points, counter clockwise
void_1 = [[32.242, 34.05], [31.744, 35.347], [30.833, 36.396], [29.618, 37.069], [28.246, 37.286], [26.882, 37.021], [25.691, 36.306], [24.817, 35.226], [24.365, 33.913], [24.389, 32.524], [24.887, 31.227], [25.798, 30.178], [27.013, 29.505], [28.385, 29.288], [29.749, 29.553], [30.94, 30.268], [31.814, 31.348], [32.266, 32.661]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
