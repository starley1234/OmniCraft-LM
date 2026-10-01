$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 6-point star, R40
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 6;             // number of points / teeth
r_out = 40;               // tip radius
r_in = 20;                // root radius
bore_r = 5;               // centre bore radius
plate_t = 8;              // plate thickness, Z (extrusion height)
bore_d = 10;              // centre bore diameter

profile = [[80, 34.641], [57.321, 44.641], [60, 69.282], [40, 54.641], [20, 69.282], [22.679, 44.641], [0, 34.641], [22.679, 24.641], [20, 0], [40, 14.641], [60, 0], [57.321, 24.641]];  // primary outline, 12 points, counter clockwise
void_1 = [[44.908, 35.595], [44.286, 37.216], [43.147, 38.527], [41.628, 39.369], [39.913, 39.64], [38.208, 39.309], [36.72, 38.415], [35.627, 37.065], [35.062, 35.423], [35.092, 33.687], [35.714, 32.066], [36.853, 30.755], [38.372, 29.913], [40.087, 29.642], [41.792, 29.973], [43.28, 30.867], [44.373, 32.217], [44.938, 33.859]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
