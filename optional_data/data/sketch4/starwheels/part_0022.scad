$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 5-point blunt, R30
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 5;             // number of points / teeth
r_out = 30;               // tip radius
r_in = 19.5;              // root radius
bore_r = 5;               // centre bore radius
plate_t = 5;              // plate thickness, Z (extrusion height)
bore_d = 10;              // centre bore diameter

profile = [[54.271, 28.532], [40.046, 39.994], [33.541, 57.063], [18.245, 47.077], [0, 46.165], [4.771, 28.532], [0, 10.898], [18.245, 9.986], [33.541, 0], [40.046, 17.07]];  // primary outline, 10 points, counter clockwise
void_1 = [[29.179, 29.486], [28.556, 31.107], [27.417, 32.417], [25.898, 33.259], [24.183, 33.531], [22.479, 33.2], [20.99, 32.305], [19.897, 30.956], [19.332, 29.314], [19.362, 27.578], [19.985, 25.957], [21.124, 24.646], [22.643, 23.804], [24.358, 23.532], [26.062, 23.864], [27.551, 24.758], [28.644, 26.108], [29.209, 27.75]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
