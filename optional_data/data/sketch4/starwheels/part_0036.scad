$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 5-point blunt, R45
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 5;             // number of points / teeth
r_out = 45;               // tip radius
r_in = 27;                // root radius
bore_r = 5;               // centre bore radius
plate_t = 5;              // plate thickness, Z (extrusion height)
bore_d = 10;              // centre bore diameter

profile = [[0, 42.798], [23.157, 26.927], [31.094, 0], [53.343, 17.119], [81.406, 16.347], [72, 42.798], [81.406, 69.248], [53.343, 68.476], [31.094, 85.595], [23.157, 58.668]];  // primary outline, 10 points, counter clockwise
void_1 = [[49.908, 43.752], [49.286, 45.373], [48.147, 46.683], [46.628, 47.525], [44.913, 47.797], [43.208, 47.465], [41.72, 46.571], [40.627, 45.222], [40.062, 43.58], [40.092, 41.843], [40.714, 40.222], [41.853, 38.912], [43.372, 38.07], [45.087, 37.798], [46.792, 38.13], [48.28, 39.024], [49.373, 40.373], [49.938, 42.015]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
