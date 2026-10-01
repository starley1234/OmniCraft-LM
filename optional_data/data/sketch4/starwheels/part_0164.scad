$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 7-point star, R30
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 7;             // number of points / teeth
r_out = 30;               // tip radius
r_in = 18;                // root radius
bore_r = 4;               // centre bore radius
plate_t = 8;              // plate thickness, Z (extrusion height)
bore_d = 8;               // centre bore diameter

profile = [[57.029, 29.248], [43.247, 37.058], [45.734, 52.703], [31.034, 46.797], [20.353, 58.496], [15.806, 43.321], [0, 42.264], [9.029, 29.248], [0, 16.231], [15.806, 15.175], [20.353, 0], [31.034, 11.699], [45.734, 5.793], [43.247, 21.438]];  // primary outline, 14 points, counter clockwise
void_1 = [[30.956, 30.011], [30.458, 31.308], [29.546, 32.356], [28.331, 33.03], [26.959, 33.247], [25.596, 32.982], [24.405, 32.267], [23.531, 31.187], [23.078, 29.874], [23.103, 28.485], [23.6, 27.188], [24.512, 26.139], [25.727, 25.466], [27.099, 25.248], [28.463, 25.514], [29.653, 26.229], [30.528, 27.309], [30.98, 28.622]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
