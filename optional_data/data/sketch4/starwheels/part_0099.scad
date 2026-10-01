$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 7-point blunt, R35
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 7;             // number of points / teeth
r_out = 35;               // tip radius
r_in = 22.75;             // root radius
bore_r = 5;               // centre bore radius
plate_t = 6;              // plate thickness, Z (extrusion height)
bore_d = 10;              // centre bore diameter

profile = [[34.122, 66.534], [24.252, 52.031], [6.758, 53.356], [11.943, 36.596], [0, 23.746], [16.336, 17.35], [18.937, 0], [34.122, 8.784], [49.308, 0], [51.909, 17.35], [68.245, 23.746], [56.302, 36.596], [61.487, 53.356], [43.993, 52.031]];  // primary outline, 14 points, counter clockwise
void_1 = [[39.031, 32.488], [38.408, 34.109], [37.269, 35.42], [35.75, 36.262], [34.035, 36.533], [32.331, 36.202], [30.842, 35.307], [29.749, 33.958], [29.184, 32.316], [29.214, 30.58], [29.837, 28.959], [30.976, 27.648], [32.495, 26.806], [34.21, 26.535], [35.914, 26.866], [37.403, 27.76], [38.496, 29.11], [39.061, 30.752]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
