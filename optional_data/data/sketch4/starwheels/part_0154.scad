$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 8-point ratchet, R40
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 8;             // number of points / teeth
r_out = 40;               // tip radius
r_in = 24;                // root radius
bore_r = 4;               // centre bore radius
plate_t = 8;              // plate thickness, Z (extrusion height)
bore_d = 8;               // centre bore diameter
fit_tol = 0.05;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

profile = [[14.895, 38.895], [0, 29.557], [17.099, 28.847], [21.924, 21.924], [17.995, 4.789], [30.588, 16.378], [38.895, 14.895], [48.233, 0], [48.943, 17.099], [55.865, 21.924], [73, 17.995], [61.411, 30.588], [62.895, 38.895], [77.79, 48.233], [60.69, 48.943], [55.865, 55.865], [59.795, 73], [47.202, 61.411], [38.895, 62.895], [29.557, 77.79], [28.847, 60.69], [21.924, 55.865], [4.789, 59.795], [16.378, 47.202]];  // primary outline, 24 points, counter clockwise
void_1 = [[42.821, 39.658], [42.323, 40.955], [41.412, 42.003], [40.197, 42.677], [38.825, 42.894], [37.461, 42.629], [36.271, 41.914], [35.396, 40.834], [34.944, 39.521], [34.968, 38.132], [35.466, 36.835], [36.378, 35.786], [37.593, 35.113], [38.965, 34.895], [40.328, 35.16], [41.519, 35.876], [42.393, 36.956], [42.846, 38.269]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
