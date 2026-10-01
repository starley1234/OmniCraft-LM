$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 8-point ratchet, R45
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 8;             // number of points / teeth
r_out = 45;               // tip radius
r_in = 24.75;             // root radius
bore_r = 6;               // centre bore radius
plate_t = 8;              // plate thickness, Z (extrusion height)
bore_d = 12;              // centre bore diameter
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.5;           // declared free tolerance (prompt contract)

profile = [[19.007, 43.757], [0, 33.252], [21.28, 33.395], [26.256, 26.256], [20.244, 5.388], [35.19, 20.536], [43.757, 19.007], [54.262, 0], [54.118, 21.28], [61.258, 26.256], [82.125, 20.244], [66.977, 35.19], [68.507, 43.757], [87.513, 54.262], [66.233, 54.118], [61.258, 61.258], [67.269, 82.125], [52.323, 66.977], [43.757, 68.507], [33.252, 87.513], [33.395, 66.233], [26.256, 61.258], [5.388, 67.269], [20.536, 52.323]];  // primary outline, 24 points, counter clockwise
void_1 = [[49.646, 44.902], [48.9, 46.847], [47.533, 48.42], [45.71, 49.43], [43.652, 49.756], [41.606, 49.358], [39.82, 48.285], [38.509, 46.666], [37.831, 44.695], [37.867, 42.612], [38.614, 40.666], [39.981, 39.094], [41.803, 38.084], [43.861, 37.758], [45.907, 38.155], [47.693, 39.228], [49.004, 40.848], [49.683, 42.818]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
