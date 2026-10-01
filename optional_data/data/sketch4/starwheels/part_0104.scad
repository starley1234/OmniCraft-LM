$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 7-point star, R35
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 7;             // number of points / teeth
r_out = 35;               // tip radius
r_in = 19.25;             // root radius
bore_r = 5;               // centre bore radius
plate_t = 5;              // plate thickness, Z (extrusion height)
bore_d = 10;              // centre bore diameter

profile = [[66.534, 34.122], [48.878, 42.475], [53.356, 61.487], [35.817, 52.89], [23.746, 68.245], [19.532, 49.173], [0, 49.308], [12.284, 34.122], [0, 18.937], [19.532, 19.072], [23.746, 0], [35.817, 15.355], [53.356, 6.758], [48.878, 25.77]];  // primary outline, 14 points, counter clockwise
void_1 = [[36.442, 35.077], [35.82, 36.698], [34.681, 38.008], [33.162, 38.85], [31.447, 39.122], [29.742, 38.79], [28.254, 37.896], [27.161, 36.547], [26.595, 34.905], [26.626, 33.168], [27.248, 31.547], [28.387, 30.237], [29.906, 29.395], [31.621, 29.123], [33.326, 29.455], [34.814, 30.349], [35.907, 31.698], [36.472, 33.34]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
