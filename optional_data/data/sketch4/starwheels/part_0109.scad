$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 7-point blunt, R30
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 7;             // number of points / teeth
r_out = 30;               // tip radius
r_in = 19.5;              // root radius
bore_r = 5;               // centre bore radius
plate_t = 6;              // plate thickness, Z (extrusion height)
bore_d = 10;              // centre bore diameter

profile = [[57.029, 29.248], [44.598, 37.709], [45.734, 52.703], [31.368, 48.259], [20.353, 58.496], [14.871, 44.494], [0, 42.264], [7.529, 29.248], [0, 16.231], [14.871, 14.002], [20.353, 0], [31.368, 10.237], [45.734, 5.793], [44.598, 20.787]];  // primary outline, 14 points, counter clockwise
void_1 = [[31.937, 30.202], [31.315, 31.823], [30.176, 33.134], [28.657, 33.975], [26.942, 34.247], [25.237, 33.916], [23.749, 33.021], [22.656, 31.672], [22.091, 30.03], [22.121, 28.294], [22.743, 26.673], [23.882, 25.362], [25.401, 24.52], [27.116, 24.249], [28.821, 24.58], [30.309, 25.474], [31.402, 26.824], [31.968, 28.466]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
