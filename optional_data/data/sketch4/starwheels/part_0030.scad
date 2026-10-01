$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 5-point star, R30
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 5;             // number of points / teeth
r_out = 30;               // tip radius
r_in = 15;                // root radius
bore_r = 5;               // centre bore radius
plate_t = 6;              // plate thickness, Z (extrusion height)
bore_d = 10;              // centre bore diameter

profile = [[0, 28.532], [17.865, 19.715], [20.729, 0], [34.635, 14.266], [54.271, 10.898], [45, 28.532], [54.271, 46.165], [34.635, 42.798], [20.729, 57.063], [17.865, 37.348]];  // primary outline, 10 points, counter clockwise
void_1 = [[34.908, 29.486], [34.286, 31.107], [33.147, 32.417], [31.628, 33.259], [29.913, 33.531], [28.208, 33.2], [26.72, 32.305], [25.627, 30.956], [25.062, 29.314], [25.092, 27.578], [25.714, 25.957], [26.853, 24.646], [28.372, 23.804], [30.087, 23.532], [31.792, 23.864], [33.28, 24.758], [34.373, 26.108], [34.938, 27.75]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
