$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 5-point star, R45
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 5;             // number of points / teeth
r_out = 45;               // tip radius
r_in = 24.75;             // root radius
bore_r = 4;               // centre bore radius
plate_t = 6;              // plate thickness, Z (extrusion height)
bore_d = 8;               // centre bore diameter

profile = [[42.798, 81.406], [28.25, 56.429], [0, 50.312], [19.259, 28.758], [16.347, 0], [42.798, 11.656], [69.248, 0], [66.336, 28.758], [85.595, 50.312], [57.345, 56.429]];  // primary outline, 10 points, counter clockwise
void_1 = [[46.724, 37.169], [46.226, 38.466], [45.315, 39.514], [44.1, 40.188], [42.728, 40.405], [41.364, 40.14], [40.173, 39.425], [39.299, 38.345], [38.847, 37.032], [38.871, 35.643], [39.369, 34.346], [40.28, 33.297], [41.495, 32.624], [42.867, 32.406], [44.231, 32.671], [45.422, 33.387], [46.296, 34.467], [46.748, 35.78]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
