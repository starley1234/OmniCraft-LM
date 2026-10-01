$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 8-point ratchet, R40
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 8;             // number of points / teeth
r_out = 40;               // tip radius
r_in = 24;                // root radius
bore_r = 6;               // centre bore radius
plate_t = 6;              // plate thickness, Z (extrusion height)
bore_d = 12;              // centre bore diameter
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.5;           // declared free tolerance (prompt contract)

profile = [[38.895, 62.895], [29.557, 77.79], [28.847, 60.69], [21.924, 55.865], [4.789, 59.795], [16.378, 47.202], [14.895, 38.895], [0, 29.557], [17.099, 28.847], [21.924, 21.924], [17.995, 4.789], [30.588, 16.378], [38.895, 14.895], [48.233, 0], [48.943, 17.099], [55.865, 21.924], [73, 17.995], [61.411, 30.588], [62.895, 38.895], [77.79, 48.233], [60.69, 48.943], [55.865, 55.865], [59.795, 73], [47.202, 61.411]];  // primary outline, 24 points, counter clockwise
void_1 = [[44.785, 40.04], [44.038, 41.985], [42.671, 43.558], [40.848, 44.568], [38.79, 44.894], [36.745, 44.496], [34.958, 43.423], [33.647, 41.804], [32.969, 39.833], [33.005, 37.75], [33.752, 35.805], [35.119, 34.232], [36.941, 33.222], [39, 32.896], [41.045, 33.293], [42.831, 34.367], [44.143, 35.986], [44.821, 37.956]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
