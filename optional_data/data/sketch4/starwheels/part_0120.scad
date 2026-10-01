$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 7-point blunt, R35
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 7;             // number of points / teeth
r_out = 35;               // tip radius
r_in = 22.75;             // root radius
bore_r = 6;               // centre bore radius
plate_t = 5;              // plate thickness, Z (extrusion height)
bore_d = 12;              // centre bore diameter

profile = [[66.534, 34.122], [52.031, 43.993], [53.356, 61.487], [36.596, 56.302], [23.746, 68.245], [17.35, 51.909], [0, 49.308], [8.784, 34.122], [0, 18.937], [17.35, 16.336], [23.746, 0], [36.596, 11.943], [53.356, 6.758], [52.031, 24.252]];  // primary outline, 14 points, counter clockwise
void_1 = [[37.424, 35.267], [36.677, 37.213], [35.31, 38.785], [33.487, 39.796], [31.429, 40.122], [29.384, 39.724], [27.598, 38.651], [26.286, 37.031], [25.608, 35.061], [25.644, 32.978], [26.391, 31.032], [27.758, 29.46], [29.581, 28.449], [31.639, 28.123], [33.684, 28.521], [35.47, 29.594], [36.782, 31.214], [37.46, 33.184]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
