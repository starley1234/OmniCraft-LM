$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 5-point blunt, R35
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 5;             // number of points / teeth
r_out = 35;               // tip radius
r_in = 22.75;             // root radius
bore_r = 4;               // centre bore radius
plate_t = 6;              // plate thickness, Z (extrusion height)
bore_d = 8;               // centre bore diameter
fit_tol = 0.05;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

profile = [[0, 33.287], [16.595, 19.915], [24.184, 0], [42.03, 11.65], [63.316, 12.714], [57.75, 33.287], [63.316, 53.859], [42.03, 54.924], [24.184, 66.574], [16.595, 46.659]];  // primary outline, 10 points, counter clockwise
void_1 = [[38.927, 34.05], [38.429, 35.347], [37.517, 36.396], [36.302, 37.069], [34.93, 37.286], [33.567, 37.021], [32.376, 36.306], [31.502, 35.226], [31.049, 33.913], [31.073, 32.524], [31.571, 31.227], [32.483, 30.178], [33.698, 29.505], [35.07, 29.288], [36.433, 29.553], [37.624, 30.268], [38.498, 31.348], [38.951, 32.661]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
