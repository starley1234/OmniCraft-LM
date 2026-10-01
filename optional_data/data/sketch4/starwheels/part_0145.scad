$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 8-point ratchet, R35
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 8;             // number of points / teeth
r_out = 35;               // tip radius
r_in = 19.25;             // root radius
bore_r = 4;               // centre bore radius
plate_t = 6;              // plate thickness, Z (extrusion height)
bore_d = 8;               // centre bore diameter
fit_tol = 0.05;           // declared fit tolerance (prompt contract)
free_tol = 0.3;           // declared free tolerance (prompt contract)

profile = [[34.033, 53.283], [25.862, 68.066], [25.974, 51.515], [20.421, 47.645], [4.191, 52.32], [15.973, 40.696], [14.783, 34.033], [0, 25.862], [16.551, 25.974], [20.421, 20.421], [15.745, 4.191], [27.37, 15.973], [34.033, 14.783], [42.204, 0], [42.092, 16.551], [47.645, 20.421], [63.875, 15.745], [52.093, 27.37], [53.283, 34.033], [68.066, 42.204], [51.515, 42.092], [47.645, 47.645], [52.32, 63.875], [40.696, 52.093]];  // primary outline, 24 points, counter clockwise
void_1 = [[37.959, 34.796], [37.462, 36.093], [36.55, 37.142], [35.335, 37.815], [33.963, 38.032], [32.599, 37.767], [31.409, 37.052], [30.534, 35.972], [30.082, 34.659], [30.106, 33.27], [30.604, 31.973], [31.516, 30.924], [32.731, 30.251], [34.103, 30.034], [35.466, 30.299], [36.657, 31.014], [37.531, 32.094], [37.984, 33.407]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
