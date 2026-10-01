$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 6-point blunt, R45
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 6;             // number of points / teeth
r_out = 45;               // tip radius
r_in = 29.25;             // root radius
bore_r = 5;               // centre bore radius
plate_t = 5;              // plate thickness, Z (extrusion height)
bore_d = 10;              // centre bore diameter

profile = [[0, 38.971], [19.669, 24.346], [22.5, 0], [45, 9.721], [67.5, 0], [70.331, 24.346], [90, 38.971], [70.331, 53.596], [67.5, 77.942], [45, 68.221], [22.5, 77.942], [19.669, 53.596]];  // primary outline, 12 points, counter clockwise
void_1 = [[49.908, 39.925], [49.286, 41.546], [48.147, 42.857], [46.628, 43.699], [44.913, 43.97], [43.208, 43.639], [41.72, 42.745], [40.627, 41.395], [40.062, 39.753], [40.092, 38.017], [40.714, 36.396], [41.853, 35.085], [43.372, 34.244], [45.087, 33.972], [46.792, 34.303], [48.28, 35.198], [49.373, 36.547], [49.938, 38.189]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
