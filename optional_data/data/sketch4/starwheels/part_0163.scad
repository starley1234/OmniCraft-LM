$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 8-point ratchet, R35
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 8;             // number of points / teeth
r_out = 35;               // tip radius
r_in = 17.5;              // root radius
bore_r = 4;               // centre bore radius
plate_t = 5;              // plate thickness, Z (extrusion height)
bore_d = 8;               // centre bore diameter
fit_tol = 0.05;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

profile = [[16.533, 34.033], [0, 25.862], [18.14, 26.706], [21.659, 21.659], [15.745, 4.191], [27.976, 17.615], [34.033, 16.533], [42.204, 0], [41.359, 18.14], [46.407, 21.659], [63.875, 15.745], [50.451, 27.976], [51.533, 34.033], [68.066, 42.204], [49.925, 41.359], [46.407, 46.407], [52.32, 63.875], [40.09, 50.451], [34.033, 51.533], [25.862, 68.066], [26.706, 49.925], [21.659, 46.407], [4.191, 52.32], [17.615, 40.09]];  // primary outline, 24 points, counter clockwise
void_1 = [[37.959, 34.796], [37.462, 36.093], [36.55, 37.142], [35.335, 37.815], [33.963, 38.032], [32.599, 37.767], [31.409, 37.052], [30.534, 35.972], [30.082, 34.659], [30.106, 33.27], [30.604, 31.973], [31.516, 30.924], [32.731, 30.251], [34.103, 30.034], [35.466, 30.299], [36.657, 31.014], [37.531, 32.094], [37.984, 33.407]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
