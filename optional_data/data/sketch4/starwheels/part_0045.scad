$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 5-point blunt, R35
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 5;             // number of points / teeth
r_out = 35;               // tip radius
r_in = 24.5;              // root radius
bore_r = 4;               // centre bore radius
plate_t = 6;              // plate thickness, Z (extrusion height)
bore_d = 8;               // centre bore diameter
fit_tol = 0.05;           // declared fit tolerance (prompt contract)
free_tol = 0.3;           // declared free tolerance (prompt contract)

profile = [[33.287, 63.316], [18.886, 48.137], [0, 39.131], [9.986, 20.745], [12.714, 0], [33.287, 3.816], [53.859, 0], [56.588, 20.745], [66.574, 39.131], [47.688, 48.137]];  // primary outline, 10 points, counter clockwise
void_1 = [[37.213, 29.079], [36.716, 30.376], [35.804, 31.424], [34.589, 32.098], [33.217, 32.315], [31.854, 32.05], [30.663, 31.334], [29.788, 30.255], [29.336, 28.941], [29.36, 27.552], [29.858, 26.255], [30.77, 25.207], [31.985, 24.534], [33.357, 24.316], [34.72, 24.581], [35.911, 25.297], [36.785, 26.376], [37.238, 27.69]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
