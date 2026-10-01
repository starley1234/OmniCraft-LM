$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 8-point ratchet, R45
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 8;             // number of points / teeth
r_out = 45;               // tip radius
r_in = 27;                // root radius
bore_r = 4;               // centre bore radius
plate_t = 8;              // plate thickness, Z (extrusion height)
bore_d = 8;               // centre bore diameter
fit_tol = 0.05;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

profile = [[43.757, 70.757], [33.252, 87.513], [32.453, 68.277], [24.665, 62.849], [5.388, 67.269], [18.425, 53.102], [16.757, 43.757], [0, 33.252], [19.237, 32.453], [24.665, 24.665], [20.244, 5.388], [34.411, 18.425], [43.757, 16.757], [54.262, 0], [55.06, 19.237], [62.849, 24.665], [82.125, 20.244], [69.088, 34.411], [70.757, 43.757], [87.513, 54.262], [68.277, 55.06], [62.849, 62.849], [67.269, 82.125], [53.102, 69.088]];  // primary outline, 24 points, counter clockwise
void_1 = [[47.683, 44.52], [47.185, 45.817], [46.274, 46.865], [45.059, 47.539], [43.687, 47.756], [42.323, 47.491], [41.132, 46.775], [40.258, 45.696], [39.806, 44.382], [39.83, 42.993], [40.328, 41.696], [41.239, 40.648], [42.454, 39.975], [43.826, 39.757], [45.19, 40.022], [46.381, 40.738], [47.255, 41.817], [47.707, 43.131]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
