$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 7-point blunt, R30
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 7;             // number of points / teeth
r_out = 30;               // tip radius
r_in = 19.5;              // root radius
bore_r = 6;               // centre bore radius
plate_t = 6;              // plate thickness, Z (extrusion height)
bore_d = 12;              // centre bore diameter
fit_tol = 0.05;           // declared fit tolerance (prompt contract)
free_tol = 0.3;           // declared free tolerance (prompt contract)

profile = [[57.029, 29.248], [44.598, 37.709], [45.734, 52.703], [31.368, 48.259], [20.353, 58.496], [14.871, 44.494], [0, 42.264], [7.529, 29.248], [0, 16.231], [14.871, 14.002], [20.353, 0], [31.368, 10.237], [45.734, 5.793], [44.598, 20.787]];  // primary outline, 14 points, counter clockwise
void_1 = [[32.919, 30.393], [32.172, 32.338], [30.805, 33.911], [28.982, 34.921], [26.924, 35.247], [24.879, 34.849], [23.093, 33.776], [21.781, 32.157], [21.103, 30.186], [21.139, 28.103], [21.886, 26.158], [23.253, 24.585], [25.076, 23.575], [27.134, 23.249], [29.179, 23.646], [30.965, 24.72], [32.277, 26.339], [32.955, 28.309]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
