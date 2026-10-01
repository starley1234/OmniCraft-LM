$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 5-point star, R35
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 5;             // number of points / teeth
r_out = 35;               // tip radius
r_in = 21;                // root radius
bore_r = 4;               // centre bore radius
plate_t = 6;              // plate thickness, Z (extrusion height)
bore_d = 8;               // centre bore diameter

profile = [[0, 33.287], [18.011, 20.943], [24.184, 0], [41.489, 13.315], [63.316, 12.714], [56, 33.287], [63.316, 53.859], [41.489, 53.259], [24.184, 66.574], [18.011, 45.63]];  // primary outline, 10 points, counter clockwise
void_1 = [[38.927, 34.05], [38.429, 35.347], [37.517, 36.396], [36.302, 37.069], [34.93, 37.286], [33.567, 37.021], [32.376, 36.306], [31.502, 35.226], [31.049, 33.913], [31.073, 32.524], [31.571, 31.227], [32.483, 30.178], [33.698, 29.505], [35.07, 29.288], [36.433, 29.553], [37.624, 30.268], [38.498, 31.348], [38.951, 32.661]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
