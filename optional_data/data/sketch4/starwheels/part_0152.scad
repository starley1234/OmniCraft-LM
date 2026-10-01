$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 5-point star, R40
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 5;             // number of points / teeth
r_out = 40;               // tip radius
r_in = 20;                // root radius
bore_r = 4;               // centre bore radius
plate_t = 8;              // plate thickness, Z (extrusion height)
bore_d = 8;               // centre bore diameter

profile = [[38.042, 72.361], [26.287, 48.541], [0, 44.721], [19.021, 26.18], [14.531, 0], [38.042, 12.361], [61.554, 0], [57.063, 26.18], [76.085, 44.721], [49.798, 48.541]];  // primary outline, 10 points, counter clockwise
void_1 = [[41.969, 33.124], [41.471, 34.421], [40.56, 35.469], [39.345, 36.143], [37.972, 36.36], [36.609, 36.095], [35.418, 35.38], [34.544, 34.3], [34.092, 32.986], [34.116, 31.597], [34.614, 30.301], [35.525, 29.252], [36.74, 28.579], [38.112, 28.361], [39.476, 28.626], [40.666, 29.342], [41.541, 30.421], [41.993, 31.735]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
