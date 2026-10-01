$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 6-point star, R35
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 6;             // number of points / teeth
r_out = 35;               // tip radius
r_in = 19.25;             // root radius
bore_r = 4;               // centre bore radius
plate_t = 5;              // plate thickness, Z (extrusion height)
bore_d = 8;               // centre bore diameter

profile = [[0, 30.311], [18.329, 20.686], [17.5, 0], [35, 11.061], [52.5, 0], [51.671, 20.686], [70, 30.311], [51.671, 39.936], [52.5, 60.622], [35, 49.561], [17.5, 60.622], [18.329, 39.936]];  // primary outline, 12 points, counter clockwise
void_1 = [[38.927, 31.074], [38.429, 32.371], [37.517, 33.419], [36.302, 34.093], [34.93, 34.31], [33.567, 34.045], [32.376, 33.33], [31.502, 32.25], [31.049, 30.937], [31.073, 29.548], [31.571, 28.251], [32.483, 27.202], [33.698, 26.529], [35.07, 26.311], [36.433, 26.577], [37.624, 27.292], [38.498, 28.372], [38.951, 29.685]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
