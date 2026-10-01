$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 5-point star, R30
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 5;             // number of points / teeth
r_out = 30;               // tip radius
r_in = 15;                // root radius
bore_r = 6;               // centre bore radius
plate_t = 8;              // plate thickness, Z (extrusion height)
bore_d = 12;              // centre bore diameter
fit_tol = 0.02;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

profile = [[54.271, 28.532], [36.406, 37.348], [33.541, 57.063], [19.635, 42.798], [0, 46.165], [9.271, 28.532], [0, 10.898], [19.635, 14.266], [33.541, 0], [36.406, 19.715]];  // primary outline, 10 points, counter clockwise
void_1 = [[30.16, 29.677], [29.414, 31.622], [28.046, 33.195], [26.224, 34.205], [24.166, 34.531], [22.12, 34.133], [20.334, 33.06], [19.023, 31.441], [18.344, 29.47], [18.381, 27.387], [19.128, 25.441], [20.495, 23.869], [22.317, 22.859], [24.375, 22.533], [26.421, 22.93], [28.207, 24.003], [29.518, 25.623], [30.197, 27.593]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
