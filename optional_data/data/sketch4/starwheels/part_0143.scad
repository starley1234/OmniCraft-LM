$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 8-point blunt, R35
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 8;             // number of points / teeth
r_out = 35;               // tip radius
r_in = 24.5;              // root radius
bore_r = 4;               // centre bore radius
plate_t = 5;              // plate thickness, Z (extrusion height)
bore_d = 8;               // centre bore diameter
fit_tol = 0.02;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

profile = [[35, 70], [25.624, 57.635], [10.251, 59.749], [12.365, 44.376], [0, 35], [12.365, 25.624], [10.251, 10.251], [25.624, 12.365], [35, 0], [44.376, 12.365], [59.749, 10.251], [57.635, 25.624], [70, 35], [57.635, 44.376], [59.749, 59.749], [44.376, 57.635]];  // primary outline, 16 points, counter clockwise
void_1 = [[38.927, 35.763], [38.429, 37.06], [37.517, 38.109], [36.302, 38.782], [34.93, 38.999], [33.567, 38.734], [32.376, 38.019], [31.502, 36.939], [31.049, 35.626], [31.073, 34.237], [31.571, 32.94], [32.483, 31.891], [33.698, 31.218], [35.07, 31.001], [36.433, 31.266], [37.624, 31.981], [38.498, 33.061], [38.951, 34.374]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
