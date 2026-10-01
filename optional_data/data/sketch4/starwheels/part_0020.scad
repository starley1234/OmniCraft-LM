$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 6-point star, R30
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 6;             // number of points / teeth
r_out = 30;               // tip radius
r_in = 15;                // root radius
bore_r = 4;               // centre bore radius
plate_t = 8;              // plate thickness, Z (extrusion height)
bore_d = 8;               // centre bore diameter

profile = [[0, 25.981], [17.01, 18.481], [15, 0], [30, 10.981], [45, 0], [42.99, 18.481], [60, 25.981], [42.99, 33.481], [45, 51.962], [30, 40.981], [15, 51.962], [17.01, 33.481]];  // primary outline, 12 points, counter clockwise
void_1 = [[33.927, 26.744], [33.429, 28.041], [32.517, 29.089], [31.302, 29.763], [29.93, 29.98], [28.567, 29.715], [27.376, 29], [26.502, 27.92], [26.049, 26.606], [26.073, 25.218], [26.571, 23.921], [27.483, 22.872], [28.698, 22.199], [30.07, 21.981], [31.433, 22.246], [32.624, 22.962], [33.498, 24.042], [33.951, 25.355]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
