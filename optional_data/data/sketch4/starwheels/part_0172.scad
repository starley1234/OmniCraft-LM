$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 6-point star, R40
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 6;             // number of points / teeth
r_out = 40;               // tip radius
r_in = 24;                // root radius
bore_r = 4;               // centre bore radius
plate_t = 5;              // plate thickness, Z (extrusion height)
bore_d = 8;               // centre bore diameter
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.3;           // declared free tolerance (prompt contract)

profile = [[0, 34.641], [19.215, 22.641], [20, 0], [40, 10.641], [60, 0], [60.785, 22.641], [80, 34.641], [60.785, 46.641], [60, 69.282], [40, 58.641], [20, 69.282], [19.215, 46.641]];  // primary outline, 12 points, counter clockwise
void_1 = [[43.927, 35.404], [43.429, 36.701], [42.517, 37.75], [41.302, 38.423], [39.93, 38.64], [38.567, 38.375], [37.376, 37.66], [36.502, 36.58], [36.049, 35.267], [36.073, 33.878], [36.571, 32.581], [37.483, 31.532], [38.698, 30.859], [40.07, 30.642], [41.433, 30.907], [42.624, 31.622], [43.498, 32.702], [43.951, 34.015]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
